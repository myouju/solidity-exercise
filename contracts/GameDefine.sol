pragma solidity >= 0.5.0 < 0.7.0;

contract GameDefine {
    
    enum ActionChoices { Undefined, Rock, Paper, Scissor }
    enum GameStatus { 
        StartGame,
        WaitingHostSelection,
        WaitingGuestSelection,
        WaitingHostReveal,
        Revealed,
        EndGame,
        Withdrawn
    }
    enum GameWinner { Undefined, Owner, Guest, Draw }

    struct Game {
        address owner;
        address guest;
        string secret; // なくてもよさそう、同じcommit hashになるかあとで不正確認用？ bytes32のほうがgas少なくなる？
        bytes32 commit;
        ActionChoices hostChoice;
        ActionChoices guestChoice;
        uint deposit;
        uint256 availableRefundTime;
        GameStatus status;
        GameWinner result;
    }

    function judge(ActionChoices _hostChoice, ActionChoices _guestChoice) internal pure returns (GameWinner winner) {
        if (_hostChoice == ActionChoices.Undefined) {
            return GameWinner.Undefined;
        }
        if (_guestChoice == ActionChoices.Undefined) {
            return GameWinner.Undefined;
        }

        int host = int(_hostChoice);
        int guest = int(_guestChoice);
        int r = host - guest;

        if (r == 0) { 
            return GameWinner.Draw;
        } else if(r == -1 || r == 2) {
            return GameWinner.Owner;
        } else {
            return GameWinner.Guest;
        }
    }

    // コピペ
    // ref. https://ethereum.stackexchange.com/questions/6591/conversion-of-uint-to-string
    function actionChoice2str(ActionChoices _c) internal pure returns (string memory _uintAsString) {
        uint i = uint(_c);
        if (i == 0) {
            return "0";
        }
        uint j = i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (i != 0) {
            bstr[k--] = byte(uint8(48 + i % 10));
            i /= 10;
        }
        return string(bstr);
    }
}
