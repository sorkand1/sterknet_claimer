# StarkNet Auto Claim Script

This script automates claiming rewards and transferring tokens on StarkNet mainnet.

## Script Overview

The `starknet.sh` script performs the following operations:

1. **Setup Environment**
   - Updates StarkNet Foundry configuration
   - Installs/updates required dependencies
   - Sets up proper PATH variables

2. **Execute Transactions**
   - Claims rewards using `staker` account
   - Waits 60 seconds for transaction confirmation
   - Transfers tokens using `rewards` account
   - Returns configuration to `staker` account

## Prerequisites

- Linux/Unix system
- Bash shell
- StarkNet Foundry configuration file at `$HOME/.config/starknet-foundry/snfoundry.toml`
- Pre-configured accounts: `staker` and `rewards`

## Installation

1. **Make the script executable:**
   ```bash
   chmod +x starknet.sh
