// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChecksumAddress} from "../contracts/ChecksumAddress.sol";
import {Test} from "forge-std/Test.sol";

contract TestPrefix0 is Test {
    function test() public pure {
        assertEq(
            ChecksumAddress.format(0x51050ec063d393217B436747617aD1C2285Aeeee),
            "0x51050ec063d393217B436747617aD1C2285Aeeee"
        );
		assertEq(
            ChecksumAddress.format(0xC973b97c1F8f9E3b150E2C12d4856A24b3d563cb),
            "0xC973b97c1F8f9E3b150E2C12d4856A24b3d563cb"
        );
		assertEq(
            ChecksumAddress.format(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e),
            "0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e"
        );
    }
}
