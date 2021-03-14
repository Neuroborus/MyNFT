// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

//The Dai contract is the user-facing ERC20 token contract maintaining the accounting for external Dai balances
contract DAI is ERC20 {
    constructor() public ERC20('DAI Stablecoin', 'DAI'){

    }

    function mint(address to, uint amount) external {
        _mint(to, amount);
    }
}