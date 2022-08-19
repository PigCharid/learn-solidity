// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract SimpleAuction {
    
    // 受益人
    address payable public beneficiary;
    
    // 结束时间
    uint public auctionEndTime;

    // 最高出价人
    address public highestBidder;
    
    // 最高出价
    uint public highestBid;

    // 出价记录
    mapping(address => uint) pendingReturns;

    // 拍卖结束后设为 true，将禁止所有的变更
    bool ended;

    // 变更触发的事件
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    // 拍卖已经结束
    error AuctionAlreadyEnded(string);
    // 出价不够高
    error BidNotHighEnough(uint highestBid);
    // 拍卖还未结束
    error AuctionNotYetEnded(string);
    // 拍卖结束已经被调用
    error AuctionEndAlreadyCalled(string);

    // 传入拍卖时常 和收益地址
    constructor(
        uint biddingTime,
        address payable beneficiaryAddress
    ) {
        beneficiary = beneficiaryAddress;
        auctionEndTime = block.timestamp + biddingTime;
    }

    // 出价
    function bid() external payable {
        // 对于能接收以太币的函数，关键字 payable 是必须的。

        // 如果拍卖已结束，撤销函数的调用。
        if (block.timestamp > auctionEndTime)
            revert AuctionAlreadyEnded("ended");

        // 如果出价不够高，返还你的钱
        if (msg.value <= highestBid)
            revert BidNotHighEnough(highestBid);

        if (highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    /// 取回出价（当该出价已被超越）
    function withdraw() external returns (bool) {
        require(msg.sender!=highestBidder,"can not back");
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // 这里很重要，首先要设零值。
            // 因为，作为接收调用的一部分，
            // 接收者可以在 `send` 返回之前，重新调用该函数。   哦~~~~  重入攻击啊
            pendingReturns[msg.sender] = 0;

            // 把钱转回去
            if (!payable(msg.sender).send(amount)) {
                // 这里不需抛出异常，只需重置未付款
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /// 结束拍卖，并把最高的出价发送给受益人
    function auctionEnd() external {
     
        if (block.timestamp < auctionEndTime)
            revert AuctionNotYetEnded("not ended");
        if (ended)
            revert AuctionEndAlreadyCalled("called ended");

        // 2. 生效
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // 3. 交互
        beneficiary.transfer(highestBid);
    }
}