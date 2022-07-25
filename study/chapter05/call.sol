// SPDX-License-Identifier:MIT
pragma solidity ^0.8;


contract Call{
    function example(address _test)external returns(bool success,bytes memory data){
        // 里面那个是函数名和参数类型  uint必须写成uint256
        // 两个返回值 一个返回成功是否  一个是装载函数的返回值
        // 如果写的函数名字不存在的话  那么触达回退函数
        (success,data)=_test.call(abi.encodeWithSignature("setX(uint256)",123));
    }
}