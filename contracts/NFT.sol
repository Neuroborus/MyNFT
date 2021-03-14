// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol'; //Token standart for NFT, allows to manipulate some NFT token

contract NFT is ERC721{
    constructor(
        string memory name,
        string memory symbol
    ) public 
    ERC721(name, symbol){

    }

    function mint(address to, uint tokenId) external {
        _mint(to, tokenId);
    }
}