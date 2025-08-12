// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract BinarySearch {
    // 返回索引，如果没找到返回 arr.length
    function binarySearch(uint256[] memory arr, uint256 target) public pure returns (uint256) {
        uint256 left = 0;
        uint256 right = arr.length;

        while (left < right) {
            uint256 mid = left + (right - left) / 2;

            if (arr[mid] == target) {
                return mid; // 找到
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return arr.length; // 未找到
    }
}