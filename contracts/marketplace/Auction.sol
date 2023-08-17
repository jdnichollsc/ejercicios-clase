// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    function placeBid() returns (bool success) {}
    function withdraw() returns (bool success) {}
    function cancelAuction()  returns (bool success) {}

    event LogBid(address bidder, uint bid, address highestBidder, uint highestBid, uint highestBindingBid);
    event LogWithdrawal(address withdrawer, address withdrawalAccount, uint amount);
    event LogCanceled();
}