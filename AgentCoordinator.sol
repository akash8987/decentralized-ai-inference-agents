// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract AgentCoordinator is Ownable, ReentrancyGuard {
    struct InferenceTask {
        address requester;
        string prompt;
        bytes32 outputHash;
        address node;
        uint256 disputeDeadline;
        bool finalized;
    }

    mapping(uint256 => InferenceTask) public tasks;
    uint256 public taskCount;
    uint256 public constant DISPUTE_PERIOD = 3600; // 1 hour

    event TaskCreated(uint256 indexed taskId, string prompt);
    event ResultCommitted(uint256 indexed taskId, address indexed node, bytes32 outputHash);

    constructor() Ownable(msg.sender) {}

    function requestInference(string calldata _prompt) external payable {
        require(msg.value >= 0.01 ether, "Insufficient fee");
        uint256 taskId = taskCount++;
        tasks[taskId].requester = msg.sender;
        tasks[taskId].prompt = _prompt;
        emit TaskCreated(taskId, _prompt);
    }

    function commitResult(uint256 _taskId, bytes32 _outputHash) external {
        InferenceTask storage task = tasks[_taskId];
        require(task.node == address(0), "Already committed");
        
        task.node = msg.sender;
        task.outputHash = _outputHash;
        task.disputeDeadline = block.timestamp + DISPUTE_PERIOD;
        
        emit ResultCommitted(_taskId, msg.sender, _outputHash);
    }

    function finalize(uint256 _taskId) external {
        InferenceTask storage task = tasks[_taskId];
        require(block.timestamp > task.disputeDeadline, "Dispute window open");
        require(!task.finalized, "Already finalized");
        
        task.finalized = true;
        payable(task.node).transfer(address(this).balance); // Simplified payout
    }
}
