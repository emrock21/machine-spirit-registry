// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

/// @title Machine Spirit Registry
/// @notice Register sacred Mechanicus artifacts and vote if their machine spirit is awakened or dormant.
/// @dev Pure text-only contract. No funds, no owner, no external calls.

contract MachineSpiritRegistry {

    uint256 public constant MAX_TEXT_SIZE = 1000;

    struct Artifact {
        string artifactName;     // Name of the sacred artifact
        string forgeWorld;       // Origin forge world
        string machineSpirit;    // Description of the machine spirit
        string condition;        // Current condition or blessing status
        string litany;           // Short litany or prayer
        address creator;         // Who registered it
        uint256 createdAt;       // Timestamp
        uint256 awakenedVotes;   // Votes marking it as awakened
        uint256 dormantVotes;    // Votes marking it as dormant
    }

    Artifact[] public artifacts;

    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(uint256 => mapping(address => bool)) public voteIsAwakened;

    event ArtifactRegistered(
        uint256 indexed artifactId,
        string artifactName,
        string forgeWorld,
        address indexed creator
    );

    event ArtifactVoted(
        uint256 indexed artifactId,
        address indexed voter,
        bool awakened,
        uint256 newAwakenedVotes,
        uint256 newDormantVotes
    );

    /// @notice Constructor creates artifact 0 as a clear example.
    constructor() {
        artifacts.push(
            Artifact({
                artifactName: "Example Artifact (Fill your own below)",
                forgeWorld: "Example Forge World",
                machineSpirit: "Describe the machine spirit.",
                condition: "State its current condition.",
                litany: "Short prayer or blessing.",
                creator: address(0),
                createdAt: block.timestamp,
                awakenedVotes: 0,
                dormantVotes: 0
            })
        );
    }

    /// @notice Register a new sacred artifact.
    function registerArtifact(
        string calldata artifactName,
        string calldata forgeWorld,
        string calldata machineSpirit,
        string calldata condition,
        string calldata litany
    ) external {
        require(bytes(artifactName).length > 0, "Artifact name required");
        require(bytes(artifactName).length <= MAX_TEXT_SIZE, "Artifact name too large");
        require(bytes(forgeWorld).length <= MAX_TEXT_SIZE, "Forge world too large");
        require(bytes(machineSpirit).length <= MAX_TEXT_SIZE, "Spirit too large");
        require(bytes(condition).length <= MAX_TEXT_SIZE, "Condition too large");
        require(bytes(litany).length <= MAX_TEXT_SIZE, "Litany too large");

        artifacts.push(
            Artifact({
                artifactName: artifactName,
                forgeWorld: forgeWorld,
                machineSpirit: machineSpirit,
                condition: condition,
                litany: litany,
                creator: msg.sender,
                createdAt: block.timestamp,
                awakenedVotes: 0,
                dormantVotes: 0
            })
        );

        uint256 id = artifacts.length - 1;

        emit ArtifactRegistered(
            id,
            artifacts[id].artifactName,
            artifacts[id].forgeWorld,
            artifacts[id].creator
        );
    }

    /// @notice Vote if the machine spirit is awakened (true) or dormant (false).
    function voteArtifact(uint256 artifactId, bool awakened) external {
        require(artifactId < artifacts.length, "Invalid artifact");
        require(!hasVoted[artifactId][msg.sender], "Already voted");

        hasVoted[artifactId][msg.sender] = true;
        voteIsAwakened[artifactId][msg.sender] = awakened;

        Artifact storage a = artifacts[artifactId];

        if (awakened) {
            a.awakenedVotes += 1;
        } else {
            a.dormantVotes += 1;
        }

        emit ArtifactVoted(
            artifactId,
            msg.sender,
            awakened,
            a.awakenedVotes,
            a.dormantVotes
        );
    }

    /// @notice Total number of artifacts (including example at index 0).
    function totalArtifacts() external view returns (uint256) {
        return artifacts.length;
    }
}
