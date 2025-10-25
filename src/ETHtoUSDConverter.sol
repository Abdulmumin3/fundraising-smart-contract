// SPDX-License-Identifier: MIT

pragma solidity 0.8.27;

import {AggregatorV3Interface} from "lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library ETHtoUSDConverter {
    function priceOfOneEthInUsd() public view returns(uint256) {
        // ETH/USD price feed (Sepolia)

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        // forge-lint: disable-next-line(unsafe-typecast)
        return uint256(answer * 1e10);
    }

    function convertEthToUsd(uint256 amountOfEth) public view returns(uint256) {
        uint256 priceOfEth = priceOfOneEthInUsd();
        uint256 ethPriceInUsd = (priceOfEth * amountOfEth) / 1e18;

        return ethPriceInUsd;
    }
}