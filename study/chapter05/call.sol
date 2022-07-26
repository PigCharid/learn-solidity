// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract test{
    uint public x;
    function setX(uint a)external {
        x = a;
    }
}

contract Call{
    function example(address _test)external returns(bool success,bytes memory data){
        (success,data)=_test.call(abi.encodeWithSignature("setX(uint256)",123));
    }

     function example1(address _test)external returns(bool success,bytes memory data){
        (success,data)=_test.call(abi.encodeWithSignature("setB(uint256)",122));
    }
}