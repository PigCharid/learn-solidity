// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Purchase {
    // 
    uint public value;
    // 卖家
    address payable public seller;
    // 买家
    address payable public buyer;
    // 枚举
    enum State { Created, Locked, Release, Inactive }

    State public state;

    
    modifier condition(bool condition_) {
        require(condition_);
        _;
    }

    /// 买方特权
    error OnlyBuyer();
    /// 卖方调用
    error OnlySeller();
    /// The function cannot be called at the current state.
    error InvalidState();
    /// The provided value has to be even.
    // 为偶数值？
    error ValueNotEven();

    // 买卖双方修饰词
    modifier onlyBuyer() {
        require(
            msg.sender == buyer,
            "Only buyer can call this."
        );
        _;
    }

    modifier onlySeller() {
        require(
            msg.sender == seller,
            "Only seller can call this."
        );
        _;
    }

    // 只能是枚举限制的状态
    modifier inState(State _state) {
        require(
            state == _state,
            "Invalid state."
        );
        _;
    }

    // 几个时间
    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerRefunded();

    // 传入卖家地址和价格  value为传入合约代币数量的一半
    constructor() payable {
        seller = payable(msg.sender);
        value = msg.value / 2;
        if ((2 * value) != msg.value)
            revert ValueNotEven();
    }


    ///中止购买并回收以太币。
    ///只能在合约被锁定之前由卖家调用。
    function abort()external onlySeller inState(State.Created){
        emit Aborted();
        state = State.Inactive;
        seller.transfer(address(this).balance);
    }

    /// 买家确认购买。
    /// 交易必须包含 `2 * value` 个以太币。
    /// 以太币会被锁定，直到 confirmReceived 被调用。
    function confirmPurchase() external inState(State.Created) condition(msg.value == (2 * value))payable{
        emit PurchaseConfirmed();
        buyer = payable(msg.sender);
        state = State.Locked;
    }

    // 退还一半
    function confirmReceived() external onlyBuyer inState(State.Locked){
        emit ItemReceived();
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        state = State.Release;
        buyer.transfer(value);
    }

    /// This function refunds the seller, i.e.
    /// pays back the locked funds of the seller.
    function refundSeller()external onlySeller inState(State.Release){
        emit SellerRefunded();
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        state = State.Inactive;

        seller.transfer(3 * value);
    }
}