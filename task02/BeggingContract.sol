// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

import "@openzeppelin/contracts@4.9.6/access/Ownable.sol";

contract BeggingContract is Ownable {
    // 记录每个捐赠者累计捐赠金额
    mapping(address => uint256) private _donations;

    event Donated(address indexed donor, uint256 amount);
    event Withdrawn(address indexed to, uint256 amount);

    // OZ 4.9.6 的 Ownable 会在构造时把 owner 设为部署者，无需传参
    constructor() {}

    /**
     * @notice 捐赠函数（显式调用）
     * @dev 必须附带 ETH；使用 payable 接收资金并记录
     */
    function donate() external payable {
        require(msg.value > 0, "No ETH sent");
        _donations[msg.sender] += msg.value;
        emit Donated(msg.sender, msg.value);
    }

    /**
     * @notice 直接向合约转账时也计入捐赠
     */
    receive() external payable {
        require(msg.value > 0, "No ETH sent");
        _donations[msg.sender] += msg.value;
        emit Donated(msg.sender, msg.value);
    }

    /**
     * @notice 查询某个地址的累计捐赠金额（单位：wei）
     */
    function getDonation(address donor) external view returns (uint256) {
        return _donations[donor];
    }

    /**
     * @notice 提取合约内全部资金到所有者地址
     * @dev 仅限所有者；按题目要求使用 address.transfer
     */
    function withdraw() external onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "Nothing to withdraw");

        // 注意：Ownable 的 owner() 返回 address，需要转换为 address payable
        payable(owner()).transfer(amount);

        emit Withdrawn(owner(), amount);
    }

    /**
     * @notice （可选）查看合约当前余额
     */
    function contractBalance() external view returns (uint256) {
        return address(this).balance;
    }


}