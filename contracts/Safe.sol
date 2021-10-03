// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./ICXRecipient.sol";

contract Safe is ICXRecipient {
  using SafeMath for uint256;
  using Address for address;

  // The CX token
  IERC20 public CX;
  address public CXAddress;

  // The circulating supply of the CX token
  uint256 public circulatingSupply;
  
  // To handle receiving ETH payments
  receive() external payable {}

  constructor (address _CX) public {
    // Initializing CX token as ERC 20
    CX = IERC20(_CX);
    CXAddress = _CX;
    // Initially, circulating supply is token supply
    circulatingSupply = CX.totalSupply();
  }
  
  // Returns the ETH locked in the Safe
  function getSafeETHBalance() public view returns (uint256) {
    return address(this).balance;
  }

  // Returns the amount of CX tokens locked in the Safe
  function getSafeCXBalance() public view returns (uint256) {
    return CX.balanceOf(address(this));
  }

  // Returns the current circulating supply of the CX token
  function getCirculatingSupply() public view returns (uint256) {
    return circulatingSupply;
  }

  function tokenFallback(address payable _from, uint _value) public override returns (bool) {
    require(msg.sender == CXAddress, "Only Safe token can call this function");
    sendBackEth(_from, _value);
    return true;
  }

  // Swaps CX tokens for ETH
  function sendBackEth(address payable _from, uint256 _tokenAmount) internal {
    require(getSafeETHBalance() > 0, "Safe has no ETH");

    uint256 tokenPerEth = getCirculatingSupply().div(getSafeETHBalance());
    uint256 totalEth = _tokenAmount.div(tokenPerEth);
    address payable swapInitator = _from;

    swapInitator.transfer(totalEth);

    circulatingSupply = circulatingSupply.sub(_tokenAmount);
  }
}