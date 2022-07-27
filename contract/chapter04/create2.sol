// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

 contract D{
     uint public arg;
     constructor(uint _arg){
         arg = _arg;
     }
 }

contract Create2{
     D public d;
    function getBytes32(uint slat)external pure returns(bytes32){
        return bytes32(slat);
    }
    //这里是计算合约地址的方法
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

    function createDSalted(bytes32 salt,uint arg)public{
        d = new D{salt: salt}(arg);
    }
}