// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MarketPlace {
    struct Listing {
        address seller;
        address NftAddress;
        uint256 tokenId;
        uint256 price;
        bool active;
    }

    mapping(uint256 => Listing) public listings;
    uint256 public listingCounter;

    /**
     * @dev Allows users to list their NFT for sale.
     * @param price The listing price of the NFT.
     * @param Nftcontract The address of the NFT contract.
     * @param tokenId The token ID of the NFT being listed.
     */
    function sellNft(uint256 price, address Nftcontract, uint256 tokenId) public {
        require(price > 0, "Should have some price..");

        IERC721 nft = IERC721(Nftcontract);
        require(nft.ownerOf(tokenId) == msg.sender, "You must own the NFT.");
        require(nft.getApproved(tokenId) == address(this), "Marketplace is not approved to transfer this NFT.");

        // Transfer NFT from seller to marketplace contract
        nft.transferFrom(msg.sender, address(this), tokenId);

        // Store listing details
        listings[tokenId] = Listing({
            seller: msg.sender,
            NftAddress: Nftcontract,
            tokenId: tokenId,
            price: price,
            active: true
        });

        listingCounter++;
    }

    /**
     * @dev Allows a buyer to purchase an NFT.
     * @param tokenId The token ID of the NFT being purchased.
     */
    function buyNFT(uint256 tokenId) public payable {
        Listing storage listing = listings[tokenId];

        require(listing.active, "The token is not listed...");
        require(msg.value == listing.price, "Incorrect price sent");

        // Send funds to the seller
        payable(listing.seller).transfer(msg.value);

        // Transfer NFT from marketplace contract to buyer
        IERC721(listing.NftAddress).transferFrom(address(this), msg.sender, listing.tokenId);

        // Mark listing as inactive
        listing.active = false;
    }

    /**
     * @dev Allows a seller to cancel their listing.
     * @param tokenId The token ID of the NFT being removed from sale.
     */
    function cancelList(uint256 tokenId) public {
        Listing storage listing = listings[tokenId];

        require(listing.active, "Listing should be active...");
        require(msg.sender == listing.seller, "Only the seller can cancel the listing.");

        // Transfer NFT back to the seller
        IERC721(listing.NftAddress).transferFrom(address(this), listing.seller, listing.tokenId);

        // Mark listing as inactive
        listing.active = false;
    }
}
