# Machine Spirit Registry

A small on-chain archive dedicated to the Adeptus Mechanicus.  
Anyone can register a sacred artifact, describe its machine spirit, and record its current condition.  
The community then votes: **awakened** or **dormant**.

This project is fully text-based, permissionless, and built for creative Warhammer 40K world-building on Base.  
No tokens, no payments, no owner — just pure lore written directly to the chain.

---

## Contract

Deployed on Base:  
`0x1f388d094edd78480d32bbc113a79d20d0459385`

Link: https://basescan.org/address/0x1f388d094edd78480d32bbc113a79d20d0459385#code

Main file: `contracts/MachineSpiritRegistry.sol`

---

## How it works

Each artifact includes:

- `artifactName` – Name of the sacred machine  
- `forgeWorld` – Origin forge world  
- `machineSpirit` – How its spirit behaves  
- `condition` – Current state or blessing  
- `litany` – Short prayer or invocation  
- `creator` – Address that registered it  
- `awakenedVotes` / `dormantVotes` – Community judgment  

Entry **0** is a built-in example showing how to fill the fields.

---

## Example: Registering an artifact

```solidity
registerArtifact(
  "Ember Coil",
  "Mars",
  "Flickers with unstable heat.",
  "Slightly scorched.",
  "Spirits of flame, awaken."

## Example: Registering an artifact
This registry is meant to feel like a tiny Mechanicus archive living on-chain:
simple, open, and shaped entirely by the community.
