/// SPDX-License-Identifier: UNLICENSED
/// @author Pelyhe Ádám - BME - MIT

pragma solidity ^0.8.7;

import "./GasInsuranceContract.sol";

abstract contract DamageReport is GasInsurance {
    uint32 internal nextReportId;
    uint256 judgementCoold = 1 days;
    uint32 internal activeReports;

    constructor() {
        nextReportId = 1;
        activeReports = 0;
    }

    event CompensationPayment(address indexed _address, uint256 indexed damagePrice);
    event DamageDeclaration(address indexed _address, uint32 indexed reportId);
    event ReportApproved(uint32 indexed reportId);
    event ReportConfirmed(address indexed reviewer, uint32 indexed reportId);
    event ReportRefused(address indexed reviewer, uint32 indexed reportId);

    struct Report {
        uint32 id;
        string pictureIpfsHash;
        string documentIpfsHash;
        uint32 damagePrice;
        uint32 compensationPrice;
        uint8 numberOfConfirmations;
        address confirmedBy; // to be sure that one person cannot confirm twice
        bool approved;
    }

    // a user can only have one damage report at a time,
    // submitting an other report will overwrite the old one.
    mapping(address => Report) reports; // public key -> Report

    address[] report_keys;

    // approved reports here
    mapping(address => Report) approvedReports;

    modifier reportExists(address _address) {
        require(
            hasReport(_address),
            "No reports can be found to this insurance!"
        );
        _;
    }

    modifier isReportApproved(address _address) {
        require(
            approvedReports[_address].approved,
            "Demage report has not been approved yet!"
        );
        _;
    }

    modifier canJudge(address _address) {
        require(
            insurances[_address].judgementCooldown < block.timestamp,
            "You are on cooldown. Come back later!"
        );
        _;
    }

    modifier confirmedBefore(Report memory report, address _address) {
        require(report.confirmedBy != _address, "You confirmed this before!");
        _;
    }

    function hasReport(address _address) public view returns (bool) {
        if (reports[_address].id > 0) {
            return true;
        }
        return false;
    }

    function declareDamage(
        address _address,
        string memory pictureHash,
        string memory documentHash,
        uint32 damagePrice
    ) external ownsInsurance(_address) isInsuranceStatusActive(_address) {
        Insurance memory insurance = insurances[_address];
        uint32 compensation = (damagePrice * insurance.plan.compensationPercentage) / 100;
        activeReports++;
        Report memory report = Report({
            id: nextReportId,
            pictureIpfsHash: pictureHash,
            documentIpfsHash: documentHash,
            damagePrice: damagePrice,
            compensationPrice: compensation,
            numberOfConfirmations: 0,
            confirmedBy: address(0),
            approved: false
        });

        emit DamageDeclaration(_address, report.id);
        reports[_address] = report;
        report_keys.push(_address);
        nextReportId++;
    }

    // the insurance company approves the damage report itself
    function approveReport(address _address)
        external
        onlyOwner
        ownsInsurance(_address)
        reportExists(_address)
    {
        activeReports--;
        Report storage report = reports[_address];
        emit ReportApproved(report.id);
        report.approved = true;
        approvedReports[_address] = report;
        delete report_keys[report.id - 1]; // deletes the element from key, and leave a space there
        delete (reports[_address]);
    }

    // a user confirms the report
    // if s/he is the second, who confirmed it, the report will be approved
    function confirmReport(address reviewer, address reviewee)
        external
        ownsInsurance(reviewee)
        reportExists(reviewee)
        ownsInsurance(reviewer)
        canJudge(reviewer)
        confirmedBefore(reports[reviewee], reviewer)
    {
        Report storage report = reports[reviewee];
        emit ReportConfirmed(reviewer, report.id);
        report.numberOfConfirmations++;
        _mint(reviewer, 1);
        if (report.numberOfConfirmations > 1) {
            activeReports--;
            report.approved = true;
            approvedReports[reviewee] = report;
            delete report_keys[report.id - 1]; // deletes the element from key, and leave a space there
            delete (reports[reviewee]);
        } else {
            report.confirmedBy = reviewer;
        }

        Insurance storage insurance = insurances[reviewer];
        insurance.numberOfJudgements++;
        if (insurance.numberOfJudgements >= 5) {
            insurance.numberOfJudgements = 0;
            insurance.judgementCooldown = block.timestamp + judgementCoold;
        }
    }

    function refuseReport(address reviewer, address reviewee)
        external
        ownsInsurance(reviewee)
        reportExists(reviewee)
        ownsInsurance(reviewer)
        canJudge(reviewer)
    {
        emit ReportRefused(reviewer, reports[reviewee].id);
        Insurance storage insurance = insurances[reviewer];
        insurance.numberOfJudgements++;
        _mint(reviewer, 1);
        if (insurance.numberOfJudgements >= 5) {
            insurance.numberOfJudgements = 0;
            insurance.judgementCooldown = block.timestamp + judgementCoold;
        }
    }

    function payCompensation(address _address)
        external
        onlyOwner
        isReportApproved(_address)
    {
        emit CompensationPayment(_address, approvedReports[_address].compensationPrice);
    }

    function getRandomDamagePicture()
        external
        view
        returns (address, string memory)
    {
        require(activeReports > 0, "No active damage reports.");
        address randomAddress = address(0);
        uint256 randNonce = 1;
        while (randomAddress == address(0)) {
            uint256 randomIndex = uint256(
                keccak256(
                    abi.encodePacked(block.timestamp, msg.sender, randNonce)
                )
            ) % report_keys.length;
            randNonce++;
            randomAddress = report_keys[randomIndex];
        }

        return (randomAddress, reports[randomAddress].pictureIpfsHash);
    }
}
