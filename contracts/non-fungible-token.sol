// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^4.0.0
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NonFungibleToken is ERC721, ERC721URIStorage {
    uint128 increamentingTokenId;
    address owner;

    constructor( string memory _name, string memory _symbol, string memory _uri)
        ERC721(_name, _symbol)
    {
        owner = msg.sender;
        safeMint(tx.origin, _uri);
    }

    modifier onlyOwner (){
        require(msg.sender == owner);
        _;
    }

    function safeMint(address to, string memory uri)
        public
        onlyOwner
    {
        _safeMint(to, increamentingTokenId);
        _setTokenURI(increamentingTokenId, uri);
        increamentingTokenId++;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}



