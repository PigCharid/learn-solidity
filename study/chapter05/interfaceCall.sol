// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

// 用一个新的接口合约  名字随便起
// 写一个接口合约  把这个合约你要调用的方法写个抽象方法 方法名和参数要一致
interface anyName{
    function setX(uint _y)external;
}


contract callInterface{
    function example(address _test)external{
        //按照这样的格式调用
        anyName(_test).setX(10);
    }
}