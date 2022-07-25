// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testContract{
    uint public x;
    uint public value = 123;

    function setX(uint _x)external {
        x =_x;
    }
    function getX()external view returns(uint){
        return x;
    }
    function setXandReceiveEth(uint _x)external payable{
        x=_x;
        value = msg.value;
    }
}
contract callContract{
    function setX(address _test,uint _x)external{
        testContract(_test).setX(_x);//合约类型（合约地址）.合约方法
        // 在这个合约中，TestContract这个合约类型是我们知道的
    }

    // 第二种方法  直接吧参数变成合约类型
    // function setXx(TestContract _test,uint _x)external{
    //     _test.setX(_x);  
    // }
    function getX(address _test)external view returns(uint){
        return testContract(_test).getX();
    }
     function setXandReceiveEth(address _test,uint _x)external payable{
        testContract(_test).setXandReceiveEth{value:msg.value}(_x);//这样才能调用会接受主币的方法 把所有主币都传给调用的合约
    }

}
