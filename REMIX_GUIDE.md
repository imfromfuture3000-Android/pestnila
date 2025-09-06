# 🚀 Pest 2.0 - Remix IDE Quick Start Guide

This guide will help you get Pest 2.0 up and running in Remix IDE in just a few minutes.

## 📋 Prerequisites

- Web browser (Chrome, Firefox, Safari, Edge)
- Internet connection
- Basic understanding of Solidity

## 🎯 Step-by-Step Setup

### Step 1: Open Remix IDE
Click this link to open Remix IDE with the correct Solidity version:
**[https://remix.ethereum.org/#version=soljson-v0.8.30+commit.73712a01.js&optimize=false&runs=200&gist=&lang=en](https://remix.ethereum.org/#version=soljson-v0.8.30+commit.73712a01.js&optimize=false&runs=200&gist=&lang=en)**

### Step 2: Create Workspace
1. In the **File Explorer** (left sidebar), click on "workspaces" 
2. Click **"Create"** to create a new workspace
3. Name it `Pest-2.0-Testing`
4. Select "Blank" template
5. Click **"OK"**

### Step 3: Set Up Folder Structure
Create the following folders by right-clicking in the file explorer:
```
📁 contracts/
   📁 examples/
```

### Step 4: Copy Contract Files
Create these files by right-clicking on the appropriate folder and selecting "New File":

#### A. Core Framework Files

**📄 `contracts/Pest.sol`** - [Copy from repository](./contracts/Pest.sol)

**📄 `contracts/PestAssertions.sol`** - [Copy from repository](./contracts/PestAssertions.sol)

**📄 `contracts/PestTestSuite.sol`** - [Copy from repository](./contracts/PestTestSuite.sol)

#### B. Example Files

**📄 `contracts/examples/SimpleCalculator.sol`** - [Copy from repository](./contracts/examples/SimpleCalculator.sol)

**📄 `contracts/examples/CalculatorTests.sol`** - [Copy from repository](./contracts/examples/CalculatorTests.sol)

### Step 5: Compile Contracts
1. Go to **"Solidity Compiler"** tab (Ctrl/Cmd + Shift + S)
2. Ensure compiler version is set to `0.8.30+commit.73712a01`
3. Click **"Compile All"** or use Ctrl/Cmd + Shift + A
4. Check for successful compilation (green checkmarks)

### Step 6: Deploy and Test
1. Go to **"Deploy & Run Transactions"** tab (Ctrl/Cmd + Shift + D)
2. Select **"Remix VM (Shanghai)"** as environment
3. Deploy contracts in this order:
   - First: `CalculatorTests`
   - The constructor will automatically deploy the required dependencies

### Step 7: Run Your First Test
1. After deployment, find your `CalculatorTests` contract in the "Deployed Contracts" section
2. Expand the contract to see available functions
3. Click **`runAllTests`** button
4. Watch the magic happen! ✨

### Step 8: View Results
Check the Remix console (bottom panel) for:
- 📊 Test execution logs
- ⛽ Gas usage statistics  
- ✅ Pass/fail indicators
- 📈 Performance metrics

## 🎮 Interactive Testing

### View Test Statistics
```javascript
// Click these functions in the deployed contract:
- `getTestStats()` - Overall statistics
- `getLatestResults(5)` - Last 5 test results
```

### Individual Tests
You can also run individual test components:
```javascript
- `testAddition()` - Test basic addition
- `testSubtraction()` - Test basic subtraction  
- `testDivision()` - Test division with edge cases
- `testOwnership()` - Test access control
```

## 🔧 Customization

### Create Your Own Tests
1. **Create a new contract** (e.g., `MyContract.sol`)
2. **Create a test file** (e.g., `MyContractTests.sol`)
3. **Follow this template**:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "../PestTestSuite.sol";
import "./MyContract.sol";

contract MyContractTests {
    PestTestSuite public pestSuite;
    MyContract public myContract;
    
    constructor() {
        pestSuite = new PestTestSuite();
        myContract = new MyContract();
    }
    
    function runAllTests() external {
        pestSuite.startTestSuite();
        
        // Your tests here
        pestSuite.expectEqual("Test description", actual, expected);
        
        pestSuite.completeTestSuite();
    }
}
```

## 🎨 Remix IDE Pro Tips

### 1. Use Console Logging
Add this to see detailed output:
```solidity
import "hardhat/console.sol"; // Built into Remix
console.log("Debug:", value);
```

### 2. Gas Optimization
- Monitor gas usage in the transaction logs
- Use the gas estimator before deploying
- Compare different implementation approaches

### 3. Network Testing
Switch between different environments:
- **Remix VM** - For development
- **Injected Provider** - For MetaMask testing
- **External HTTP Provider** - For custom networks

### 4. Version Control
- Use the **Git plugin** in Remix
- Connect to GitHub repositories
- Collaborate with team members

## 🚨 Troubleshooting

### Common Issues

**❌ Compilation Errors**
- Check Solidity version is `0.8.30`
- Verify all imports are correct
- Look for typos in contract names

**❌ Deployment Fails**
- Ensure sufficient gas limit
- Check for constructor parameter errors
- Verify contract dependencies

**❌ Tests Don't Run**
- Confirm contract is deployed successfully
- Check if you're calling the right function
- Verify test contract has proper setup

**❌ Gas Estimation Fails**
- Reduce complexity of operations
- Check for infinite loops
- Verify all require statements

### Getting Help
- 📖 Read the [Full Documentation](../README-PEST-2.0.md)
- 💬 Check Remix IDE documentation
- 🐛 Review console error messages
- 🔍 Use Remix debugger for complex issues

## 🎉 Next Steps

Once you're comfortable with the basics:

1. **📚 Explore Advanced Features**
   - Test categorization
   - Performance benchmarking
   - Custom assertions

2. **🔒 Security Testing**
   - Access control tests
   - Edge case validation
   - Vulnerability assessment

3. **📊 Analytics & Reporting**
   - Gas optimization analysis
   - Test coverage tracking
   - Performance trending

4. **🌐 Deploy to Testnet**
   - Test on Sepolia or Goerli
   - Verify real-world performance
   - Share with the community

## 🎯 Success Metrics

You'll know you're successful when you see:
- ✅ Green compilation checkmarks
- 📊 Test statistics in console
- ⛽ Reasonable gas usage
- 🎉 All tests passing

**Happy Testing! 🧪✨**

---
*Pest 2.0 - Making smart contract testing elegant and enjoyable*