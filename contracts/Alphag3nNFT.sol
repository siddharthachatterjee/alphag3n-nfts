// SPDX-License-Identifier: MIT
// Copyright Siddhartha Chatterjee
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Alphag3nNFT is ERC721URIStorage, Ownable {
    uint public tokenCount = 0;


    constructor() ERC721("Alphag3nNFT", "G3N") {
        tokenCount = 0;
        
    }
   

    function totalSupply() public view returns (uint256) {
        return tokenCount;
    }
}