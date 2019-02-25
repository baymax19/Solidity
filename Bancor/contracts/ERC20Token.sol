pragma solidity ^0.4.24;
import './interfaces/IERC20Token.sol';
import './Utils.sol';
import './safeMath.sol';

contract ERC20Token is IERC20Token, Utils {
    using SafeMath for uint256;

    string public name = '';
    string public symbol = '';
    uint8 public decimals = 0;
    uint256 public totalSupply = 0;
    mapping (address=> uint256) public balanceOf;
    mapping (address=> mapping (address=>uint256)) public allowance;

    event Transfer(address _from, address _to,  uint256 _amount);
    event Approval(address _owner, address _spender, uint256 _amount);

    constructor(string _name, string _symbol,  uint8 _decimal) public {
        require(bytes(_name).length>0 && bytes(_symbol).length > 0);

        name =  _name;
        symbol = _symbol;
        decimals = _decimal;
    }

    function transfer(address _to, uint256 _value) 
    public validAddress(_to) 
    returns (bool success){
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to]=balanceOf[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;

    }

    function transferFrom(address _from, address _to,uint256 _value) public validAddress(_from) validAddress(_to)  returns (bool sucess){
        
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        balanceOf[_from]= balanceOf[_from].sub(_value);
        balanceOf[_to]= balanceOf[_to].add(_value);
        emit Transfer(_from, _to, _value);
    
        return true;
    }

    function approve(address _spender, uint256  _value) public validAddress(_spender) returns(bool sucess){
            require (allowance[msg.sender][_spender] == 0);
            allowance[msg.sender][_spender]=_value;
            emit Approval (msg.sender,_spender,_value);
            return true;
    }


}
