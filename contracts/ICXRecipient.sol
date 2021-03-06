// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

 /**
 * @title Contract that will work with ERC223 tokens.
 */
 
interface ICXRecipient { 
/**
 * @dev Standard function that will handle incoming CX transfers to the Vault.
 *
 * @param _from  Token sender address.
 * @param _value Amount of tokens.
 */
  function tokenFallback(address payable _from, uint _value) external returns (bool);
}