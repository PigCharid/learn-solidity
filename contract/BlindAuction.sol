// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
contract BlindAuction {
    
    // 出价结构体
    struct Bid {
        bytes32 blindedBid;
        uint deposit;
    }

    // 收益地址
    address payable public beneficiary;
    // 
    uint public biddingEnd;
    
    uint public revealEnd;
    
    // 结束标志
    bool public ended;

    // 一个地址对应一个出价结构体数组
    mapping(address => Bid[]) public bids;

    // 最高出价者
    address public highestBidder;
    
    // 最高出价
    uint public highestBid;

    // 可取回资金的记录
    mapping(address => uint) pendingReturns;

    event AuctionEnded(address winner, uint highestBid);

    // 太早了 
    error TooEarly(uint time);
    // 太迟了
    error TooLate(uint time);
    // 已经调用结束了
    error AuctionEndAlreadyCalled();

    // 时间修饰器
    modifier onlyBefore(uint time) {
        if (block.timestamp >= time) revert TooLate(time);
        _;
    }
    modifier onlyAfter(uint time) {
        if (block.timestamp <= time) revert TooEarly(time);
        _;
    }

    // 盲出价时间和验证价格时间
    constructor(
        uint biddingTime,
        uint revealTime,
        address payable beneficiaryAddress
    ) {
        beneficiary = beneficiaryAddress;
        biddingEnd = block.timestamp + biddingTime;
        revealEnd = biddingEnd + revealTime;
    }

    
    function bid(bytes32 blindedBid)external payable onlyBefore(biddingEnd){
        bids[msg.sender].push(Bid({
            blindedBid: blindedBid,
            deposit: msg.value
        }));
    }

    function myBiddData(uint value,bool fake,bytes32 secret)external pure returns(bytes32 blindedBid){
        blindedBid = keccak256(abi.encodePacked(value,fake,secret));
    }

    // 盲拍结束之后  real结束之前
    function reveal( uint[] calldata values,bool[] calldata fakes, bytes32[] calldata secrets) external onlyAfter(biddingEnd) onlyBefore(revealEnd){
        // 获取出价的次数
        uint length = bids[msg.sender].length;

        //传入的参数长度和出价次数要对应
        require(values.length == length);
        require(fakes.length == length);
        require(secrets.length == length);
        // 记录退款金额
        uint refund;
        // 一个一个检查出价
        for (uint i = 0; i < length; i++) {
            Bid storage bidToCheck = bids[msg.sender][i];
            (uint value, bool fake, bytes32 secret) =(values[i], fakes[i], secrets[i]);
            if (bidToCheck.blindedBid != keccak256(abi.encodePacked(value, fake, secret))) {
                // Bid was not actually revealed.
                // Do not refund deposit.
                continue;
            }
            // 记录退款数量
            refund += bidToCheck.deposit;
            // 如果不退回  并且质押量大于value
            if (!fake && bidToCheck.deposit >= value) {
                if (placeBid(msg.sender, value))
                    refund -= value;
            }
            // 置0就不能退款了，因为申请退款也只是退回0
            bidToCheck.blindedBid = bytes32(0);
        }
        payable(msg.sender).transfer(refund);
    }

    /// 提现
    function withdraw() external {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `transfer` returns (see the remark above about
            // conditions -> effects -> interaction).
            pendingReturns[msg.sender] = 0;

            payable(msg.sender).transfer(amount);
        }
    }

    // 验价结束  收益转出
    function auctionEnd()external onlyAfter(revealEnd){
        if (ended) revert AuctionEndAlreadyCalled();
        emit AuctionEnded(highestBidder, highestBid);
        ended = true;
        beneficiary.transfer(highestBid);
    }

    // 检查这个价格是不是最高出价并替换
    function placeBid(address bidder, uint value) internal returns (bool success){
        if (value <= highestBid) {
            return false;
        }
        if (highestBidder != address(0)) {
            // Refund the previously highest bidder.
            pendingReturns[highestBidder] += highestBid;
        }
        highestBid = value;
        highestBidder = bidder;
        return true;
    }
}