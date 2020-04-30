pragma solidity >=0.5.8;

import './base/IERC20.sol';
import './base/ITranchTokenHelper.sol';

/**
 * @dev An Policy tranch.
 */
contract TranchToken is IERC20 {
  ITranchTokenHelper public impl;
  uint256 public index;

  constructor (address _impl, uint256 _index) public {
    impl = ITranchTokenHelper(_impl);
    index = _index;
  }

  // ERC-20 queries //

  function name() public view returns (string memory) {
    return impl.tknName(index);
  }

  function symbol() public view returns (string memory) {
    return impl.tknSymbol(index);
  }

  function totalSupply() public view returns (uint256) {
    return impl.tknTotalSupply(index);
  }

  function balanceOf(address owner) public view returns (uint256) {
    return impl.tknBalanceOf(index, owner);
  }

  function decimals() public view returns (uint8) {
    return 18;
  }

  function allowance(address owner, address spender) public view returns (uint256) {
    return impl.tknAllowance(index, spender, owner);
  }

  // ERC-20 mutations //

  function approve(address spender, uint256 value) public returns (bool) {
    impl.tknApprove(index, spender, msg.sender, value);
    emit Approval(msg.sender, spender, value);
    return true;
  }

  function transfer(address to, uint256 value) public returns (bool) {
    impl.tknTransfer(index, msg.sender, msg.sender, to, value);
    emit Transfer(msg.sender, to, value);
    return true;
  }

  function transferFrom(address from, address to, uint256 value) public returns (bool) {
    impl.tknTransfer(index, msg.sender, from, to, value);
    emit Transfer(from, to, value);
    return true;
  }
}