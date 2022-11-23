/// SPDX-License-Identifier: UNLICENSED
/// @author Pelyhe Ádám - BME - MIT
pragma solidity ^0.8.7;

import "./DamageReport.sol";

contract GasInsuranceToken is DamageReport{
    constructor() ERC20("Gas Insurance Token", "GIT") {
        nextReportId = 1;
    }

    // transfer from _address to insurance company feeDifference amount of eHUF
    event SwitchHigherPlan(address indexed _address, uint8 indexed planNumber, uint32 indexed feeDifference);
    // address got utilityTokens amount of utility tokens for switching to a lower plan
    event SwitchLowerPlan(address indexed _address, uint8 indexed utilityTokens);


    // after every remaining days got 10 * ( current plan number - future plan number ) tokens
    function convertPlanToTokens(Insurance memory insurance, uint8 planNumber)
        internal
        view
        returns (uint8)
    {
        uint8 diff = insurance.plan.planNumber - planNumber;
        uint256 remainingSeconds = insurance.nextPayment - block.timestamp;
        uint8 remainingDays = uint8(remainingSeconds / 60 / 60 / 24); // number of days left
        return (remainingDays + 1) * diff;
    }

    function changeToHigherPlan(address _address, uint8 _planNumber)
        internal
        ownsInsurance(_address)
    {
        Insurance memory insurance = insurances[_address];
        Plan memory newPlan = createPlan(_planNumber);
        uint32 diff = newPlan.monthlyFee - insurance.plan.monthlyFee;
        emit SwitchHigherPlan(_address, _planNumber, diff);
    }

    function confirmHigherPlanSwitchPayment(address _address, uint8 _planNumber, uint32 diff) 
        external
        ownsInsurance(_address)
    {
        Insurance storage insurance = insurances[_address];

        insurance.plan = createPlan(_planNumber);
        insurance.nextPayment = block.timestamp + paymentFrequency;
        insurance.suspendDate = insurance.nextPayment + gracePeriod;
        emit ConfirmPayment(_address, diff);
    }

    // if there are still some days until the end of the epoch
    // the customer lose some money, beacuse s/he paid a whole epoch
    // and the plan will be changed immediately,
    // thus the remaining days from the epoch will be converted to utility tokens
    // depending on the previous plan
    function changetoLowerPlan(address _address, uint8 _planNumber)
        internal
        ownsInsurance(_address)
    {
        Insurance storage insurance = insurances[_address];
        uint8 tokens = convertPlanToTokens(insurance, _planNumber);
        emit SwitchLowerPlan(_address, uint8(tokens));

        insurance.plan = createPlan(_planNumber);
        insurance.nextPayment = block.timestamp + paymentFrequency;
        insurance.suspendDate = insurance.nextPayment + gracePeriod;
        _mint(_address, tokens);
    }

    function changePlan(address _address, uint8 _plan)
        public
        ownsInsurance(_address)
        isPlanValid(_plan)
        planNotTheSame(_address, _plan)
    {
        Insurance storage insurance = insurances[_address];
        if (insurance.nextPayment > block.timestamp) {  // in the previous epoch
            if (_plan > insurance.plan.planNumber) {
                changeToHigherPlan(_address, _plan);
            } else {
                changetoLowerPlan(_address, _plan);
            }
        } else {
            insurance.plan = createPlan(_plan);
            payMonthlyFee(_address);
        }
    }

    function declareDamageWithTokens(
        address _address,
        string calldata pictureHash,
        string calldata documentHash,
        uint32 damagePrice
    ) external ownsInsurance(_address) isInsuranceStatusActive(_address) {
        uint32 compensation = calculateCompensationWithTokens(
            damagePrice,
            _address
        );
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

    function calculateCompensationWithTokens(uint32 totalDamage, address _address)
        internal
        returns (uint32)
    {
        uint8 compensationPercentage = insurances[_address].plan.compensationPercentage;
        // if more tokens than 100%
        uint32 compensation;
        if (balanceOf(_address) > (100 - compensationPercentage)) {
            compensation = totalDamage;
            _burn(_address, 100-compensationPercentage);
        } else {
            compensation = (totalDamage * (compensationPercentage + uint32(balanceOf(_address))) ) / 100;
            _burn(_address, balanceOf(_address));
        }
        if (compensation > totalDamage) {
            return totalDamage;
        } else {
            return uint32(compensation);
        }
    }
}
