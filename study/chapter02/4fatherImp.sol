// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
function outside()pure returns(uint){
    return 1;
}
contract FatherImp{
    uint   a = 100;
    function Test()public pure returns(string memory ){
        return "this is a test";
    }
}