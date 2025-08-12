// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract ReverseStr {

    // Ascii
    function reverseStr(string memory s) public pure returns (string memory){

        bytes memory b = bytes(s);

        uint256 len = b.length;

        for (uint256 i = 0 ; i < len/2; i++){
            bytes1 temp = b[i];

            b[i] = b[len - 1 - i];

            b[len -1 -i] = temp;
        }
        return string(b);

    }

}