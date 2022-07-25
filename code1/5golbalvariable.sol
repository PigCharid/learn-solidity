//SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract MultipleReturn{
    function getGlobalVariable()public view returns(address,uint,uint){
        address add = msg.sender;
        uint timeStamp = block.timestamp;
        uint bl = block.number;
        return(add,timeStamp,bl);
    }
}