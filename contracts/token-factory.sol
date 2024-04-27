// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.20;

import "./non-fungible-token.sol";
import "./fungible-token.sol";


contract TokenFactory { 
    struct NFTDetails {
        string name ;
        string symbol;
        address contractAdd;
        string description;
    }

    struct FungibleTokenDetails {
        string name ;
        string symbol;
        address contractAdd;
        uint totalSupply;
        string description;
        uint8 decimals;
    }

    NFTDetails[] NFTs; 
    FungibleTokenDetails[] FungibleTokens;

    mapping (address => NFTDetails[]) getNftDetails;
    mapping (address => FungibleTokenDetails[]) getFungibleTokenDetails;


    event NftCreated(address indexed NftAddress, address indexed creator);
    event FungibleTokenCreated(address indexed tokenAddress, address indexed creator);

    function createNFT(string memory _name, string memory _symbol, string memory _uri, string memory _description) external{
        NonFungibleToken newNftToken = new NonFungibleToken(_name, _symbol, _uri);
        NFTDetails memory nft;
        nft.name = _name;
        nft.symbol = _symbol;
        nft.contractAdd = address(newNftToken);
        nft.description = _description;
        getNftDetails[msg.sender].push(nft);
        NFTs.push(nft);
        emit NftCreated(address(newNftToken), msg.sender);
    }

    function createFungibleToken(string memory _name, string memory _symbol, uint256 _initialSupply, string memory _description, uint8 _decimals) external{
        FungibleToken newFungibleToken = new FungibleToken(_name, _symbol, _initialSupply, _decimals);
        FungibleTokenDetails memory ft;
        ft.contractAdd = address(newFungibleToken);
        ft.name = _name;
        ft.symbol = _symbol;
        ft.totalSupply = _initialSupply;
        ft.description = _description; 
        ft.decimals = _decimals;
        getFungibleTokenDetails[msg.sender].push(ft);
        FungibleTokens.push(ft);
        emit FungibleTokenCreated(address(newFungibleToken), msg.sender);
    }

    function getAllNftContract() external view returns (NFTDetails[] memory) {
        return NFTs;        
    }

    function getAllFungibleToken() external view returns (FungibleTokenDetails[] memory){
        return FungibleTokens;
    }

    function getCreatedNFTByAddress(address addr) external view returns (NFTDetails[] memory){
        return getNftDetails[addr];
    }

    function getCreatedFungibleTokenByAddress(address addr) external view returns (FungibleTokenDetails[] memory) {
        return getFungibleTokenDetails[addr];
    }
}