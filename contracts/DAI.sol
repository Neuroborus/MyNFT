// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/IERC721.sol'; //Token standart for NFT, allows to manipulate some NFT token
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';  //Token standart for fungible token, allow to buy, share
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

//decentralized cryptocurrency stabilized against the value of the US dollar
contract DAI is ERC20 {
    constructor() public ERC20('DAI Stablecoin', 'DAI'){

    }

    function mint(address to, uint amount) external {
        _mint(to, amount);
    }
}