// SPDX-License-Identifier:MIT
pragma solidity 0.8;

//
contract DataFeed { 
    // function add(uint a,uint b) external pure returns (uint value){
    //     return a/b;
    // }
    error myError();
    function add(uint a,uint b) external pure returns (uint value){
        // revert("1");
        // require(b!=0,"b is 0");
        assert(b>0);
        // return a/b;

    }
    
}
contract FeedConsumer {
    DataFeed feed = new DataFeed();//从接口创建合约
    uint public errorCount;//记录错误次数
    function testAdd() public returns (uint _value, bool _success) {
        try feed.add(5,0) returns (uint v) {//尝试调用 外部的 getData 函数，执行成功就获得返回值，然后继续执行花括号内的内容
            return (v, true);
        } catch Error(string memory /*reason*/) {
            // 通过revert发起的错误
            errorCount = 2;
            return (100, false);
        } catch Panic(uint /*errorCode*/) {
            // 异常类型的错误会走到这里
            errorCount = 1;
            return (200, false);
        } catch (bytes memory /*lowLevelData*/) {
            // 无返回提示的底层错误，自定义错误的话会走到这里
            errorCount=8;
            return (300, false);
        }
    }
   
}