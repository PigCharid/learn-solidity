// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract VM{
    struct MyStruct{
        uint foo;
        string text;
    }
    mapping(address=>MyStruct) public myStructs;

    function example(uint[] calldata y,string memory s)external returns(uint[] memory){
        myStructs[msg.sender]=MyStruct({foo:123,text:"wp"});
        MyStruct storage my = myStructs[msg.sender];
        my.foo = 567;
        MyStruct memory my1 = myStructs[msg.sender];
        my1.foo=890;

        example1(y);
        uint[] memory myArr =new uint[](3);
        myArr[0]=123;
        return myArr;

    }
    function example1(uint[] calldata y)public pure returns(uint[] memory){
        return y;
    }

}