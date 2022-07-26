// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

 contract D{
     uint public arg;
     constructor(uint _arg){
         arg = _arg;
     }
 }

contract Create2{
    function getBytes32(uint slat)external pure returns(bytes32){
        return bytes32(slat);
    }
    function getAddress(uint slat,uint arg) external view returns(address){
        address add = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            slat,
            keccak256(abi.encodePacked(
                type(D).creationCode,
                arg
            ))
        )))));
        return add;
    }
    address public deployedAddr;
    function createDSalted(bytes32 salt,uint arg)public{
        D d = new D{salt: salt}(arg);
        deployedAddr = address(d);
    }
}