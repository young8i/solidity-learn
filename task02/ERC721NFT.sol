// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract ERC721NFT is ERC721URIStorage {

    uint256 private _tokenIds;

    constructor() ERC721("MyNFT", "MNFT") {}

    function mintNFT(address recipient, string memory tokenURI) public returns (uint256) {
        _tokenIds += 1;

        uint256 newItemId = _tokenIds;

        _mint(recipient, newItemId);
        
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

}