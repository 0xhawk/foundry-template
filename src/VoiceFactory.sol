// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Proxy.sol";

contract VoiceFactory {
    /// @dev Emitted when a new one is created.
    event CreateProxy(Proxy proxy);

    function newVoice(
        string memory metadata,
        bytes memory initializer,
        uint256 soltNonce /** onlyOwner */
    ) external {
        createProxyWithNonce(initializer, soltNonce);
    }

    function createProxyWithNonce(bytes memory initializer, uint256 saltNonce)
        internal
        returns (Proxy proxy)
    {
        proxy = deployProxyWithNonce(initializer, saltNonce);
        if (initializer.length > 0)
            // solhint-disable-next-line no-inline-assembly
            assembly {
                if eq(
                    call(
                        gas(),
                        proxy,
                        0,
                        add(initializer, 0x20),
                        mload(initializer),
                        0,
                        0
                    ),
                    0
                ) {
                    revert(0, 0)
                }
            }
        emit CreateProxy(proxy);
    }

    /// @dev Allows to create new proxy contact using CREATE2 but it doesn't run the initializer.
    ///      This method is only meant as an utility to be called from other methods
    /// @param initializer Payload for message call sent to new proxy contract.
    /// @param saltNonce Nonce that will be used to generate the salt to calculate the address of the new proxy contract.
    function deployProxyWithNonce(
\        bytes memory initializer,
        uint256 saltNonce
    ) internal returns (Proxy proxy) {
        // If the initializer changes the proxy address should change too. Hashing the initializer data is cheaper than just concatinating it
        bytes32 salt = keccak256(
            abi.encodePacked(keccak256(initializer), saltNonce)
        );
        bytes memory deploymentData = abi.encodePacked(
            type(Proxy).creationCode,
            uint256(uint160(accessor))
        );
        // solhint-disable-next-line no-inline-assembly
        assembly {
            proxy := create2(
                0x0,
                add(0x20, deploymentData),
                mload(deploymentData),
                salt
            )
        }
        require(address(proxy) != address(0), "Create2 call failed");
    }
}
