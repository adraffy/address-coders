// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://github.com/adraffy/cid.js/blob/main/src/Prefix0.js

import {InvalidCoding} from "./IBytesCoder.sol";
import {LookupTable} from "./LookupTable.sol";

library Prefix0 {
    function decode(bytes memory v, bytes memory alphabet, bool sorted) internal pure returns (bytes memory ret) {
        unchecked {
            uint256 r = alphabet.length;
            uint256 b = v.length;
            uint256 a = b;
            ret = new bytes(b);
            for (uint256 i; i < b; ++i) {
                uint256 carry = LookupTable.indexOf(uint8(v[i]), alphabet, sorted);
                if (carry == r) revert InvalidCoding();
                for (uint256 j = b; j > a;) {
                    carry += uint8(ret[--j]) * r;
                    ret[j] = bytes1(uint8(carry));
                    carry >>= 8;
                }
                while (carry > 0) {
                    ret[--a] = bytes1(uint8(carry));
                    carry >>= 8;
                }
            }
            for (uint256 i; i < v.length && v[i] == alphabet[0]; ++i) {
                --a;
            }
            assembly {
                ret := add(ret, a)
                mstore(ret, sub(b, a))
            }
        }
    }

    function encode(bytes memory v, bytes memory alphabet) internal pure returns (bytes memory ret) {
        unchecked {
            uint256 r = alphabet.length;
            if (r < 2 || r > 255) revert InvalidCoding();
            uint256 n = v.length;
            uint256 b = n * (r > 8 ? 2 : 8);
            uint256 a = b;
            ret = new bytes(b);
            for (uint256 j; j < n; ++j) {
                uint256 x = uint8(v[j]);
                for (uint256 i = b; i > a;) {
                    x |= uint256(uint8(ret[--i])) << 8;
                    ret[i] = bytes1(uint8(x % r));
                    x /= r;
                }
                while (x > 0) {
                    ret[--a] = bytes1(uint8(x % r));
                    x /= r;
                }
            }
            for (uint256 i; i < n && v[i] == 0; ++i) {
                --a;
            }
            for (uint256 i = a; i < b; i++) {
                ret[i] = alphabet[uint8(ret[i])];
            }
            assembly {
                ret := add(ret, a)
                mstore(ret, sub(b, a))
            }
        }
    }

    /*
    function expansion(uint256 n) internal pure returns (uint256 i) {
        // ceil(8 / log2(n))
        if (n == 2) {
            return 8; // ceil(8 / 1) = 8
        } else if (n <= 4) {
            return 4; // ceil(8 / 2) = 4
        } else if (n <= 8) {
            return 3; // ceil(8 / 3) = 3
        } else if (n <= 255) {
            return 2; // ceil(8 / 7) = 2
        } else {
            return 1;
        }
    }
    */
}
