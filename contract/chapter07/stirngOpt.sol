// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract testStringOpt {
    string public greet = "Hello, ";
   
    string public s1 = "A";
    string public s2 = "A";

    bytes public b1 = abi.encodePacked(s1);
    bytes public b2 = abi.encodePacked(s2);

    function isEqual()external view returns(bool){
        if(keccak256(b1)==keccak256(b2)){
            return true;
        }
        return false;
    }

    function str(string calldata a) public view  returns (string memory){
        return string(bytes.concat(bytes(greet),bytes(a)));
    }
    function str1() public view  returns (string memory){
        return string.concat(s1,s2);
    }
}