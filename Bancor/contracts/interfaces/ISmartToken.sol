pragma solidity ^0.4.24;
import './IERC20Token.sol';

contract ISmartToken is IERC20Token {
    function issue(address _to, uint256 _value) public;
    function disableTransfer(bool _disable) public;
    function destroy(address _from, uint256 _value) public;
}