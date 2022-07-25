// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract innerFunc{
    // 区块相关
    uint public blocknumber=block.number; //区块号
    uint public blocktimestamp=block.timestamp;//区块生成的时间
    uint public blockgaglimt = block.gaslimit;//当前区块的gas限制
    uint public blockdifficulty = block.difficulty;//当前区块难度
    address public blockcoinbase = block.coinbase;//当前区块的旷工地址
    uint public chainID = block.chainid;//当前链的ID

    //合约调用相关
    bytes public msgbytes = msg.data;//完整的calldata
    address public msgsender = msg.sender;//合约调用者
    bytes4 public funcname = msg.sig;//calldata 的前 4 字节（也就是函数标识符）
    uint public msgvalue = msg.value;//调用合约的时候携带的主币数量

    //交易相关
    uint public txgasprice=tx.gasprice;//交易的当前gas
    address public txorigin =tx.origin;
}