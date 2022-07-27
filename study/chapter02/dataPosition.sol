// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract dataPosition{
    uint[] public a;

    function pushOne()public {
        uint[] storage _a = a; //storage定义的变量属于引用传递，修改该变量会导致源数据修改
        _a.push(1);
        uint[] memory _b = new uint[](5);//memory定义的变量属于值传递 修改该变量不会导致源数据修改
        _b=_a;
        _b[0] = 100; 
    }

    function example(string calldata)external pure returns(string memory,string memory){
        return("i am example","i am example too");
    }
}