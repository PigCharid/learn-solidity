// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract A{
    function funA()external pure virtual returns(string memory ){
        return "A";
    }
    function funAB()external pure virtual returns(string memory ){
        return "AB";
    }
}

contract B is A{
 function funA()external pure override returns(string memory ){
        return "B";
    }
}