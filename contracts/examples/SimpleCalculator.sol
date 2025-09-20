// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title SimpleCalculator - Example contract for testing with Pest 2.0
 * @dev A basic calculator contract to demonstrate testing capabilities
 */
contract SimpleCalculator {
    
    uint256 public result;
    address public owner;
    bool public locked;
    
    event CalculationPerformed(string operation, uint256 operand1, uint256 operand2, uint256 result);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Calculator: Only owner can perform this action");
        _;
    }
    
    modifier notLocked() {
        require(!locked, "Calculator: Contract is locked");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        result = 0;
        locked = false;
    }
    
    /**
     * @dev Add two numbers
     */
    function add(uint256 a, uint256 b) external notLocked returns (uint256) {
        result = a + b;
        emit CalculationPerformed("add", a, b, result);
        return result;
    }
    
    /**
     * @dev Subtract two numbers
     */
    function subtract(uint256 a, uint256 b) external notLocked returns (uint256) {
        require(a >= b, "Calculator: Cannot subtract larger number from smaller");
        result = a - b;
        emit CalculationPerformed("subtract", a, b, result);
        return result;
    }
    
    /**
     * @dev Multiply two numbers
     */
    function multiply(uint256 a, uint256 b) external notLocked returns (uint256) {
        result = a * b;
        emit CalculationPerformed("multiply", a, b, result);
        return result;
    }
    
    /**
     * @dev Divide two numbers
     */
    function divide(uint256 a, uint256 b) external notLocked returns (uint256) {
        require(b != 0, "Calculator: Division by zero");
        result = a / b;
        emit CalculationPerformed("divide", a, b, result);
        return result;
    }
    
    /**
     * @dev Get current result
     */
    function getResult() external view returns (uint256) {
        return result;
    }
    
    /**
     * @dev Reset calculator
     */
    function reset() external onlyOwner {
        result = 0;
    }
    
    /**
     * @dev Lock/unlock calculator
     */
    function setLocked(bool _locked) external onlyOwner {
        locked = _locked;
    }
    
    /**
     * @dev Transfer ownership
     */
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Calculator: New owner cannot be zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
    
    /**
     * @dev Power function (for performance testing)
     */
    function power(uint256 base, uint256 exponent) external notLocked returns (uint256) {
        require(exponent < 100, "Calculator: Exponent too large to prevent gas overflow");
        
        if (exponent == 0) {
            result = 1;
            emit CalculationPerformed("power", base, exponent, result);
            return result;
        }
        
        result = base;
        for (uint256 i = 1; i < exponent; i++) {
            result = result * base;
        }
        
        emit CalculationPerformed("power", base, exponent, result);
        return result;
    }
}