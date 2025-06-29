// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract ReviewSystem {
    struct Review {
        string content;
        address reviewer;
        uint256 timestamp;
    }

    mapping(uint256 => Review[]) public reviews;
    uint256 public itemCount;

    event ReviewAdded(uint256 itemId, address reviewer, string content);

    function addItem() public {
        itemCount++;
    }

    function addReview(uint256 itemId, string memory content) public {
        require(itemId <= itemCount, "Item does not exist");
        reviews[itemId].push(Review({
            content: content,
            reviewer: msg.sender,
            timestamp: block.timestamp
        }));
        emit ReviewAdded(itemId, msg.sender, content);
    }

    function getReviews(uint256 itemId) public view returns (Review[] memory) {
        return reviews[itemId];
    }
}