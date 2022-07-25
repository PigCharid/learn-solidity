// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract D {
    uint public x;
    constructor(uint a) {
        x = a;
    }
}
contract C {
    D public d;
    


    function createDSalted(bytes32 salt, uint arg) public {
        /// 这个复杂的表达式只是告诉我们，如何预先计算合约地址。
        /// 这里仅仅用来说明。
        /// 实际上，你仅仅需要  new D{salt: salt}(arg)
        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(abi.encodePacked(
                type(D).creationCode,
                arg
            ))
        )))));
        d = new D{salt: salt}(arg);
        require(address(d) == predictedAddress);
    }
}