// SPDX-License-Identifier:MIT
pragma solidity 0.8;

// require revert assert
// 自定义错误  节省gas
contract error{

    function testRequire(uint i)external pure{
        require(i<10,"i>10");//i>10时  就是条件不满足时触发
    }

    function testRevert(uint i)external pure{
        if(i>10){
            revert("i>10");
        }
    }
    function testAssert(uint i)external pure{
        assert(i>10);//判断为false时会报错
    }
    // 下面看看gas   和状态的回滚
    uint public num =1;
    function foo(uint i)external{
        num+=1;
        require(i>10,"i<10back");
    }

    // 下面使用自定义错误  节约gas
    // 是通过revert触发的
    error myError(address caller,uint i);
    function testMyError(uint i)external view{
        if(i>10){
            revert myError(msg.sender,i);
        }
    }

}