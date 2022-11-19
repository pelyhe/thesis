/// SPDX-License-Identifier: UNLICENSED
/// @author Pelyhe Ádám - BME - MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

abstract contract GasInsurance is Ownable, ERC20 {
    uint32 internal nextInsuranceId;

    constructor() {
        nextInsuranceId = 1;
    }

    event MontlyFeePayment(address indexed _address, uint256 _value);

    address damageReportAddress;
    uint256 paymentFrequency = 10 seconds;
    uint256 gracePeriod = 1 minutes;

    struct Plan {
        uint8 planNumber;
        uint32 monthlyFee;
        uint8 compensationPercentage;
    }

    // represents the details of an insurance
    struct Insurance {
        uint32 id;
        bool isActive;
        Plan plan;
        uint256 nextPayment;
        uint256 suspendDate;
        uint256 judgementCooldown;
        uint8 numberOfJudgements;
    }

    mapping(address => Insurance) insurances;

    modifier ownsInsurance(address _address) {
        require(hasInsurance(_address), "You have to own an insurance!");
        _;
    }

    modifier notOwnInsurance(address _address) {
        require(!hasInsurance(_address), "You own an insurance already!");
        _;
    }

    modifier isPlanValid(uint256 _plan) {
        require(_plan > 0 && _plan < 4, "Not a valid plan!");
        _;
    }

    modifier isPaymentDue(address _address) {
        require(
            insurances[_address].nextPayment <= block.timestamp,
            "Not due yet!"
        );
        _;
    }

    modifier canClientBeSuspended(address _address) {
        require(
            insurances[_address].suspendDate < block.timestamp,
            "Cannot be suspended!"
        );
        _;
    }

    modifier isInsuranceStatusActive(address _address) {
        require(insurances[_address].isActive, "Insurance status inactive!");
        _;
    }

    modifier planNotTheSame(address _address, uint8 planNum) {
        require(insurances[_address].plan.planNumber != planNum, "You chose the same plan!");
        _;
    }

    // owner sets the other contract's address
    function setDamageReportContract(address _address) external onlyOwner {
        damageReportAddress = _address;
    }

    // returns if address has insurance or not
    function hasInsurance(address _address) public view returns (bool) {
        if (insurances[_address].id > 0) {
            return true;
        }
        return false;
    }

    function getPlan(address _address) external view ownsInsurance(_address) returns (uint8)  {
        return insurances[_address].plan.planNumber;
    }


    // checks if the insurance status is active or suspended
    function isInsuranceActive(address _address)
        public
        view
        ownsInsurance(_address)
        returns (bool)
    {
        return insurances[_address].isActive;
    }

    function setStatus(address _address, bool _isActive)
        internal
        ownsInsurance(_address)
    {
        insurances[_address].isActive = _isActive;
    }

    // returns a plan object from plan's number
    function createPlan(uint8 planNumber)
        internal
        pure
        isPlanValid(planNumber)
        returns (Plan memory)
    {
        if (planNumber == 1) {
            return
                Plan({
                    planNumber: 1,
                    monthlyFee: 2500,
                    compensationPercentage: 20
                });
        } else if (planNumber == 2) {
            return
                Plan({
                    planNumber: 2,
                    monthlyFee: 4500,
                    compensationPercentage: 50
                });
        } else {
            return
                Plan({
                    planNumber: 3,
                    monthlyFee: 7500,
                    compensationPercentage: 100
                });
        }
    }

    // user takes out an insurance
    function takeOutInsurance(address _address, uint8 _plan)
        external
        isPlanValid(_plan)
        notOwnInsurance(_address)
    {
        uint256 suspendDate = block.timestamp + gracePeriod;
        insurances[_address] = Insurance(
            nextInsuranceId,    // id
            false,      // isActive
            createPlan(_plan),  // plan
            block.timestamp,    // next payment
            suspendDate,    // suspend date
            block.timestamp,    // judgement cooldown timer
            0   // number of judges
        );
        nextInsuranceId++;
        payMonthlyFee(_address);
    }

    function getNextPaymentDate(address _address)
        public
        view
        ownsInsurance(_address)
        returns (uint256)
    {
        return insurances[_address].nextPayment;
    }

    function getMonthlyFee(address _address)
        public
        view
        ownsInsurance(_address)
        returns (uint32)
    {
        return insurances[_address].plan.monthlyFee;
    }

    // msg.sender wants to pay the monthly fee
    function payMonthlyFee(address _address)
        public
        ownsInsurance(_address)
        isPaymentDue(_address)
    {
        Insurance storage insurance = insurances[_address];

        // TODO: value is undefined 
        emit MontlyFeePayment(_address, insurance.plan.monthlyFee); 

        // TODO: event handler tries to pay fee through payment gw.,
        // if successful, calls confirmPayment() which will be a function
        // with a modifier, onlyGateway, means, that only the gateway can call that function.

        if (!insurance.isActive) {
            insurance.isActive = true;
        }

        insurance.nextPayment = block.timestamp + paymentFrequency;
        insurance.suspendDate = insurance.nextPayment + gracePeriod;
    }


    function suspendClient(address _address)
        external
        ownsInsurance(_address)
        canClientBeSuspended(_address)
        onlyOwner
    {
        if (insurances[_address].isActive) {
            setStatus(_address, false);
        }
    }
}
