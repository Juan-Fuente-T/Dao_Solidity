# DAO

This contract simulates the governance system of a Decentralized Autonomous Organization (DAO).

The "Governance" contract is a basic governance system implemented in Solidity that allows users to create and vote on proposals. Each proposal has a creator, a description, and can be linked to an external contract (payload) that will be executed if the proposal is approved. Users can vote in favor, against, or abstain on each proposal.

## Features

- Create proposals with a description and a reference to the contract (payload) that will execute if the proposal is approved.
- Vote on existing proposals.
- Execute proposals that have received enough positive votes.

## Usage

### Create a Proposal

To create a proposal, use the `createProposal` function, providing a description and the address of the payload contract (if necessary). For example:

```
function createProposal(string calldata description, address payload) public;
Vote on a Proposal
To vote on an existing proposal, use the voteProposal function by providing the proposal's ID and your vote (0 for yes, 1 for no, 2 for blank). For example:

```
function voteProposal(uint256 id, uint256 vote) public;
Execute a Proposal
If a proposal has received enough positive votes, it can be executed using the executeProposal function. This will execute the payload contract associated with the proposal. For example:


function executeProposal(uint256 id) public;
Contribution
Contributions are welcome. If you wish to contribute to this contract or report issues, you can do so through pull requests or issue reports in this repository.

### License
This contract is distributed under the GNU General Public License (GPL-3.0).






