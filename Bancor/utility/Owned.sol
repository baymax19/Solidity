pragma solidity ^0.4.24;


contract Owned{

    address public owner;
    address public newOwner;

    event UpdateOwner(address  _from, address _to);


    modifier ownerOnly {
        require(msg.sender == owner);
        _;
    }

    constructor () public{
        owner = msg.sender;
    }


}