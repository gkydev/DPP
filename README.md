# Digital Product Passports (DPP)
> SmaCE'23: Digital Product Passports - Use Cases Framework and Technical Architecture Using DLT and Smart Contracts

## 📚 Publication
This project is based on research published in IEEE SmaCE'23. Read the full paper here:
[Digital Product Passports: Use Cases Framework and Technical Architecture Using DLT and Smart Contracts](https://ieeexplore.ieee.org/document/10257215)

## 🎯 Project Overview
A proof-of-concept implementation demonstrating Digital Product Passports using blockchain technology and smart contracts. This project enables secure, transparent tracking of products throughout their lifecycle using blockchain.

## 🏗 Architecture
- **Smart Contract Layer**: Solidity-based contract managing DPP data and access control
- **Gateway Layer**: Python-based REST API for interacting with the blockchain
- **Authentication**: Built-in blockchain-based access control system

## 🔑 Key Features
- **Product Passport Creation**: Generate unique digital identifiers for products
- **History Tracking**: Immutable record of all product modifications
- **Access Control**: Granular control over who can modify product data
- **Product Merging**: Support for combining multiple DPPs
- **Version Control**: Complete history of all product changes
- **RESTful API**: Easy integration with external systems

## 💻 Technical Stack
- **Smart Contract**: Solidity ^0.8.2
- **Backend**: Python with Flask
- **Blockchain**: IOTA (Web3.py)
- **API Framework**: Flask with CORS support

## 🚀 Getting Started

### Prerequisites
- Python 3.x
- EVM based IOTA node (local or remote)
- Web3.py
- Flask

### Installation
```bash
# Install required Python packages
pip install web3 flask flask-cors

# Configure IOTA connection in main_functions.py
node_url = "YOUR_IOTA_NODE_URL"
PRIVATE_KEY = "YOUR_PRIVATE_KEY"
PUBLIC_KEY = "YOUR_PUBLIC_KEY"
```

### Smart Contract Deployment
1. Deploy `contract.sol` to your IOTA network
2. Update contract address in `main_functions.py`
3. Ensure `abi.json` matches your deployed contract

## 📡 API Endpoints

### Create New DPP
```bash
POST /create_dpp
{
    "companyName": "string",
    "productType": "string",
    "productDetail": "string",
    "manucaftureDate": number
}
```

### Update Existing DPP
```bash
POST /update_dpp
{
    "dpp_identifier": "string",
    "companyName": "string",
    "productType": "string",
    "productDetail": "string",
    "manucaftureDate": number
}
```

### Get DPP History
```bash
POST /get_dpp_history
{
    "id": "string"
}
```

## 🔐 Smart Contract Features
- **Authentication System**: Built-in access control
- **Data Structure**: Comprehensive DPP_DATA struct
- **History Management**: Complete modification tracking
- **Merging Capability**: Support for combining DPPs

## 🤝 Contributing
This project is part of SmaCE'23 research on Digital Product Passports. Contributions aligned with the research goals are welcome.

## 📄 License
GPL-3.0
