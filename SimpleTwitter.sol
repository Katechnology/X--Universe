// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./XUniverseToken.sol"; // Assuming the XUniverseToken is in the same directory

contract SimpleTwitter {

    XUniverseToken public token;

    constructor(XUniverseToken _token) {
        token = _token;
    }

    struct Post {
        address author;
        string content;
        uint256 timestamp;
        uint256 upvotes; 
    }
    struct UserProfile {
        string username;
        string description;
        bool isSet;  
    }

    Post[] public posts;
    mapping(address => UserProfile) public userProfiles;
    
    mapping(uint256 => mapping(address => bool)) private hasUpvoted;
    
    // Event to notify clients
    event NewPost(address indexed author, string content, uint256 timestamp);
    event UpvotedPost(uint256 postId, uint256 newUpvoteCount); 

    function postStatus(string memory _content) public {
        require(bytes(_content).length > 0, "Post content cannot be empty");
        
        Post memory newPost = Post({
            author: msg.sender,
            content: _content,
            timestamp: block.timestamp,
            upvotes: 0  
        });
        
        posts.push(newPost);
        emit NewPost(msg.sender, _content, block.timestamp);

        // Reward user with tokens
        token.transfer(msg.sender, 10 * 10 ** 18); // Rewarding 10 tokens as an example
    }
    
    function getPosts() public view returns (Post[] memory) {
        return posts;
    }

    // New function to upvote a post
    function upvotePost(uint256 postId) public {
        require(postId < posts.length, "Post not found");
        require(!hasUpvoted[postId][msg.sender], "You have already upvoted this post");
        
        posts[postId].upvotes += 1;
        hasUpvoted[postId][msg.sender] = true;

        emit UpvotedPost(postId, posts[postId].upvotes); // Emit an event after upvoting
    }

    function setUserProfile(string memory _username, string memory _description) public {
        UserProfile memory newUserProfile = UserProfile({
            username: _username,
            description: _description,
            isSet: true
        });

        userProfiles[msg.sender] = newUserProfile;
    }

    function getUserProfile(address _user) public view returns (UserProfile memory) {
        return userProfiles[_user];
    }

    function getHasUpvoted(uint256 postId, address user) public view returns (bool) {
        require(postId < posts.length, "Post not found");
        return hasUpvoted[postId][user];
    }
}
