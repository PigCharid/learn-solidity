// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testArrySlice{
    //被当前合约管理的 客户端合约地址
    address client;

    constructor(address client_) {
        client = client_;
    }
    bytes public b = abi.encodePacked("setOwner(address)",0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

    // 在进行参数验证之后，转发到由client实现的 "setOwner(address)"
    function forward(bytes calldata payload) external {
        bytes4 sig = bytes4(payload[:4]);

        // 由于截断行为，与执行 bytes4(payload) 是相同的
        // bytes4 sig = bytes4(payload);

        if (sig == bytes4(keccak256("setOwner(address)"))) {
            address owner = abi.decode(payload[4:], (address));
            require(owner != address(0), "Address of owner cannot be zero.");
        }
        (bool status,) = client.delegatecall(payload);
        require(status, "Forwarded call failed.");
    }
}