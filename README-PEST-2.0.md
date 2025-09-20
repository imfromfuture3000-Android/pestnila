# Pest 2.0 - Elegant Smart Contract Testing Framework

<p align="center">
    <img src="https://raw.githubusercontent.com/pestphp/art/master/v4/social.png" width="600" alt="PEST 2.0">
</p>

**Pest 2.0** is an elegant smart contract testing framework built for Ethereum, inspired by the simplicity and elegance of the PHP Pest testing framework. Designed specifically for Solidity development and optimized for use with [Remix IDE](https://remix.ethereum.org/).

## ✨ Features

- **🧪 Elegant Testing Syntax** - Clean, readable test methods that make testing a joy
- **📊 Comprehensive Reporting** - Detailed test results with gas usage tracking
- **🎯 Multiple Assertion Types** - Rich set of assertion helpers for thorough testing
- **📁 Test Categorization** - Organize tests by type (Unit, Integration, Performance, Security)
- **⚡ Performance Testing** - Built-in gas usage monitoring and performance benchmarking
- **🔒 Access Control** - Secure testing environment with authorized tester management
- **📈 Real-time Statistics** - Live tracking of test pass/fail rates and execution metrics

## 🚀 Quick Start with Remix IDE

### 1. Open Remix IDE
Visit [https://remix.ethereum.org/#version=soljson-v0.8.30+commit.73712a01.js&optimize=false&runs=200&gist=&lang=en](https://remix.ethereum.org/#version=soljson-v0.8.30+commit.73712a01.js&optimize=false&runs=200&gist=&lang=en)

### 2. Create New Workspace
1. Click on "File Explorer" in the left sidebar
2. Create a new workspace called "Pest-2.0"
3. Create a folder structure: `contracts/`, `contracts/examples/`

### 3. Copy Contracts
Copy the following files from this repository into your Remix workspace:

```
contracts/
├── Pest.sol                    # Core testing framework
├── PestAssertions.sol          # Assertion library
├── PestTestSuite.sol           # Extended test suite
└── examples/
    ├── SimpleCalculator.sol    # Example contract to test
    └── CalculatorTests.sol     # Example test suite
```

### 4. Compile and Deploy
1. Select **Solidity Compiler** (Ctrl/Cmd + Shift + S)
2. Set compiler version to `0.8.30+commit.73712a01` 
3. Compile all contracts
4. Go to **Deploy & Run Transactions**
5. Deploy `CalculatorTests` contract

### 5. Run Tests
1. After deployment, expand your deployed `CalculatorTests` contract
2. Click on `runAllTests()` to execute the complete test suite
3. Check the console for detailed test results and gas usage

## 📖 Usage Examples

### Basic Test Contract
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./PestTestSuite.sol";
import "./MyContract.sol";

contract MyContractTests {
    PestTestSuite public pestSuite;
    MyContract public myContract;
    
    constructor() {
        pestSuite = new PestTestSuite();
        myContract = new MyContract();
    }
    
    function runTests() external {
        pestSuite.startTestSuite();
        
        // Simple assertion test
        pestSuite.expectEqual("Basic addition", myContract.add(2, 3), 5);
        
        // Boolean tests
        pestSuite.expectTrue("Should be true", myContract.isValid());
        pestSuite.expectFalse("Should be false", myContract.isLocked());
        
        // Performance test
        pestSuite.performanceTest("Gas efficiency test", 50000);
        
        pestSuite.completeTestSuite();
    }
}
```

### Advanced Testing with Categories
```solidity
function testSecurityFeatures() public {
    // Test with specific category
    bool hasAccess = myContract.checkAccess(unauthorizedUser);
    pestSuite.testWithCategory(
        "Unauthorized access denied",
        !hasAccess,
        "Unauthorized user should not have access",
        PestTestSuite.TestCategory.Security
    );
}
```

### Custom Assertions
```solidity
import "./PestAssertions.sol";

function customTest() public {
    using PestAssertions for *;
    
    // Direct assertion usage
    bool isEqual = PestAssertions.assertEqual(actualValue, expectedValue);
    bool isInRange = PestAssertions.assertInRange(value, 10, 100);
    bool isNotZero = PestAssertions.assertNotZero(balance);
}
```

## 🏗️ Contract Architecture

### Core Contracts

#### `Pest.sol` - Base Testing Framework
- Core testing functionality
- Test result storage and retrieval
- Event emission for test lifecycle
- Access control for authorized testers

#### `PestAssertions.sol` - Assertion Library
- Comprehensive assertion functions
- Type-safe comparisons
- Automatic error message generation
- Utility functions for common test patterns

#### `PestTestSuite.sol` - Extended Test Suite
- Enhanced testing capabilities
- Test categorization
- Performance monitoring
- Gas usage tracking
- Extended reporting features

## 📊 Test Categories

Pest 2.0 supports four main test categories:

- **Unit** - Individual function/method testing
- **Integration** - Contract interaction testing  
- **Performance** - Gas usage and efficiency testing
- **Security** - Access control and vulnerability testing

## 🔧 Available Assertions

### Equality Assertions
- `assertEqual(actual, expected)` - For uint256, address, string, bool
- `assertNotEqual(actual, expected)` - Inverse equality

### Boolean Assertions  
- `assertTrue(condition)` - Expects true
- `assertFalse(condition)` - Expects false

### Numerical Assertions
- `assertGreaterThan(value, comparison)`
- `assertLessThan(value, comparison)`
- `assertGreaterThanOrEqual(value, comparison)`
- `assertLessThanOrEqual(value, comparison)`
- `assertZero(value)` - Expects zero
- `assertNotZero(value)` - Expects non-zero
- `assertInRange(value, min, max)` - Range validation

### Address Assertions
- `assertNotZeroAddress(address)` - Non-zero address validation

### Collection Assertions
- `assertLength(array, expectedLength)` - Array length validation
- `assertNotEmpty(string)` - Non-empty string validation

## 📈 Getting Test Results

### Real-time Statistics
```solidity
// Get current test statistics
PestTestSuite.TestStats memory stats = pestSuite.getStats();
console.log("Total tests:", stats.totalTests);
console.log("Passed:", stats.passedTests);
console.log("Failed:", stats.failedTests);
```

### Detailed Results
```solidity
// Get latest test results
Pest.TestResult[] memory results = pestSuite.getLatestTestResults(5);

// Get specific test result
Pest.TestResult memory result = pestSuite.getTestResult(0);
console.log("Test name:", result.name);
console.log("Passed:", result.passed);
console.log("Reason:", result.reason);
```

### Category Statistics
```solidity
// Get statistics by category
uint256 unitTests = pestSuite.getCategoryStats(PestTestSuite.TestCategory.Unit);
uint256 perfTests = pestSuite.getCategoryStats(PestTestSuite.TestCategory.Performance);
```

## 🎯 Best Practices

### 1. Organize Your Tests
```solidity
contract MyContractTests {
    function runAllTests() external {
        pestSuite.startTestSuite();
        
        // Group related tests
        testBasicFunctionality();
        testEdgeCases();
        testSecurityFeatures();
        testPerformance();
        
        pestSuite.completeTestSuite();
    }
}
```

### 2. Use Descriptive Test Names
```solidity
// Good ✅
pestSuite.expectEqual("Transfer should update sender balance", senderBalance, expectedBalance);

// Bad ❌  
pestSuite.expectEqual("test1", senderBalance, expectedBalance);
```

### 3. Test Edge Cases
```solidity
function testEdgeCases() public {
    // Test zero values
    pestSuite.expectEqual("Zero input handling", myContract.process(0), 0);
    
    // Test maximum values
    pestSuite.expectTrue("Max value handling", myContract.process(type(uint256).max));
    
    // Test boundary conditions
    pestSuite.expectFalse("Boundary validation", myContract.isValid(999));
    pestSuite.expectTrue("Boundary validation", myContract.isValid(1000));
}
```

### 4. Monitor Performance
```solidity
function testPerformance() public {
    // Set reasonable gas limits for different operations
    pestSuite.performanceTest("Simple calculation", 5000);
    pestSuite.performanceTest("Complex operation", 50000);
    pestSuite.performanceTest("Storage operation", 20000);
}
```

## 🔐 Security Considerations

- Only authorized testers can run tests
- Test results are immutable once recorded
- Gas monitoring helps detect inefficient code
- Access control prevents unauthorized test manipulation

## 🤝 Contributing

Pest 2.0 is inspired by the elegant PHP Pest framework. Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add comprehensive tests for new features
4. Follow the existing code style
5. Submit a pull request

## 📄 License

MIT License - see LICENSE.md for details

## 🙏 Acknowledgments

- Inspired by [Pest PHP](https://pestphp.com) by Nuno Maduro
- Built for the Ethereum ecosystem
- Optimized for Remix IDE workflow

---

**Ready to make smart contract testing elegant and enjoyable! 🧪✨**