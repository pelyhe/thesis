/// SPDX-License-Identifier: UNLICENSED
/// @author Pelyhe Ádám - BME - MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

abstract contract GasInsurance is Ownable, ERC20 {
    uint32 internal nextInsuranceId;
    address internal gatewayAddress;

    constructor() {
        nextInsuranceId = 1;
    }

    event MontlyFeePayment(address indexed _address, uint32 indexed _value);
    event InsuranceResigned(address indexed _address);
    event InsuranceRegistration(address indexed _address, uint8 indexed planNumber);
    event ClientSuspended(address indexed _address);
    event ConfirmPayment(address indexed _address, uint32 indexed _value);

    address damageReportAddress;
    uint256 paymentFrequency = 3 minutes;
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

    modifier onlyGateway() {
        require(
            msg.sender == gatewayAddress
        );
        _;
    }

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
        require(
            insurances[_address].plan.planNumber != planNum,
            "You chose the same plan!"
        );
        _;
    }

    // returns if address has insurance or not
    function hasInsurance(address _address) public view returns (bool) {
        if (insurances[_address].id > 0) {
            return true;
        }
        return false;
    }

    function setGatewayAddress(address _address) external onlyOwner {
        gatewayAddress = _address;
    }

    function getPlan(address _address)
        external
        view
        ownsInsurance(_address)
        returns (uint8)
    {
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
        Plan memory plan = createPlan(_plan);
        emit InsuranceRegistration(_address, plan.planNumber);
        uint256 suspendDate = block.timestamp + gracePeriod;
        insurances[_address] = Insurance(
            nextInsuranceId, // id
            false, // isActive
            plan, // plan
            block.timestamp, // next payment
            suspendDate, // suspend date
            block.timestamp, // judgement cooldown timer
            0 // number of judges
        );
        nextInsuranceId++;
        payMonthlyFee(_address);
    }

    // user resigns the insurance
    function resignInsurance() external ownsInsurance(msg.sender) {
        delete insurances[msg.sender];
        emit InsuranceResigned(msg.sender);
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
        emit MontlyFeePayment(_address, uint32(insurances[_address].plan.monthlyFee));
    }

    // gateway confirms the success of the payment
    function confirmMonthlyFeePayment(address _address, uint256 _value)
        external
        onlyGateway
        ownsInsurance(_address)
        isPaymentDue(_address)
    {
        Insurance storage insurance = insurances[_address];

        if (!insurance.isActive) {
            insurance.isActive = true;
        }

        insurance.nextPayment = block.timestamp + paymentFrequency;
        insurance.suspendDate = insurance.nextPayment + gracePeriod;

        emit ConfirmPayment(_address, uint32(_value));
    }

    function suspendClient(address _address)
        external
        ownsInsurance(_address)
        canClientBeSuspended(_address)
        onlyOwner
    {
        if (insurances[_address].isActive) {
            insurances[_address].isActive = false;
        }

        emit ClientSuspended(_address);
    }
}
