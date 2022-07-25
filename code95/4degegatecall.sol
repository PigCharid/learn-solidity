// SPDX-License-Identifier:MIT
pragma solidity ^0.8;



contract testdegegatecall {
    uint public num;
    address public sender;
    uint public value;
    function setVals(uint _num)external payable{
        //num = _num;
        num = 2*_num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract degegatecall{
    uint public num;
    address public sender;
    uint public value;
    function setVals(address _test,uint _num)external payable{
        // 一种写法
        //_test.delegatecall(abi.encodeWithSignature("setVals(uint256)",_num));

        // 两种方法一样
        (bool success,bytes memory data)=_test.delegatecall(
            abi.encodeWithSelector(testdegegatecall.setVals.selector,_num)
        );
        require(success,"delegatecall failde");
    }
}

// 