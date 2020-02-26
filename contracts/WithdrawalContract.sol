pragma solidity ^0.5.0;

contract WithdrawalContract {
    mapping (address => uint) pendingWithdrawals;
    mapping (uint => uint) gameDeposits;

    function deposit(uint _id, uint _amount) public {
        gameDeposits[_id] += _amount;
    }

    function transferFromDeposit(uint _id, address _addr, uint _amount) internal {
        require(gameDeposits[_id] >= _amount);

        gameDeposits[_id] -= _amount;
        pendingWithdrawals[_addr] += _amount;
    }

    function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        // Remember to zero the pending refund before
        // sending to prevent re-entrancy attacks
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}
