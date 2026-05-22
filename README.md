# Decentralized AI Inference Agents

This repository provides a high-performance implementation for the **AI-Blockchain convergence**, a primary narrative of 2026. It enables decentralized nodes to execute heavy AI models (LLMs, Diffusion) off-chain and commit the results to L1/L2 with cryptographic verifiability.

### 2026 Narrative Alignment
* **Verifiable Inference:** Uses "Optimistic AI" logic—results are accepted immediately but subject to a dispute window where fraud is penalized.
* **ZK-ML (Zero-Knowledge Machine Learning):** Blueprint for verifying that a specific model (e.g., Llama 3.1) was used to generate a specific output.
* **Autonomous Intent Agents:** AI agents that can sign transactions based on on-chain data triggers without human intervention.

### Technical Components
* **AgentCoordinator.sol:** Handles user requests, node staking, and result finalization.
* **ChallengeEngine.sol:** Manages the dispute period and slashing logic for malicious AI nodes.
* **MockInferenceClient.py:** A Python-based node runner demonstrating how to bridge GPU outputs to EVM-compatible commitments.
