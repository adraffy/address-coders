// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error InvalidCoding();

interface IBytesCoder {
    function encode(bytes memory decoded) external view returns (bytes memory);
    function decode(bytes memory encoded) external view returns (bytes memory);
}
