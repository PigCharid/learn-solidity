// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract Ownable{
    address public Owner;
    constructor(){
        Owner = msg.sender;
    }
    modifier OnlyOwner(){
        require(msg.sender == Owner,"not owner");
        _;
    }
    function setNewOwner(address _address) public OnlyOwner{
        require(_address!=address(0),"can not use 0 address");
        Owner = _address;
    }
    function test1()external OnlyOwner{

    }
    function test2()external {
        
    }
    
}