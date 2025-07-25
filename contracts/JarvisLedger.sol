// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract JarvisLedger {
    address public owner;

    event LedgerEntry(
        string eventType,
        string debitAccount,
        string creditAccount,
        uint256 amount,
        string description,
        uint256 timestamp
    );

    event BrinksCollected(
        string fromAccount,
        string toAccount,
        uint256 amount,
        string description,
        uint256 timestamp
    );

    event TransactionLogged(
        string ipfsCid,
        string hash,
        uint256 timestamp
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function recordLedgerEvent(
        string memory eventType,
        string memory debitAccount,
        string memory creditAccount,
        uint256 amount,
        string memory description
    ) external onlyOwner {
        emit LedgerEntry(eventType, debitAccount, creditAccount, amount, description, block.timestamp);
    }

    function recordBrinksCollection(
        string memory fromAccount,
        string memory toAccount,
        uint256 amount,
        string memory description
    ) external onlyOwner {
        emit BrinksCollected(fromAccount, toAccount, amount, description, block.timestamp);
    }

    function logTransaction(string memory ipfsCid, string memory hash) external onlyOwner {
        emit TransactionLogged(ipfsCid, hash, block.timestamp);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}
