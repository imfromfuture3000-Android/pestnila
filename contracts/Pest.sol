// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title Pest 2.0 - Elegant Smart Contract Testing Framework
 * @dev A blockchain testing framework inspired by the simplicity of PHP Pest
 * @author Pest Team
 */
contract Pest {
    
    // Events for test reporting
    event TestStarted(string testName, address tester);
    event TestPassed(string testName, address tester);
    event TestFailed(string testName, string reason, address tester);
    event TestSuiteCompleted(uint256 totalTests, uint256 passed, uint256 failed);
    
    // Test result structure
    struct TestResult {
        string name;
        bool passed;
        string reason;
        address tester;
        uint256 timestamp;
    }
    
    // Test statistics
    struct TestStats {
        uint256 totalTests;
        uint256 passedTests;
        uint256 failedTests;
        uint256 lastRun;
    }
    
    // Storage
    TestResult[] public testResults;
    TestStats public stats;
    mapping(address => bool) public authorizedTesters;
    address public owner;
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Pest: Only owner can perform this action");
        _;
    }
    
    modifier onlyAuthorizedTester() {
        require(authorizedTesters[msg.sender] || msg.sender == owner, "Pest: Not authorized to run tests");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        authorizedTesters[msg.sender] = true;
    }
    
    /**
     * @dev Add an authorized tester
     */
    function addTester(address tester) external onlyOwner {
        authorizedTesters[tester] = true;
    }
    
    /**
     * @dev Remove an authorized tester
     */
    function removeTester(address tester) external onlyOwner {
        authorizedTesters[tester] = false;
    }
    
    /**
     * @dev Start a test suite - resets statistics
     */
    function startTestSuite() external onlyAuthorizedTester {
        stats.totalTests = 0;
        stats.passedTests = 0;
        stats.failedTests = 0;
        stats.lastRun = block.timestamp;
    }
    
    /**
     * @dev Run a test with expectation
     */
    function test(string memory testName, bool condition, string memory failureReason) 
        external 
        onlyAuthorizedTester 
        returns (bool) 
    {
        emit TestStarted(testName, msg.sender);
        
        stats.totalTests++;
        
        if (condition) {
            stats.passedTests++;
            testResults.push(TestResult({
                name: testName,
                passed: true,
                reason: "",
                tester: msg.sender,
                timestamp: block.timestamp
            }));
            emit TestPassed(testName, msg.sender);
            return true;
        } else {
            stats.failedTests++;
            testResults.push(TestResult({
                name: testName,
                passed: false,
                reason: failureReason,
                tester: msg.sender,
                timestamp: block.timestamp
            }));
            emit TestFailed(testName, failureReason, msg.sender);
            return false;
        }
    }
    
    /**
     * @dev Complete test suite and emit summary
     */
    function completeTestSuite() external onlyAuthorizedTester {
        emit TestSuiteCompleted(stats.totalTests, stats.passedTests, stats.failedTests);
    }
    
    /**
     * @dev Get test statistics
     */
    function getStats() external view returns (TestStats memory) {
        return stats;
    }
    
    /**
     * @dev Get total number of test results
     */
    function getTestResultsCount() external view returns (uint256) {
        return testResults.length;
    }
    
    /**
     * @dev Get test result by index
     */
    function getTestResult(uint256 index) external view returns (TestResult memory) {
        require(index < testResults.length, "Pest: Test result index out of bounds");
        return testResults[index];
    }
    
    /**
     * @dev Get latest test results (last n results)
     */
    function getLatestTestResults(uint256 count) external view returns (TestResult[] memory) {
        require(count > 0, "Pest: Count must be greater than 0");
        
        uint256 resultCount = testResults.length;
        if (count > resultCount) {
            count = resultCount;
        }
        
        TestResult[] memory latestResults = new TestResult[](count);
        for (uint256 i = 0; i < count; i++) {
            latestResults[i] = testResults[resultCount - count + i];
        }
        
        return latestResults;
    }
    
    /**
     * @dev Clear all test results (only owner)
     */
    function clearTestResults() external onlyOwner {
        delete testResults;
        stats.totalTests = 0;
        stats.passedTests = 0;
        stats.failedTests = 0;
        stats.lastRun = block.timestamp;
    }
}