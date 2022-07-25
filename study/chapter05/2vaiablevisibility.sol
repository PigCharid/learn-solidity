// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract TestVV{
    uint public a = 1;
    uint internal b = 2;
    uint private c = 3;
    function getA()external view returns(uint){
        return a;
    }
}