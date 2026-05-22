const { ethers } = require("ethers");

/**
 * Validates that the AI node's committed hash matches the revealed output.
 */
function validateAIResult(revealedText, committedHash) {
    const computedHash = ethers.keccak256(ethers.toUtf8Bytes(revealedText));
    return computedHash === committedHash;
}

module.exports = { validateAIResult };
