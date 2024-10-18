// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../libraries/LibDiamond.sol";
import "./ERC721Facet.sol";

contract PresaleFacet {
    function setPresaleParameters(
        uint256 _price,
        uint256 _minPurchase,
        uint256 _maxPurchase
    ) external {
        LibDiamond.DiamondStorage storage ls = LibDiamond
            .diamondStorage();
        ls.presalePrice = _price;
        ls.minPurchase = _minPurchase;
        ls.maxPurchase = _maxPurchase;
    }

    function buyPresale(uint256 _amount) external payable {
        LibDiamond.DiamondStorage storage ls = LibDiamond
            .diamondStorage();
        require(
            _amount >= ls.minPurchase,
            "Below minimum purchase amount"
        );
        require(
            _amount <= ls.maxPurchase,
            "Exceeds maximum purchase amount"
        );
        require(
            msg.value >= _amount * ls.presalePrice,
            "Insufficient payment"
        );

        for (uint256 i = 0; i < _amount; i++) {
            ERC721Facet(address(this)).safeMint(
                msg.sender,
                ls.totalSupply
            );
            ls.totalSupply++;
        }
    }
}
