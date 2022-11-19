/// SPDX-License-Identifier: UNLICENSED
/// @author Pelyhe Ádám - BME - MIT
pragma solidity ^0.8.7;

import "./DamageReport.sol";

contract GasInsuranceToken is DamageReport{
    constructor() ERC20("Gas Insurance Token", "GIT") {
        nextReportId = 1;
    }

    // transfer from _address to insurance company feeDifference amount of eHUF
    event SwitchHigherPlan(address indexed _address, uint32 feeDifference);
    // address got utilityTokens amount of utility tokens for switching to a lower plan
    event SwitchLowerPlan(address indexed _address, uint256 utilityTokens);

    mapping(address => uint256) balances;

    // after every remaining days got 10 * ( current plan number - future plan number ) tokens
    function convertPlanToTokens(Insurance memory insurance, uint8 planNumber)
        internal
        view
        returns (uint256)
    {
        uint8 diff = insurance.plan.planNumber - planNumber;
        uint256 remainingSeconds = insurance.nextPayment - block.timestamp;
        uint256 remainingDays = remainingSeconds / 60 / 60 / 24; // number of days left
        return (remainingDays + 1) * diff;
    }

    function changeToHigherPlan(address _address, uint8 _planNumber)
        internal
        ownsInsurance(_address)
    {
        Insurance storage insurance = insurances[_address];
        Plan memory newPlan = createPlan(_planNumber);
        uint32 diff = newPlan.monthlyFee - insurance.plan.monthlyFee;
        emit SwitchHigherPlan(_address, diff);
        
        // if result OK
        insurance.plan = newPlan;
        insurance.nextPayment = block.timestamp + paymentFrequency;
        insurance.suspendDate = insurance.nextPayment + gracePeriod;
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
        Plan memory newPlan = createPlan(_planNumber);
        uint256 tokens = convertPlanToTokens(insurance, _planNumber);
        emit SwitchLowerPlan(_address, tokens);

        // if results OK
        insurance.plan = newPlan;
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
            Plan memory newPlan = createPlan(_plan);
            insurance.plan = newPlan;
            payMonthlyFee(_address);
        }
    }
}
