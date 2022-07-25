// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract ciTest{
     string constant TEXT = "abc";
    //  TEXT = ="can not change"; 会报错
     bytes32 constant MY_HASH = keccak256("abc");
     uint immutable decimals;
     uint immutable maxBalance;
     address immutable owner = msg.sender;

     constructor(uint _decimals, address _reference) {
        decimals = _decimals;
        maxBalance = _reference.balance;
     }
     function isBalanceTooHigh(address _other) public view returns (bool) {
        return _other.balance > maxBalance;
     }
}