// SPDX-License-Identifier:MIT

pragma solidity ^0.8;

contract testMapping{
    mapping(address=>uint) public balance;
    mapping(address=>mapping(address=>bool)) public isFirend;

    function example()external{
        balance[msg.sender] = 123;
        uint a  = balance[address(1)];//不存在的话则变为默认值
        delete balance[msg.sender];//不删位置，改为默认值

        isFirend[msg.sender][address(this)]=true;
    }
}