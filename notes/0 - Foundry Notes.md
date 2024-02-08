# Create New Project

- forge --init

---

# Format Code

- forget fmt

---

# Compile Contract

- Compile Contract: forge create SimpleStorage.sol --interactive

- Compile Contract Specifying the Environment and the Private Key: forge create SimpleStorage --rpc-url http://127.0.0.1:8545 --private-key <private_key>

---

# Deploy Contract

- Deploy Contract on a Local and Temporary Environment: forge script script/Script.s.sol

- Deploy Contract on a Local Environment as a Simulation (without deploying into the blockchain itself): forge script script/Script.s.sol --rpc-url http://127.0.0.1:8545

- Deploy Contract on a Local Environment as an Onchain (deploying into the blockchain itself): forge script script/Script.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key <private_key>

- Deploy Contract on a Local Environment as an Onchain (deploying into the blockchain itself) - Using .env file:
	
	source .env
	forge script script/Script.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY

---

# Casting Binary Numbers to Decimal

- Broadcast folder contains all Deployed Transactions
- The folder 'dry-run' contains all transactions deployed as a Simulation (without deploying into the blockchain itself)
- Outside the folder 'dry-run' there are all transactions deployed as an Onchain (into the blockchain itself)

- Into the file 'run-latest.json' are all info about the transactions and the very transactions. The transactions look like this:

```json
"transaction": {
"type": "0x02",
"from": "0x0",
"gas": "0x71b4f",
"value": "0x0",
"data": "0x0",
"nonce": "0x0",
"accessList": []
},
```

- Notice that some values are in binary format. We can convert them to decimal using 'cast'. Let's give it a shot converting the amount of used gas (in Wei) to decimal.

- Casting Binary to Decimal: cast --to-base 0x71b4f dec

---

# Encrypt Private Key

- cast wallet import your-account-name --interactive
Enter private key: _______
Enter password: ________

- `your-account-name` keystore was saved successfully. Address: address-corresponding-to-private-key

- forge script <script> --rpc-url <rpc_url> --account <account_name> --sender <address> --broadcast


---

# ABI

- Functions that set Values and States: cast send <wallet_number> "storeMyFavoriteNumber(uint256)" 123 --rpc-url $RPC_URL --private-key $PRIVATE_KEY

- Functions that Return Values: cast call <wallet_number> "retrieveMyFavoriteNumber()"