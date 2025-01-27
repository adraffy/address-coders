// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Base58} from "../contracts/Base58.sol";
import {Prefix0} from "../contracts/Prefix0.sol";
import {Test} from "forge-std/Test.sol";

contract TestPrefix0 is Test {
    Base58 btc;

    function setUp() public {
        btc = new Base58("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz", true);
    }

    function test_base58btc() public view {
        assertEq(btc.encode("Hello World!"), "2NEpo7TZRRrLZSi2U");
        assertEq(btc.decode("2NEpo7TZRRrLZSi2U"), "Hello World!");
    }

    function testFuzz_base58btc(bytes memory v) public view {
        assertEq(btc.decode(btc.encode(v)), v);
    }

    /*
    function test_indexOf_sorted() public pure {
        bytes memory a = "abcdfg";
        assertEq(Prefix0.indexOf(uint8(bytes1("a")), a, true), 0);
        assertEq(Prefix0.indexOf(uint8(bytes1("b")), a, true), 1);
        assertEq(Prefix0.indexOf(uint8(bytes1("c")), a, true), 2);
        assertEq(Prefix0.indexOf(uint8(bytes1("d")), a, true), 3);
        assertEq(Prefix0.indexOf(uint8(bytes1("f")), a, true), 4);
        assertEq(Prefix0.indexOf(uint8(bytes1("g")), a, true), 5);
        assertEq(Prefix0.indexOf(uint8(bytes1("e")), a, true), a.length);
    }

    function test_indexOf_unsorted() public pure {
        bytes memory a = "zma";
        assertEq(Prefix0.indexOf(uint8(bytes1("z")), a, false), 0);
        assertEq(Prefix0.indexOf(uint8(bytes1("m")), a, false), 1);
        assertEq(Prefix0.indexOf(uint8(bytes1("a")), a, false), 2);
        assertEq(Prefix0.indexOf(uint8(bytes1("b")), a, false), a.length);
        assertEq(Prefix0.indexOf(uint8(bytes1("q")), a, false), a.length);
    }
    */
}
