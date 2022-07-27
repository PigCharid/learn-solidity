// SPDX-License-Identifier:MIT
pragma solidity 0.8;

//接口类型，后面会介绍，如果熟悉 Golang 的接口则很容易理解。
contract DataFeed { 
    // function add(uint a,uint b) external pure returns (uint value){
    //     return a/b;
    // }
    function add(uint a,uint b) external pure returns (uint value){
        return a+b;
    }
    
}
contract FeedConsumer {
    DataFeed feed = new DataFeed();//从接口创建合约
    uint errorCount;//记录错误次数
    function testAdd() public returns (uint value, bool success) {
        try feed.add(5,0) returns (uint v) {//尝试调用 外部的 getData 函数，执行成功就获得返回值，然后继续执行花括号内的内容
            return (v, true);
        } catch Error(string memory /*reason*/) {
            // 执行 revert 语句造成的回滚，返回错误提示信息
            errorCount++;
            return (100, false);
        } catch Panic(uint /*errorCode*/) {
            // Panic类型错误。
            errorCount++;
            return (200, false);
        } catch (bytes memory /*lowLevelData*/) {
            // 无返回提示的底层错误。
            errorCount++;
            return (300, false);
        }
    }
}