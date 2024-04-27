// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FungibleToken is ERC20 {
    address owner;
    uint8 decimal;

    constructor ( string memory _name, string memory _symbol, uint256 _initialSupply, uint8 _decimal)
        ERC20(_name, _symbol)
    {
        owner = msg.sender;
        decimal = _decimal;
        mint(tx.origin, _initialSupply);
    }

    modifier onlyOwner (){
        require(msg.sender == owner, "Not Contract Owner");
        _;
    }

      function decimals() public view override returns (uint8) {
        return decimal;
    }


    function mint(address _to, uint256 _amount) public onlyOwner {
        uint amountToMint = _amount * 10**decimal;
        _mint(_to, amountToMint);
    }
}
