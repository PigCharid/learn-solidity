// SPDX-License-Identifier:MIT

pragma solidity ^0.8;

contract testArray{
    uint[] public num;
    uint[3] public numFixed;
    //定义时赋初始值的方式
    uint[] public num1 = [1,2];
    uint[3] public numFixed1 = [3,4,5]; 
    
    function example()external{
        
        //num[0]=1;  不能直接通过下标传入  调用的时候会报错   因为此时的数字长度为0
        
        num.push(1);//动态数组像尾部添加数据，和Go的append相似
        num[0] = 5; //push一次数组的长度增加了1   这个时候就可以通过下标来访问数组了

        num.pop();  //pop以后数  会删除最后一个元素 长度减一  
        // 在这里如果访问num[0]的话会报错   所以以后养成好的习惯  访问数组前先判断一下数组的长度

        num.push(2);
        num.push(3);

        delete num[0];//删除  但是不会减少长度  改成默认值
        
        // 局部变量
        uint[] memory  a =new uint[](5); //函数中不能创建动态数组  要指定长度
        // 局部的数组 push 和pop都不能用  会改变长度
        a[0]=1;  //定长的数组 
    }

}