// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ImovelNFT
 * @dev Representação digital (NFT) das propriedades físicas da DAO.
 */
contract ImovelNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner) ERC721("RealEstate Asset", "REA") Ownable(initialOwner) {}

    /**
     * @dev Função para "tokenizar" um novo imóvel.
     * @param to A carteira que receberá o NFT (Geralmente o cofre da DAO).
     * @param uri O link (IPFS ou servidor) com os metadados do imóvel (fotos, endereço).
     */
    function mintarImovel(address to, string memory uri) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
        _setTokenURI(tokenId, uri);
        
        return tokenId;
    }
}