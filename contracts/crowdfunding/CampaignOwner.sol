// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./structs/Campaign.sol";

contract CampaignOwner {
    modifier onlyOwner(Campaign storage campaign) {
        require(campaign.creator == msg.sender, "ONLY_OWNER");
        _;
    }
    modifier onlyOwnerCanCancel(Campaign storage campaign) {
        require(campaign.creator == msg.sender, "NOT_OWNER");
        require(campaign.startAt > block.timestamp, "ALREADY_STARTED");
        _;
    }
}