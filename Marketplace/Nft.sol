// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract Nft is ERC721URIStorage, Ownable{
    uint256 _tokenID;
    uint256 public constant MAX_SUPPLY = 100;
   constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {}


   function MintNft(address to, string memory tokenURI) public returns (uint256) {
    _tokenID++;
    uint256 newTokenId = _tokenID;
    _mint(to, newTokenId);
    _setTokenURI(newTokenId, tokenURI);  // ✅ Correct usage
    return newTokenId;
    }


}