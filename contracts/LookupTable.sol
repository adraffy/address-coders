// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LookupTable {
    function isSorted(bytes memory v) internal pure returns (bool) {
        for (uint256 i = 1; i < v.length; ++i) {
            if (v[i - 1] >= v[i]) return false;
        }
        return true;
    }

    function indexOf(uint8 x, bytes memory v, bool sorted) internal pure returns (uint256) {
        if (sorted) {
            uint256 a;
            uint256 b = v.length;
            while (a < b) {
                uint256 c = (a + b) >> 1;
                uint256 y = uint8(v[c]);
                if (x == y) {
                    return c;
                } else if (x < y) {
                    b = c;
                } else {
                    a = c + 1;
                }
            }
        } else {
            for (uint256 i; i < v.length; i++) {
                if (uint8(v[i]) == x) {
                    return i;
                }
            }
        }
        return v.length;
    }
}
