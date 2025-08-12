// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

contract Voting {

    mapping(address => mapping(uint => uint)) internal points;
    uint public currentRound;

    function vote(address user, uint _point) public  {
        points[user][currentRound] += _point;
    }

    function getVotes(address user) public view returns (uint point){

        return points[user][currentRound];
    }

    function resetVotes() public {
        currentRound += 1; // 逻辑上所有数据重置
    }


}
