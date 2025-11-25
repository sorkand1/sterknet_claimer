#!/bin/bash

set -e  # Stop script on first error

echo "=== Updating Starknet Foundry Configuration ==="

# Change account to "staker"
sed -i 's/account = ".*"/account = "staker"/' $HOME/.config/starknet-foundry/snfoundry.toml
echo "✓ Account changed to 'staker'"

# Add PATH for starknet-foundry
echo 'export PATH="$HOME/.local/share/starknet-foundry-install/0.50.0/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.local/share/starknet-foundry-install/0.50.0/bin:$PATH"
echo "✓ PATH updated for version 0.50.0"

# Download and install starknet-foundry
echo "=== Installing Starknet Foundry ==="
curl -L https://raw.githubusercontent.com/foundry-rs/starknet-foundry/master/scripts/install.sh -o install.sh
bash install.sh

# Add .local/bin to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"
echo "✓ PATH updated for .local/bin"

# Update bashrc
source ~/.bashrc
echo "✓ .bashrc updated"

# Update snfoundry
echo "=== Updating snfoundry ==="
snfoundryup

echo "=== Executing Transactions ==="

# First transaction - claim_rewards
echo "1. Calling claim_rewards..."
sncast invoke \
  --network mainnet \
  --contract-address 0x00ca1702e64c81d9a07b86bd2c540188d92a2c73cf5cc0e508d949015e7e84a7 \
  --function claim_rewards \
  --arguments <staker_address>

echo "✓ claim_rewards transaction successful"

# 1-minute pause after claim
echo "⏳ Waiting 60 seconds before next transaction..."
for i in {60..1}; do
    echo -ne "⏰ Time remaining: ${i} seconds\r"
    sleep 1
done
echo -e "\n✓ Pause completed, continuing..."

# Change account to "rewards"
sed -i 's/account = ".*"/account = "rewards"/' $HOME/.config/starknet-foundry/snfoundry.toml
echo "✓ Account changed to 'rewards'"

# Second transaction - transfer
echo "2. Calling transfer..."
sncast invoke \
  --network mainnet \
  --contract-address 0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d \
  --function transfer \
  --calldata "sender_address 100000000000000000000 0"

echo "✓ transfer transaction successful"

# Return account to "staker"
sed -i 's/account = ".*"/account = "staker"/' $HOME/.config/starknet-foundry/snfoundry.toml
echo "✓ Account returned to 'staker'"

echo "=== All operations completed successfully! ==="
