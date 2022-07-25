// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract TestFV{
    // 有访问接口
    function externalTest()external pure returns(string memory){
        return "i am exteral";
    }
    // 有访问接口
    function publicTest()public pure returns(string memory){
        return "i am public";
    }
    // 没有访问接口
    function internalTest()internal pure returns(string memory){
        return "i am interal";
    }
    // 没有有访问接口
    function privateTest()private pure returns(string memory){
        return "i am private";
    }
    // 可以访问外部函数
    function callexternal()public view returns(string memory){
        return this.externalTest();
    }
}