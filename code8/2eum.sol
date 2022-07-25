// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Enum{
    enum Status{
        None,
        Pendding,
        Canceled
    }
    //定义完枚举  他就是一种类型
    Status public status;

    struct Order{
        address buyer;
        Status status;
    }
    Order[] public orders;

    function get() external view returns(Status){
        return status;
    }
    function set(Status _status) external {
        status = _status;
    }
    function canceled()external{
        status = Status.Canceled;
    }

    // 枚举的默认值就是第一个值
    function reset()external{
        delete status;//删除以后就是默认值
    }

}