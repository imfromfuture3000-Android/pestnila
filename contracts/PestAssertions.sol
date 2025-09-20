// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title PestAssertions - Testing utility functions for Pest 2.0
 * @dev Provides assertion functions similar to testing frameworks
 */
library PestAssertions {
    
    /**
     * @dev Assert that two values are equal
     */
    function assertEqual(uint256 actual, uint256 expected) internal pure returns (bool) {
        return actual == expected;
    }
    
    /**
     * @dev Assert that two addresses are equal
     */
    function assertEqual(address actual, address expected) internal pure returns (bool) {
        return actual == expected;
    }
    
    /**
     * @dev Assert that two strings are equal
     */
    function assertEqual(string memory actual, string memory expected) internal pure returns (bool) {
        return keccak256(abi.encodePacked(actual)) == keccak256(abi.encodePacked(expected));
    }
    
    /**
     * @dev Assert that two bool values are equal
     */
    function assertEqual(bool actual, bool expected) internal pure returns (bool) {
        return actual == expected;
    }
    
    /**
     * @dev Assert that value is true
     */
    function assertTrue(bool condition) internal pure returns (bool) {
        return condition == true;
    }
    
    /**
     * @dev Assert that value is false
     */
    function assertFalse(bool condition) internal pure returns (bool) {
        return condition == false;
    }
    
    /**
     * @dev Assert that value is greater than comparison
     */
    function assertGreaterThan(uint256 value, uint256 comparison) internal pure returns (bool) {
        return value > comparison;
    }
    
    /**
     * @dev Assert that value is less than comparison
     */
    function assertLessThan(uint256 value, uint256 comparison) internal pure returns (bool) {
        return value < comparison;
    }
    
    /**
     * @dev Assert that value is greater than or equal to comparison
     */
    function assertGreaterThanOrEqual(uint256 value, uint256 comparison) internal pure returns (bool) {
        return value >= comparison;
    }
    
    /**
     * @dev Assert that value is less than or equal to comparison
     */
    function assertLessThanOrEqual(uint256 value, uint256 comparison) internal pure returns (bool) {
        return value <= comparison;
    }
    
    /**
     * @dev Assert that address is not zero address
     */
    function assertNotZeroAddress(address addr) internal pure returns (bool) {
        return addr != address(0);
    }
    
    /**
     * @dev Assert that value is zero
     */
    function assertZero(uint256 value) internal pure returns (bool) {
        return value == 0;
    }
    
    /**
     * @dev Assert that value is not zero
     */
    function assertNotZero(uint256 value) internal pure returns (bool) {
        return value != 0;
    }
    
    /**
     * @dev Assert that array has expected length
     */
    function assertLength(uint256[] memory array, uint256 expectedLength) internal pure returns (bool) {
        return array.length == expectedLength;
    }
    
    /**
     * @dev Assert that string is not empty
     */
    function assertNotEmpty(string memory str) internal pure returns (bool) {
        return bytes(str).length > 0;
    }
    
    /**
     * @dev Assert that value is within range (inclusive)
     */
    function assertInRange(uint256 value, uint256 min, uint256 max) internal pure returns (bool) {
        return value >= min && value <= max;
    }
    
    /**
     * @dev Generate error message for failed assertion
     */
    function getAssertionMessage(string memory assertionType, string memory details) 
        internal 
        pure 
        returns (string memory) 
    {
        return string(abi.encodePacked("Assertion failed: ", assertionType, " - ", details));
    }
}