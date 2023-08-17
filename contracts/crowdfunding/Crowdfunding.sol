// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./structs/Campaign.sol";
import "./interfaces/IERC20.sol";
import "./CampaignOwner.sol";
import "./CampaignLog.sol";

/**
 * @title Crowdfunding Contract
 * @author @jdnichollsc
 * @notice 
 */
contract CrowdFund is CampaignOwner, CampaignLog {
    IERC20 public immutable token;
    // Total count of campaigns created.
    // It is also used to generate id for new campaigns.
    uint public count;
    // Mapping from id to Campaign
    mapping(uint => Campaign) public campaigns;
    // Mapping from campaign id => pledger => amount pledged
    mapping(uint => mapping(address => uint)) public pledgedAmount;

    constructor(address _token) {
        token = IERC20(_token);
    }

    modifier onlyActiveCampaign(Campaign storage campaign) {
        require(campaign.endAt > block.timestamp, "ENDED");
        require(campaign.startAt <= block.timestamp, "NOT_STARTED");
        _;
    }

    /**
     * @notice Launch a campaign
     * @dev 
     * 1. check minimal duration
     * 2. check maximal duration
     * 3. validate start timestamp
     * 4. create new campaign
    */
    function launch(uint _goal, uint32 _startAt, uint256 _duration, string memory _metadataUri) external {
        require(_duration > 15 days, "DURATION_TOO_SHORT");
        require(_duration <= 90 days, "DURATION_TOO_LONG");
        require(_startAt >= block.timestamp, "INVALID_START_TIMESTAMP");

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _startAt + _duration,
            claimed: false,
            metadataUri: _metadataUri
        });
        
    }

    /**
     * @notice Cancel a campaign
     * @dev 
     * 1. check that only creator is caller
     * 2. check that campaign has not started
     * 3. delete campaign
    */
    function cancel(uint _id) external onlyOwnerCanCancel(campaigns[_id]) {
        delete campaigns[_id];
    }

    /**
     * @notice Pledge an amount for a campaign
     * @dev 
     * 1. check that campaign is active
     * 2. update caller pledged amount
     * 3. update total pledged amount
     * 4. transfer tokens from caller to this contract
    */
    function pledge(uint _id, uint _amount) external onlyActiveCampaign(campaigns[_id]) {
        Campaign storage campaign = campaigns[_id];

        token.transferFrom(msg.sender, address(this), _amount);
        pledgedAmount[_id][msg.sender] += _amount;
        campaign.pledged += _amount;
    }

    /**
     * @notice Unpledge an amount from a campaign
     * @dev 
     * 1. check that campaign is active
     * 2. update caller pledged amount
     * 3. update total pledged amount
     * 4. transfer tokens from this contract to caller
    */
    function unpledge(uint _id, uint _amount) external onlyActiveCampaign(campaigns[_id]) {
        Campaign storage campaign = campaigns[_id];
        require(pledgedAmount[_id][msg.sender] >= _amount);

        token.transfer(msg.sender, _amount);
        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
    }

    /**
     * @notice Claim a campaign
     * @dev 
     * 1. check that the creator of the campaign is caller
     * 2. check that the campaign has ended
     * 3. check that the funding was succesful
     * 4. check that funds were not claimed already
     * 5. transfer tokens from contract to caller
    */
    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "NOT_OWNER");
        require(campaign.endAt < block.timestamp, "NOT_ENDED");
        require(campaign.pledged >= campaign.goal, "NOT_FUNDED");
        require(campaign.claimed == false, "ALREADY_CLAIMED");

        token.transfer(msg.sender, campaign.pledged);
        campaign.claimed = true;
    }

    /**
     * @notice Refund a campaign
     * @dev 
     * 1. check that the campaign has ended
     * 2. checked that the funding was not succesful
     * 3. update caller pledged amount
     * 4. update total pledged amount
     * 5. transfer tokens from contract to caller
    */
    function refund(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(campaign.endAt < block.timestamp, "NOT_ENDED");
        require(campaign.pledged < campaign.goal, "FUNDED");
        require(pledgedAmount[_id][msg.sender] > 0, "NO_BALANCE");

        token.transfer(msg.sender, pledgedAmount[_id][msg.sender]);
        pledgedAmount[_id][msg.sender] = 0;
    }
}