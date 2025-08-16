// SPDX-License-Identifier: MIT
pragma solidity ~0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is IERC20  {

    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    uint256 private _totalSupply;

    address public owner; // 合约所有者

    mapping(address => uint256) private _balances; // 余额映射
    mapping(address => mapping(address => uint256)) private _allowances; // 授权额度映射

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // 查询总供应量
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    // 查询余额
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    // 转账
    function transfer(address to, uint256 amount) public override returns (bool) {
        require(to != address(0), "Transfer to zero address");
        require(_balances[msg.sender] >= amount, "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    // 授权
    function approve(address spender, uint256 amount) public override returns (bool) {
        require(spender != address(0), "Approve to zero address");

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // 查询授权额度
    function allowance(address _owner, address spender) public view override returns (uint256) {
        return _allowances[_owner][spender];
    }

    // 授权转账（代扣）
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(to != address(0), "Transfer to zero address");
        require(_balances[from] >= amount, "Insufficient balance");
        require(_allowances[from][msg.sender] >= amount, "Allowance exceeded");

        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }

    // 增发代币（仅合约所有者）
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Mint to zero address");

        _totalSupply += amount;
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }
}