// SPDX-License-Identifier: MIT
// Copyright Siddhartha Chatterjee
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Alphag3nNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCount = 0;

    enum  Rank {None, Silver, Gold, Platinum}

    struct User {
        Rank rank;
        uint256[] tokens;
    }

    mapping(address => User) private users;

    mapping(address => bool) private admins;


    constructor() ERC721("Alphag3nNFT", "G3N") {
        tokenCount = 0;
        
    }
   

    function totalSupply() public view returns (uint256) {
        return tokenCount;
    }

    function mintToken(string memory tokenURI, Rank level) 
        public
        payable
        returns (uint256)
    {   
        if (!admins[msg.sender]) {
            if (level == Rank.Silver) {
                require(msg.value > (1 ether / 20), "Cost for silver not met");
            }
            else if (level == Rank.Gold) {
                require(msg.value > (1 ether / 10), "Cost for gold not met");
            }
            else if (level == Rank.Platinum) {
                require(msg.value > (1 ether / 2), "Cost for platinum not met");
            }
            
        }
        if (level > Rank.Platinum) {
            revert("Unknown rank");
        }
        uint256 newItemId = tokenCount;
        _mint(msg.sender, newItemId);
        users[msg.sender].tokens.push(newItemId);
        if (level > users[msg.sender].rank) {
            users[msg.sender].rank = level;
        }
        _setTokenURI(newItemId, tokenURI);
        tokenCount++;
        payable(owner()).transfer(msg.value);
    
        return newItemId;

    }

    function getUser(address addr)
        public 
        view
        returns (User memory) 
    {
        return users[addr];
    }

    function addAdmin(address addr) public onlyOwner {
        admins[addr] = true;
    }
}