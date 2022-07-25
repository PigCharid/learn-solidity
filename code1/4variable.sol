//SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Variable{
    address public add=address(1);
    
    // 发现一种错误写法   下面的写法会报错，只能按上面的写法来
    // 但是在函数中去修改状态变量的值就是可以的，这应该是一种变量赋值的方式吧
    // address public add;
    // add=address(1);
    // uint public a;
    // a =3;

   
}