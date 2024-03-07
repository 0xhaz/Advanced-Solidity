// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract Deploy1 {
    uint256 value1;

    constructor() {
        value1 = 17;
    }

    function read() public view returns (uint256 result) {
        return value1;
    }

    function add() public pure returns (uint256) {
        assembly {
            let x := mload(0x80)
            let freeMemPointer := add(x, 0x20)
            let result := add(0x07, 0x08)
            mstore(freeMemPointer, result)
            return(freeMemPointer, 0x20)
        }
    }
}
