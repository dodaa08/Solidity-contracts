// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LendingBondingCurve is Ownable {
    IERC20 public token;        // Token for lending/borrowing
    IERC20 public collateral;   // Collateral token (e.g., WETH)

    uint public totalSupply;
    uint public reserve;        // Reserve in collateral for bonding curve

    // Simple linear bonding curve parameters
    uint public basePrice = 1e18;       // 1 collateral per token
    uint public priceSlope = 1e16;      // Increases per token

    mapping(address => uint) public deposits;
    mapping(address => uint) public borrows;
    mapping(address => uint) public collateralLocked;

    constructor(address _token, address _collateral) {
        token = IERC20(_token);
        collateral = IERC20(_collateral);
    }

    // ------------------------------------------
    // Lending
    // ------------------------------------------
    function deposit(uint amount) external {
        require(amount > 0, "Zero amount");
        token.transferFrom(msg.sender, address(this), amount);
        deposits[msg.sender] += amount;
    }

    function withdraw(uint amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        token.transfer(msg.sender, amount);
    }

    // ------------------------------------------
    // Borrowing (overcollateralized)
    // ------------------------------------------
    function borrow(uint amount) external {
        uint collateralRequired = amount * getPrice() * 2 / 1e18; // 200% collateral
        require(collateral.balanceOf(msg.sender) >= collateralRequired, "Not enough collateral");

        collateral.transferFrom(msg.sender, address(this), collateralRequired);
        collateralLocked[msg.sender] += collateralRequired;
        borrows[msg.sender] += amount;

        token.transfer(msg.sender, amount);
    }

    function repay(uint amount) external {
        require(borrows[msg.sender] >= amount, "Nothing to repay");
        token.transferFrom(msg.sender, address(this), amount);
        borrows[msg.sender] -= amount;

        // Return proportional collateral
        uint refund = collateralLocked[msg.sender] * amount / borrows[msg.sender];
        collateral.transfer(msg.sender, refund);
        collateralLocked[msg.sender] -= refund;
    }

    // ------------------------------------------
    // Bonding Curve Trading
    // ------------------------------------------
    function buy(uint amount) external {
        uint cost = buyPrice(amount);
        collateral.transferFrom(msg.sender, address(this), cost);
        reserve += cost;

        totalSupply += amount;
        token.transfer(msg.sender, amount);
    }

    function sell(uint amount) external {
        require(token.balanceOf(msg.sender) >= amount, "Insufficient token");

        uint refund = sellPrice(amount);
        require(reserve >= refund, "Insufficient reserve");

        token.transferFrom(msg.sender, address(this), amount);
        reserve -= refund;
        totalSupply -= amount;

        collateral.transfer(msg.sender, refund);
    }

    // ------------------------------------------
    // Bonding Curve Logic (Linear)
    // ------------------------------------------
    function getPrice() public view returns (uint) {
        return basePrice + priceSlope * totalSupply;
    }

    function buyPrice(uint amount) public view returns (uint) {
        uint price1 = getPrice();
        uint price2 = basePrice + priceSlope * (totalSupply + amount);
        return (price1 + price2) * amount / 2;
    }

    function sellPrice(uint amount) public view returns (uint) {
        uint price1 = getPrice();
        uint price2 = basePrice + priceSlope * (totalSupply - amount);
        return (price1 + price2) * amount / 2;
    }
}
