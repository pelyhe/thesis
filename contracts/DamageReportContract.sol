/// SPDX-License-Identifier: UNLICENSED
/// @author Pelyhe Ádám - BME - MIT

pragma solidity ^0.8.7;

import "./GasInsuranceContract.sol";

abstract contract DamageReport is GasInsurance {
    uint32 internal nextReportId;
    uint256 judgementCoold = 1 days;

    constructor() {
        nextReportId = 1;
    }

    event CompensationPayment(address _address, uint256 damagePrice);
    event DamageDeclaration(address _address, Report report);

    struct Report {
        uint32 id;
        bytes pictureIpfsHash;
        bytes documentIpfsHash;
        uint32 damagePrice;
        uint32 compensationPrice;
        uint8 numberOfConfirmations;
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
        require(insurances[_address].judgementCooldown < block.timestamp, "You are on cooldown. Come back later!");
        _;
    }

    function hasReport(address _address) public view returns (bool) {
        if (reports[_address].id > 0) {
            return true;
        }
        return false;
    }

    function declareDamage(
        bytes memory pictureHash,
        bytes memory documentHash,
        uint32 damagePrice
    ) external ownsInsurance(msg.sender) isInsuranceStatusActive(msg.sender) {
        Insurance memory insurance = insurances[msg.sender];
        uint32 compensation = calculateCompensation(
            damagePrice,
            insurance.plan
        );

        Report memory report = Report({
            id: nextReportId,
            pictureIpfsHash: pictureHash,
            documentIpfsHash: documentHash,
            damagePrice: damagePrice,
            compensationPrice: compensation,
            numberOfConfirmations: 0,
            approved: false
        });

        emit DamageDeclaration(msg.sender, report);
        reports[msg.sender] = report;
        report_keys.push(msg.sender);
        nextReportId++;
    }

    function calculateCompensation(uint32 totalDamage, Plan memory plan)
        internal
        pure
        returns (uint32)
    {
        return (totalDamage * plan.compensationPercentage) / 100;
    }

    // the insurance company approves the damage report itself
    function approveReport(address _address)
        external
        onlyOwner
        ownsInsurance(_address)
        reportExists(_address)
    {
        Report storage report = reports[_address];
        report.approved = true;
        approvedReports[_address] = report;
        delete report_keys[report.id-1];       // deletes the element from key, and leave a space there
        delete (reports[_address]);
    }

    // a user confirms the report
    // if s/he is the second, who confirmed it, the report will be approved
    function confirmReport(address _address)
        external
        ownsInsurance(_address)
        reportExists(_address)
        ownsInsurance(msg.sender)
        canJudge(msg.sender)
    {
        Report storage report = reports[_address];
        report.numberOfConfirmations++;
        if (report.numberOfConfirmations > 1) {
            report.approved = true;
            approvedReports[_address] = report;
            delete report_keys[report.id-1];       // deletes the element from key, and leave a space there
            delete (reports[_address]);
        }

        Insurance storage insurance = insurances[msg.sender];
        insurance.numberOfJudgements++;
        if (insurance.numberOfJudgements >= 5) {
            insurance.numberOfJudgements = 0;
            insurance.judgementCooldown = block.timestamp + judgementCoold;
        }
    }

    function refuseReport(address _address)
        external
        ownsInsurance(_address)
        reportExists(_address)
        ownsInsurance(msg.sender)
        canJudge(msg.sender)
    {

        // TODO: what to do if someone refuses a report?

        Insurance storage insurance = insurances[msg.sender];
        insurance.numberOfJudgements++;
        _mint(msg.sender, 1);
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
        Report memory report = approvedReports[_address];
        emit CompensationPayment(_address, report.compensationPrice);
    }

    /*function getRandomDamagePicture() external view returns (address, bytes memory) {
        uint randomIndex = uint(keccak256(abi.encodePacked(block.timestamp))) % report_keys.length;
        address randomAddress = report_keys[randomIndex];
        while (randomAddress == address(0)) {
            randomIndex = uint(keccak256(abi.encodePacked(block.timestamp))) % report_keys.length;
            randomAddress = report_keys[randomIndex];
        }
        
        return (randomAddress, reports[randomAddress].pictureIpfsHash);
    }*/
}
