pragma solidity ^0.4.24;
import './interfaces/ISmartToken.sol';
import './ERC20Token.sol';
import './Owned.sol';
import './Utils.sol';
import './safeMath.sol';

contract SmartToken is ISmartToken, ERC20Token, Owned {
    using SafeMath for uint256;

    bool public transferEnabled = true;

    event NewSmartToken(address _token);
    event Issue(address _to, uint256 _value);
    event Destroy(address _from, uint256 _value);


    modifier transferAllowed {
        assert(transferEnabled);
        _;
    }

    constructor (string _name, string _symbol, uint8 _decimal) public  ERC20Token(_name, _symbol, _decimal)
    {
        emit NewSmartToken(address(this));
    }


    function disableTransfer(bool _disable) public ownerOnly {
        transferEnabled = ! _disable;
    }

    function issue(address _to, uint256 _value) public ownerOnly validAddress(_to) notThis(_to) {
        totalSupply = totalSupply.add(_value);
        balanceOf[_to]=balanceOf[_to].add(_value);
        emit Issue(_to, _value);
    }

    function destroy(address _from, uint256 _value){
        require(msg.sender == _from || msg.sender ==  owner);
        totalSupply = totalSupply.sub(_value);
        balanceOf[_from]=balanceOf[_from].sub(_value);
        emit Destroy( _from, _value);
    }

    function transfer(address _to, uint256 _value) public  transferAllowed returns (bool sucess){
        assert(super.transfer(_to, _value));
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public transferAllowed returns (bool success) {
        assert(super.transferFrom(_from, _to, _value));
        return true;
    }
}
