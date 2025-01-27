// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IBytesCoder} from "./IBytesCoder.sol";
import {Prefix0} from "./Prefix0.sol";

contract Base58 is IBytesCoder {
    bytes public alphabet;
    bool public immutable sorted;

    constructor(bytes memory alphabet_, bool sorted_) {
        alphabet = alphabet_;
        sorted = sorted_;
    }

    function decode(bytes memory v) external view returns (bytes memory) {
        return Prefix0.decode(v, alphabet, sorted);
    }

    function encode(bytes memory v) external view returns (bytes memory) {
        return Prefix0.encode(v, alphabet);
    }
}
