// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract MergeSortedArray {
    
     function mergeSorted(uint256[] memory a, uint256[] memory b) public pure returns (uint256[] memory) {
        uint256 totalLength = a.length + b.length;
        uint256[] memory result = new uint256[](totalLength);

        uint256 i = 0;
        uint256 j = 0;
        uint256 k = 0;

        while (i < a.length && j < b.length) {
            if (a[i] <= b[j]) {
                result[k++] = a[i++];
            } else {
                result[k++] = b[j++];
            }
        }

        // 处理剩余元素
        while (i < a.length) {
            result[k++] = a[i++];
        }
        while (j < b.length) {
            result[k++] = b[j++];
        }

        return result;
    }

}