// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "./base/ERC721.sol";

contract VoiceFacade is ERC721 {
    function initialize(string memory name, string memory baseURI) external {
        _name = name;
        _symbol = string(abi.encodePacked("VoiStock_", name));
        _baseURI = baseURI;
        // TODO: mint
        // TODO: initialize
    }

    function newVoice() external {
        // TODO: mint
    }
}
