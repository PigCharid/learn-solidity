// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
abstract contract Feline {
  function utterance() public pure virtual returns (bytes32);
}

contract Cat is Feline {
  function utterance() public pure override returns (bytes32) { return "miaow"; }
}