// SPDX-License-Identifier: MIT

pragma solidity 0.8.27;

import {ETHtoUSDConverter} from "./ETHtoUSDConverter.sol";

error NotTheOwner();
contract Fundraising {
    using ETHtoUSDConverter for uint256;

    uint256 public constant MINIMUM_AMOUNT_SENT = 10e18;

    address [] public listOfSenders;
    mapping (address sender => uint256 amountSent) public amountSentByAddress;

    address public immutable I_OWNER;

    constructor ()  {
        I_OWNER = msg.sender;
    }


    function sendMoney() public payable {
        require(msg.value.convertEthToUsd() >= MINIMUM_AMOUNT_SENT, "Did not send enough money");
        listOfSenders.push(msg.sender);
        amountSentByAddress[msg.sender] = amountSentByAddress[msg.sender] + msg.value;
    }

    function withdraw() public onlyTheOwnerCanExecute{

        for (uint256 senderIndex = 0; senderIndex < listOfSenders.length; senderIndex++) {
            address sender = listOfSenders[senderIndex];
            amountSentByAddress[sender] = 0;
        }

        listOfSenders = new address[](0);

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    // modifier onlyTheOwnerCanExecute() {
        // require(msg.sender == I_OWNER, "Only the owner of the contract can withdraw");
        // _;
    // }

    modifier onlyTheOwnerCanExecute() {
        if(msg.sender != I_OWNER) {revert NotTheOwner();}
        _;
    }

    receive() external payable {
        sendMoney();
    }

    fallback() external payable {
        sendMoney();
    }

}