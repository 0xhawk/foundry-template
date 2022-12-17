// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "./base/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract VoiceFacade is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    function initialize(string memory name, string memory baseURI) external {
        _name = name;
        _symbol = string(abi.encodePacked("VoiStock_", name));
        _baseURI = baseURI;
        // TODO: initialize
    }

    function newVoice(address minter) external {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _mint(minter, newTokenId);
    }
}
