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
 function funA()external pure override virtual returns(string memory ){
        return "B";
    }
}
contract C is A,B{
    // 多线继承的时候  如果两个父类都有同一个方法的时候   那么在重写的时候要指明到底是重写哪一个
 function funA()external pure override(A,B) returns(string memory ){
        return "Z";
    }
}