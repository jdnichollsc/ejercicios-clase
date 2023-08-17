// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title List DTO
 * @author @jdnichollsc
 * @notice 
 */
contract AuctionDto {
    address public owner = msg.sender;
    uint price = 0;

    event LogAuction(address sender, uint amount);

    /**
     * @notice Get the price of the 
     * @dev
     * @return
    */
    function getPrice() public pure returns(uint) {
        return price;
    }

    /**
     * @notice
     * @dev
    */
    fallback() external payable {
        emit LogAuction(msg.sender, msg.value);
    }

    function withdraw() public {
        require(msg.sender == owner, "ONLY_OWNER");
        payable(owner).transfer(address(this).balance);
    }
}