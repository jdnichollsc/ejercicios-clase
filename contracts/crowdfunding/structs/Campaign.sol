// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Campaign
 * @author @jdnichollsc
 * @notice 
 */
struct Campaign {
    // Creator of campaign
    address creator;
    // Amount of tokens to raise
    uint goal;
    // Total amount pledged
    uint pledged;
    // Timestamp of start of campaign
    uint256 startAt;
    // Timestamp of end of campaign
    uint256 endAt;
    // True if goal was reached and creator has claimed the tokens.
    bool claimed;
    // Metadata of the campaign
    string metadataUri;
}