// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Account{
    address public bank;
    address public owner;
    uint public a;
    constructor(address _owner)payable{
        bank = msg.sender;
        owner = _owner;
    }
    function setA(uint _a)external{
        a= _a;
    }
}


contract AccountFactory{
    Account[] public accounts;
    function createAccount(address _owner)external payable{
        // 由于这两个合约是在一起的  可以直接用new   通过import导入的合约也是可以的
        // 用合约类型定义一个变量去接住new的返回值，那么就是合约的地址
        // 添加{}就可以添加主币的值
        Account account = new Account{value:msg.value}(_owner);
        accounts.push(account);
    }
}