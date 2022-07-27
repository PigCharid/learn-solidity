// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testMap{
    mapping(address=>uint) public balance;
    mapping(address=>bool) public isInsert;
    address[] public keys;
    function set(address key,uint value)external{
        balance[key] = value;
        if(!isInsert[key]){
            isInsert[key] = true;
            keys.push(key);
        }
    }
    function getSize()external view returns(uint){
        return keys.length;
    }
    function getSomeOnesBalance(uint i)external view returns(uint){
        return balance[keys[i]];
    }
}