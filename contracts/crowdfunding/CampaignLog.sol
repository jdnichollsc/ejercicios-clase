// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CampaignLog {
    event LogLaunch(
        uint id,
        address indexed creator,
        uint goal,
        uint32 startAt,
        uint32 endAt
    );


}