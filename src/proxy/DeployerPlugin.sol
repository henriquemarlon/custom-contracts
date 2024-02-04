// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DeployerPlugin {
    error DeployFailed(address sender, address asset);
    event DeployContract(address sender, address asset);

    uint256 public deploys;

    receive() external payable {}

    function deployAnyContract(
        bytes memory _bytecode
    ) external payable returns (address addr) {
        assembly {
            // create(v, p, n)
            // v = amount of ETH to send
            // p = pointer in memory to start of _bytecode
            //36 n = size of _bytecode
            addr := create(callvalue(), add(_bytecode, 0x20), mload(_bytecode))
        }
        if (addr == address(0)) revert DeployFailed(msg.sender, addr);
        deploys++;
        emit DeployContract(msg.sender, addr);
        return addr;
    }
}
