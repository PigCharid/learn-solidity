// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract Hello {
    string public greet = "Hello, ";
    function str(string calldata a) public view  returns (string memory){
        return string(bytes.concat(bytes(greet),bytes(a)));
    }
    string public s = "A";
    string public s1 = "B";

    bool public equal;
    function isEqual()external returns(bool){
        
    }
}