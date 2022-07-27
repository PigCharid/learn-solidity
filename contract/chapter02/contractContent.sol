// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract contractContent{
    uint public a; //存储上链的数据称为状态变量
    //函数
    function example()external pure returns(string memory){
        return "i am func";
    }
    // 函数修改器
    modifier M(){
        _;
    }
    // 事件
    event Log(uint l1,address ad);
    // 错误
    error myError();
    // 结构体
    struct People{
        string name;
        uint age;
    }
    // 枚举类型
    enum Status{
        None,
        Pendding,
        Canceled
    }
}