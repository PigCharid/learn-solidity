// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test5{
    // string public str1 = "智能合约"; 不能赋值中文
    string public str2 = unicode"智能合约";
}


contract test4{
    bytes public a = hex"0111";
}







contract test3{
    string public str1 = "foo""aaa";
    //string public str1 = "foo"+"aa";//加号拼接是不行的
    bytes1 public by1 = "s";
    string public str2 = "foo\n";
    string public str3 = "foo\x0001";
    string public str4 = "foo""aaa";
}




contract test2{
    uint public a = 123_000;  //123000
    //uint public b = 123__000;连续下划线出错
    uint public b = 123_0_00;
    uint public c = 2e10;
    //uint public d = 2_e10;  数字字母之间不能添加下划线
}




contract test1{
    //address public addr1 = 0x7cb57b5a97eabe94205c07890be4c1ad31e486a8;//该地址没有通过校验和（checksum），会报错
    address public addr1 = 0x7cB57B5A97eAbe94205C07890BE4c1aD31E486A8;
    address public addr2 =address(0);
    //address public addr3 = 0x1111111111111111111A11111111111111111111;  无法通过校验的值就不能进行赋值
}