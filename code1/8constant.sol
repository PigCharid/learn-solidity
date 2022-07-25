// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
// 21371 gas
contract Constant{
    uint public constant A =1;
}

// 23471 gas 
contract NotConstant{
    uint public A = 1;
}

// 确实读取常量变量的gas会更加节约

contract Imu{
    address public immutable owner = msg.sender;
    
}