// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

struct People{
    string  Name;
    uint Age;
}

contract testP{
    struct Man{
        string  Name;
        uint Age;
    }
    // 注意定义结构体实例的时候 初始化的格式
    People public p = People("wp",25);
    People public p1 = People({Name:"no",Age:0});

    Man public m;
}  
 
contract testP1{
    People public p = People("wp",25);
    // Man public m; 合约内的结构体  除继承其他合约无法直接访问
} 