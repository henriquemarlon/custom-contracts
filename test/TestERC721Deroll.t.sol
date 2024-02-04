//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {ERC721Deroll} from "@contracts/token/ERC721/ERC721Deroll.sol";

contract TestERC721Deroll is Test {
    ERC721Deroll erc721;

    address guest = address(1);
    address application = address(2);

    function setUp() public {
        erc721 = new ERC721Deroll{salt: bytes32(abi.encode(1596))}();
    }

    function testMintERC721Deroll() public {
        vm.prank(application);
        erc721.safeMint(
            guest,
            "QmXqngKXVbY6qEhbTdENaSARNwHSnRFMQhBC5aycNW81S8"
        );
        assertTrue(erc721.balanceOf(guest) == 1);
    }
}
