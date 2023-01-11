// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract EthersWallet is Ownable {
    constructor (){
        transferOwnership(msg.sender);
    }

    event LogWithdrawAll(address owner, uint256 balance);
    event LogWithdrawTo(address wallet, uint256 amount);

    function withdrawAll() external onlyOwner{
        require(address(this).balance > 0, "no hay saldo");
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit LogWithdrawAll(owner(),balance);
    }

    function withdrawBalance(uint256 _amount) external onlyOwner{
        require(address(this).balance >= _amount, "no hay saldo");
        payable(owner()).transfer(_amount);
        emit LogWithdrawAll(owner(),_amount);
    }

    function withdrawTo(address _wallet,uint256 _amount) external onlyOwner{
        require(address(this).balance >= _amount, "no hay saldo");
        payable(_wallet).transfer(_amount);
        emit LogWithdrawTo(_wallet, _amount);
    }

    receive() external payable {

    }

    function getBalance() external view returns(uint256){
        return address(this).balance;
    }

    function getOwner() external view returns(address){
        return owner();
    }
}