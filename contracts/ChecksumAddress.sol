// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ChecksumAddress {
    function format(address addr) internal pure returns (string memory) {
        bytes memory v = new bytes(42);
        v[0] = "0";
        v[1] = "x";
        _formatHex(v, bytes20(addr), 0);
        bytes20 h;
        assembly {
            h := keccak256(add(v, 34), 40)
        }
        _formatHex(v, bytes20(addr), h);
        return string(v);
    }

    function _formatHex(bytes memory v, bytes20 addr, bytes20 hash) internal pure {
        unchecked {
            uint256 pos = 2;
            for (uint256 i; i < 20; i++) {
                uint8 a = uint8(addr[i]);
                uint8 b = uint8(hash[i]);
                v[pos++] = _toHexChar(a >> 4, b & 0x80 != 0);
                v[pos++] = _toHexChar(a & 15, b & 0x08 != 0);
            }
        }
    }

    function _toHexChar(uint8 x, bool upper) private pure returns (bytes1) {
        return bytes1(x < 10 ? x + 48 : x + (upper ? 55 : 87));
    }
}
