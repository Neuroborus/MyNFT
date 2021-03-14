// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/IERC721.sol'; //Token standart for NFT, allows to manipulate some NFT token
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';  //Token standart for fungible token, allow to manipulate of die, buy, share
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

//Refungible token
contract RFT is ERC20{
 uint public icoSharePrice;
 uint public icoShareSupply;
 uint public icoEnd;  //If limited in time
 
 uint public nftId;
 IERC721 public nft;
 IERC20 public dai;

 address public admin; 

 constructor(
   string memory _name, //Name of refungible token
   string memory _symbol,
   address _nftAddress,
   uint _nftId,
   uint _icoSharePrice,
   uint _icoShareSupply,
   address _daiAddress
 ) public

 ERC20(_name, _symbol){
   nftId = _nftId;
   nft = IERC721(_nftAddress);
   icoSharePrice = _icoSharePrice;
   icoShareSupply = _icoShareSupply;
   dai = IERC20(_daiAddress);
   admin = msg.sender; 
 }

 function startIco() external {
   require(msg.sender==admin, 'only admin');
   nft.transferFrom(msg.sender, address(this), nftId);
   icoEnd = block.timestamp + 7 * 86400;  //1 week
 }

  function buyShare(uint shareAmount) external {
    require(icoEnd>0, 'ICO not started yet');
    require(block.timestamp <= icoEnd, 'ICO is finished');
    require(totalSupply()+shareAmount<=icoShareSupply, 'not enough shares left');
    uint daiAmount = shareAmount * icoSharePrice;
    dai.transferFrom(msg.sender, address(this), daiAmount);
    _mint(msg.sender, shareAmount);
  }

  function withdrawProfits() external{
    require(msg.sender == admin, 'only admin');
    require(block.timestamp > icoEnd, 'ICO not finished yet');
    uint daiBalance = dai.balanceOf(address(this));
    if(daiBalance > 0) {
      dai.transfer(admin, daiBalance);
    }
    uint unsoldShareBalance = icoShareSupply - totalSupply();
    if(unsoldShareBalance > 0) {
      _mint(admin, unsoldShareBalance);
    }
  }

}
