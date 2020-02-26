pragma solidity >= 0.5.0 < 0.7.0;
pragma experimental ABIEncoderV2;

import "./GameDefine.sol";
import "./WithdrawalContract.sol";

contract GameManager is GameDefine, WithdrawalContract {

    Game[] public games;

    constructor() public {
    }

    // ゲーム一覧用, 動作確認時にあると便利だった
    function getGames() public view returns (Game[] memory) {
        return games;
    }

    function createGame() public payable returns (uint){
        uint amount = msg.value;
        uint256 availableRefundTime = block.timestamp + 1 minutes;

        Game memory game = Game(msg.sender, address(0), "", bytes32(""), ActionChoices.Undefined, ActionChoices.Undefined, amount, availableRefundTime, GameStatus.StartGame, GameWinner.Undefined);
        uint id = games.push(game) - 1;

        game.status = GameStatus.WaitingHostSelection;
        games[id] = game;

        deposit(id, amount);

        return id;
    }

    // 入力値が見られないならinputでchoiceとsecret入れてcontractでhash計算して返すでよさそう
    function hostChoice(uint _id, bytes32 _commit) public returns (bool success) {
        Game memory game = games[_id];
        if (game.owner != msg.sender) {
            return false;
        }

        if (game.status != GameStatus.WaitingHostSelection) {
            return false;
        }
        game.commit = _commit;
        game.status = GameStatus.WaitingGuestSelection;

        games[_id] = game;
        return true;
    }

    // guestが後で出すので選択肢を秘匿する必要ないと思ったので生データで渡している
    function guestChoice(uint _id, ActionChoices _choice) public payable returns (bool success) {
        Game memory game = games[_id];

        require(msg.value == game.deposit);

        if (game.status != GameStatus.WaitingGuestSelection) {
            return false;
        }

        game.guestChoice = _choice;
        game.guest = msg.sender;
        game.status = GameStatus.WaitingHostReveal;
        game.availableRefundTime = block.timestamp + 1 minutes;

        games[_id] = game;

        deposit(_id, msg.value);

        return true;
    }

    function decision(uint _id, ActionChoices _choice, string memory _secret, bytes32 _commit) public returns (bool success) {
        Game memory game = games[_id];
        if (game.status != GameStatus.WaitingHostReveal) {
            return false;
        }

        if (game.commit != _commit) {
            return false;
        }

        bytes32 commit = keccak256(abi.encodePacked(actionChoice2str(_choice), _secret));
        if (commit != _commit) {
            return false;
        }

        game.hostChoice = _choice;
        game.secret = _secret;
        game.status = GameStatus.Revealed;

        game.result = judge(game.hostChoice, game.guestChoice);
        game.status = GameStatus.EndGame;

        games[_id] = game;

        _distributeDeposit(_id);

        return true;
    }

    function refund(uint _id) public {
        Game memory game = games[_id];

        require(game.owner == msg.sender || game.guest == msg.sender);

        if (msg.sender == game.owner) {
            _ownerRefund(_id);
            game.result = GameWinner.Owner;
        }
        if (msg.sender == game.guest) {
            _guestRefund(_id);
            game.result = GameWinner.Guest;
        }

        game.status = GameStatus.EndGame;

        games[_id] = game;
    }

    // funcの引数にGameを渡したいが、参照渡しではなさそう？なのでstructを渡すのはコストが大きそう
    // memoryだと問題ない？
    function _ownerRefund(uint _id) private {
        Game memory game = games[_id];

        require(block.timestamp >= game.availableRefundTime);
        require(game.status == GameStatus.WaitingGuestSelection);

        transferFromDeposit(_id, game.owner, gameDeposits[_id]);
    }

    function _guestRefund(uint _id) private {
        Game memory game = games[_id];

        require(block.timestamp >= game.availableRefundTime);
        require(game.status == GameStatus.WaitingHostReveal);

        transferFromDeposit(_id, game.guest, gameDeposits[_id]);
    }

    function _distributeDeposit(uint _id) private {
        Game memory game = games[_id];

        if (game.result == GameWinner.Draw) {
            uint amount = gameDeposits[_id] / 2;
            transferFromDeposit(_id, game.owner, amount);
            transferFromDeposit(_id, game.guest, amount);
        } else if(game.result == GameWinner.Owner) {
            transferFromDeposit(_id, game.owner, gameDeposits[_id]);
        } else {
            transferFromDeposit(_id, game.guest, gameDeposits[_id]);
        }
    }
}
