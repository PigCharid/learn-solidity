// SPDX-License-Identifier:MIT
pragma solidity ^0.8;


contract TestHash{
    // 智能合约hash算法返回结果是定长的bytes32
    function hash(string memory text,uint num,address ad)external pure returns(bytes32){
        // 合约的内部hash函数
       return keccak256(abi.encodePacked(text,num,ad));
    }

    // 两种打包方法的比较   所有不定长都要加上memory
    function encode(string memory text1,string memory text2)external pure returns(bytes memory){
        //  会把字符串变成16进制  然后补0
        return abi.encode(text1,text2);
    }


    function encodePacked(string memory text1,string memory text2)external pure returns(bytes memory){
       
    //    直接变成16进制 不会补0
        // 会有bug AAAA BBB   和AAA  ABBB的结果一样
        // 解决方法很多  encode就行  参数之间进行隔离
        return abi.encodePacked(text1,text2);
    }
}