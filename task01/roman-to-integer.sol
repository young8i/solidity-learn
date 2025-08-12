// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract RomanToInt {
    
    function romanToInt(string memory roman) public pure returns (uint256 i){
        bytes memory b = bytes(roman);
        uint256 total = 0;
        uint256 preValue = 0;

        for (i = b.length; i > 0; i--){

            uint256 value = _valueOf(b[i-1]);

            if(value < preValue){
                total -= value;
            } else {
                total += value;
                
            }
            preValue = value;
        }
        return total;
    }

     function _valueOf(bytes1 c) internal pure returns (uint256) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;
        revert("Invalid Roman numeral");
    }

}