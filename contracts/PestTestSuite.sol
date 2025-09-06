// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./Pest.sol";
import "./PestAssertions.sol";

/**
 * @title PestTestSuite - A comprehensive test runner for smart contracts
 * @dev Extends Pest with additional testing capabilities
 */
contract PestTestSuite is Pest {
    using PestAssertions for *;
    
    // Test categories
    enum TestCategory { Unit, Integration, Performance, Security }
    
    // Extended test result with category
    struct ExtendedTestResult {
        string name;
        bool passed;
        string reason;
        address tester;
        uint256 timestamp;
        TestCategory category;
        uint256 gasUsed;
    }
    
    // Category statistics
    mapping(TestCategory => uint256) public categoryStats;
    ExtendedTestResult[] public extendedResults;
    
    // Events
    event TestCategoryStarted(TestCategory category, address tester);
    event PerformanceTest(string testName, uint256 gasUsed, bool withinLimit);
    
    /**
     * @dev Run a test with specific category
     */
    function testWithCategory(
        string memory testName, 
        bool condition, 
        string memory failureReason,
        TestCategory category
    ) external onlyAuthorizedTester returns (bool) {
        uint256 gasStart = gasleft();
        
        emit TestStarted(testName, msg.sender);
        emit TestCategoryStarted(category, msg.sender);
        
        stats.totalTests++;
        categoryStats[category]++;
        
        uint256 gasUsed = gasStart - gasleft();
        
        if (condition) {
            stats.passedTests++;
            extendedResults.push(ExtendedTestResult({
                name: testName,
                passed: true,
                reason: "",
                tester: msg.sender,
                timestamp: block.timestamp,
                category: category,
                gasUsed: gasUsed
            }));
            emit TestPassed(testName, msg.sender);
            return true;
        } else {
            stats.failedTests++;
            extendedResults.push(ExtendedTestResult({
                name: testName,
                passed: false,
                reason: failureReason,
                tester: msg.sender,
                timestamp: block.timestamp,
                category: category,
                gasUsed: gasUsed
            }));
            emit TestFailed(testName, failureReason, msg.sender);
            return false;
        }
    }
    
    /**
     * @dev Test equality with automatic failure message
     */
    function expectEqual(string memory testName, uint256 actual, uint256 expected) 
        external onlyAuthorizedTester returns (bool) {
        bool condition = PestAssertions.assertEqual(actual, expected);
        string memory reason = condition ? "" : 
            string(abi.encodePacked("Expected: ", uint2str(expected), ", Got: ", uint2str(actual)));
        return test(testName, condition, reason);
    }
    
    /**
     * @dev Test string equality
     */
    function expectEqual(string memory testName, string memory actual, string memory expected) 
        external onlyAuthorizedTester returns (bool) {
        bool condition = PestAssertions.assertEqual(actual, expected);
        string memory reason = condition ? "" : 
            string(abi.encodePacked("Expected: '", expected, "', Got: '", actual, "'"));
        return test(testName, condition, reason);
    }
    
    /**
     * @dev Test address equality
     */
    function expectEqual(string memory testName, address actual, address expected) 
        external onlyAuthorizedTester returns (bool) {
        bool condition = PestAssertions.assertEqual(actual, expected);
        string memory reason = condition ? "" : "Address mismatch";
        return test(testName, condition, reason);
    }
    
    /**
     * @dev Test boolean truth
     */
    function expectTrue(string memory testName, bool condition) 
        external onlyAuthorizedTester returns (bool) {
        bool result = PestAssertions.assertTrue(condition);
        string memory reason = result ? "" : "Expected true, got false";
        return test(testName, result, reason);
    }
    
    /**
     * @dev Test boolean false
     */
    function expectFalse(string memory testName, bool condition) 
        external onlyAuthorizedTester returns (bool) {
        bool result = PestAssertions.assertFalse(condition);
        string memory reason = result ? "" : "Expected false, got true";
        return test(testName, result, reason);
    }
    
    /**
     * @dev Performance test with gas limit
     */
    function performanceTest(string memory testName, uint256 gasLimit) 
        external onlyAuthorizedTester returns (bool) {
        uint256 gasStart = gasleft();
        
        // Simulate some work - in real use, this would call the function being tested
        uint256 result = 0;
        for (uint256 i = 0; i < 100; i++) {
            result += i;
        }
        
        uint256 gasUsed = gasStart - gasleft();
        bool withinLimit = gasUsed <= gasLimit;
        
        emit PerformanceTest(testName, gasUsed, withinLimit);
        
        string memory reason = withinLimit ? "" : 
            string(abi.encodePacked("Gas limit exceeded. Used: ", uint2str(gasUsed), ", Limit: ", uint2str(gasLimit)));
        
        return testWithCategory(testName, withinLimit, reason, TestCategory.Performance);
    }
    
    /**
     * @dev Get category statistics
     */
    function getCategoryStats(TestCategory category) external view returns (uint256) {
        return categoryStats[category];
    }
    
    /**
     * @dev Get extended test result by index
     */
    function getExtendedTestResult(uint256 index) external view returns (ExtendedTestResult memory) {
        require(index < extendedResults.length, "PestTestSuite: Index out of bounds");
        return extendedResults[index];
    }
    
    /**
     * @dev Helper function to convert uint to string
     */
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}