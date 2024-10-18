
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "../libraries/LibDiamond.sol";
import "./ERC721Facet.sol";


contract  MerkleFacet {
    function setMerkleRoot(bytes32 _merkleRoot) external {
     LibDiamond.DiamondStorage storage ls = LibDiamond
            .diamondStorage();
        ls.merkleRoot = _merkleRoot;
    }

function claim(bytes32[] calldata _merkleProof) external {
        LibDiamond.DiamondStorage storage ls = LibDiamond
            .diamondStorage();
        require(!ls.claimed[msg.sender], "Address has already claimed");
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_merkleProof, ls.merkleRoot, leaf), "Invalid merkle proof");

        ls.claimed[msg.sender] = true;
        ERC721Facet(address(this)).safeMint(msg.sender, ls.totalSupply);
        ls.totalSupply++;
    }

    function hasClaimed(address _address) external view returns (bool) {
        LibDiamond.DiamondStorage storage ls = LibDiamond
            .diamondStorage();
        return ls.claimed[_address];
    }

}