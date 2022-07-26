// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testAssignment{
    uint[20] public x;
     function f() public {
        g(x);
        h(x);
    }

     function g(uint[20] memory y) internal pure {
        y[2] = 3;
    }

     function h(uint[20] storage y) internal {
        y[3] = 4;
    }
}