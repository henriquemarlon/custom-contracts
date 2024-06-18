// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2Mock.sol";
import {VRFConsumer} from "@contracts/vrf/local/VRFConsumer.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployVRFConsumer is Script {
    function run() external {
        vm.startBroadcast();
        VRFCoordinatorV2Mock vrf = VRFCoordinatorV2Mock(0xC6Dd0d204fC17e6921C1319Cb5a0B192dB2AC215);
        VRFConsumer vrfconsumer = new VRFConsumer(1, address(vrf), 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc);
        vrf.addConsumer(1, address(vrfconsumer));
        vrfconsumer.requestRandomWords();
        uint256 requestId = vrfconsumer.s_requestId();
        vrf.fulfillRandomWords(requestId, address(vrfconsumer));
        bytes32 result = vrfconsumer.sendRandomness();
        vm.stopBroadcast();
        console.log(
            "VRFConsumer address:",
            address(vrfconsumer),
            "at network:",
            block.chainid
        );
        console.log(
            "RandomWords available:",
            vrfconsumer.s_randomWords(0),
            vrfconsumer.s_randomWords(1)
        );
        console.log("Result of sendRandomness():");
        console.logBytes32(result);
    }
}