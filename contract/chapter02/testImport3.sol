// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract testImport5 is ERC721 {
    constructor() ERC721("MyCollectible", "MCO") {
    }
}