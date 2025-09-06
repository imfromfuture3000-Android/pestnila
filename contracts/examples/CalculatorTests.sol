// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "../PestTestSuite.sol";
import "./SimpleCalculator.sol";

/**
 * @title CalculatorTests - Example test contract using Pest 2.0
 * @dev Demonstrates how to test smart contracts with the Pest framework
 */
contract CalculatorTests {
    
    PestTestSuite public pestSuite;
    SimpleCalculator public calculator;
    
    constructor() {
        pestSuite = new PestTestSuite();
        calculator = new SimpleCalculator();
    }
    
    /**
     * @dev Run all calculator tests
     */
    function runAllTests() external {
        pestSuite.startTestSuite();
        
        // Basic arithmetic tests
        testAddition();
        testSubtraction();
        testMultiplication();
        testDivision();
        
        // Edge case tests
        testDivisionByZero();
        testSubtractionUnderflow();
        
        // Ownership tests
        testOwnership();
        
        // State tests
        testLocking();
        
        // Performance tests
        testPowerPerformance();
        
        pestSuite.completeTestSuite();
    }
    
    /**
     * @dev Test basic addition
     */
    function testAddition() public {
        uint256 result = calculator.add(5, 3);
        pestSuite.expectEqual("Addition: 5 + 3 = 8", result, 8);
        
        uint256 storedResult = calculator.getResult();
        pestSuite.expectEqual("Stored result should be 8", storedResult, 8);
    }
    
    /**
     * @dev Test basic subtraction
     */
    function testSubtraction() public {
        uint256 result = calculator.subtract(10, 4);
        pestSuite.expectEqual("Subtraction: 10 - 4 = 6", result, 6);
    }
    
    /**
     * @dev Test basic multiplication
     */
    function testMultiplication() public {
        uint256 result = calculator.multiply(7, 6);
        pestSuite.expectEqual("Multiplication: 7 * 6 = 42", result, 42);
    }
    
    /**
     * @dev Test basic division
     */
    function testDivision() public {
        uint256 result = calculator.divide(20, 4);
        pestSuite.expectEqual("Division: 20 / 4 = 5", result, 5);
    }
    
    /**
     * @dev Test division by zero (should fail)
     */
    function testDivisionByZero() public {
        bool success;
        try calculator.divide(10, 0) {
            success = true;
        } catch {
            success = false;
        }
        pestSuite.expectFalse("Division by zero should fail", success);
    }
    
    /**
     * @dev Test subtraction underflow (should fail)
     */
    function testSubtractionUnderflow() public {
        bool success;
        try calculator.subtract(3, 5) {
            success = true;
        } catch {
            success = false;
        }
        pestSuite.expectFalse("Subtraction underflow should fail", success);
    }
    
    /**
     * @dev Test ownership functionality
     */
    function testOwnership() public {
        address originalOwner = calculator.owner();
        pestSuite.expectEqual("Original owner should be this contract", originalOwner, address(this));
        
        // Test reset function (only owner)
        calculator.reset();
        uint256 resultAfterReset = calculator.getResult();
        pestSuite.expectEqual("Result should be 0 after reset", resultAfterReset, 0);
    }
    
    /**
     * @dev Test locking functionality
     */
    function testLocking() public {
        // Test that calculator starts unlocked
        bool initialLockState = calculator.locked();
        pestSuite.expectFalse("Calculator should start unlocked", initialLockState);
        
        // Lock the calculator
        calculator.setLocked(true);
        bool lockedState = calculator.locked();
        pestSuite.expectTrue("Calculator should be locked", lockedState);
        
        // Try to perform calculation while locked (should fail)
        bool success;
        try calculator.add(1, 1) {
            success = true;
        } catch {
            success = false;
        }
        pestSuite.expectFalse("Operations should fail when locked", success);
        
        // Unlock the calculator
        calculator.setLocked(false);
        bool unlockedState = calculator.locked();
        pestSuite.expectFalse("Calculator should be unlocked", unlockedState);
    }
    
    /**
     * @dev Test power function performance
     */
    function testPowerPerformance() public {
        // Test power calculation with performance monitoring
        pestSuite.performanceTest("Power calculation performance", 100000);
        
        // Test actual power calculation
        uint256 result = calculator.power(2, 10);
        pestSuite.expectEqual("Power: 2^10 = 1024", result, 1024);
        
        // Test power edge case
        uint256 zeroResult = calculator.power(5, 0);
        pestSuite.expectEqual("Power: 5^0 = 1", zeroResult, 1);
    }
    
    /**
     * @dev Get test statistics
     */
    function getTestStats() external view returns (PestTestSuite.TestStats memory) {
        return pestSuite.getStats();
    }
    
    /**
     * @dev Get latest test results
     */
    function getLatestResults(uint256 count) external view returns (Pest.TestResult[] memory) {
        return pestSuite.getLatestTestResults(count);
    }
}