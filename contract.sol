// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract DigitalProductPassport {
    // Maximum uint256 value
    uint256 MAX_INT = 2**256 - 1;

    address _admin;

    constructor() {
        _admin = msg.sender;
    }

    // Struct to represent DPP data
    struct DPP_DATA {
        string companyName;
        string productType;
        string productDetail;
        uint32 manucaftureDate;
        address[] allowedAdresses;
        bool isMerged;
        uint256[] mergedFrom;
    }

    // Dictionary that maps a randNumber to a list of DPP_DATA structs
    mapping (uint256 => DPP_DATA[]) public dppList;

    function checkAuth(uint256 uniqueIdentifier) public view returns (bool) {
        // Check if the msg.sender is an admin
        if (_admin == msg.sender) {
            return true;
        }

        // Check if the msg.sender is in the allowed addresses list for the DPP associated with the uniqueIdentifier
        for (uint256 i = 0; i < dppList[uniqueIdentifier].length; i++) {
            if (dppList[uniqueIdentifier][i].allowedAdresses.length > 0) {
                for (uint256 j = 0; j < dppList[uniqueIdentifier][i].allowedAdresses.length; j++) {
                    if (dppList[uniqueIdentifier][i].allowedAdresses[j] == msg.sender) {
                        return true;
                    }
                }
            }
        }

        // Return false if the msg.sender is not an admin or in the allowed addresses list
        return false;
    }
    // Function to create a uniqueIdentifier value
    function createUniqueIdentifier() internal returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % MAX_INT;
    }

    // Event to be emitted when a DPP is added to the dppList
    event DPPAdded(uint256 uniqueIdentifier);

    // Function to add a new DPP to the dppList
    function addDPP(string memory companyName, string memory productType, string memory productDetail, uint32 manufactureDate) public returns (uint256) {
        // Generate a uniqueIdentifier
        uint256 uniqueIdentifier = createUniqueIdentifier();
        
        // Create a new DPP_DATA struct
        DPP_DATA memory dpp = DPP_DATA({
            companyName: companyName,
            productType: productType,
            productDetail: productDetail,
            manucaftureDate: manufactureDate,
            isMerged: false,
            mergedFrom: new uint256[](0),
            allowedAdresses: new address[](0)
        });

        dpp.allowedAdresses = new address[](1);
        dpp.allowedAdresses[0] = msg.sender;

        // Add the DPP_DATA struct to the list associated with the uniqueIdentifier
        dppList[uniqueIdentifier].push(dpp);

        // Emit an event to indicate that a DPP has been added to the list
        emit DPPAdded(uniqueIdentifier);

        // Return the uniqueIdentifier associated with the new DPP
        return uniqueIdentifier;
    }

    function mergeDPP(string memory companyName, string memory productType, string memory productDetail, uint32 manufactureDate,  uint256[] memory mergerIdentifiers) public returns (uint256) {
        // Generate a uniqueIdentifier
        uint256 uniqueIdentifier = createUniqueIdentifier();
        
        // Create a new DPP_DATA struct
        DPP_DATA memory dpp = DPP_DATA({
            companyName: companyName,
            productType: productType,
            productDetail: productDetail,
            manucaftureDate: manufactureDate,
            isMerged: false,
            mergedFrom: new uint256[](0),
            allowedAdresses: new address[](0)
        });

        dpp.allowedAdresses = new address[](1);
        dpp.allowedAdresses[0] = msg.sender;

        // Add the DPP_DATA struct to the list associated with the uniqueIdentifier
        dppList[uniqueIdentifier].push(dpp);

        // Emit an event to indicate that a DPP has been added to the list
        emit DPPAdded(uniqueIdentifier);

        // Return the uniqueIdentifier associated with the new DPP
        return uniqueIdentifier;
    }

    // Function to update an existing DPP in the dppList
    function updateDPP(uint256 uniqueIdentifier, string memory companyName, string memory productType, string memory productDetail, uint32 manufactureDate) public {

        require(checkAuth(uniqueIdentifier), "auth failed");
        // Get the existing DPP list at the specified uniqueIdentifier
        DPP_DATA[] storage dppListAtIndex = dppList[uniqueIdentifier];

        // Get the last DPP_DATA struct in the list
        DPP_DATA memory lastDPP = dppListAtIndex[dppListAtIndex.length - 1];

        // Create a new DPP_DATA struct with the updated values
        DPP_DATA memory newDPP = DPP_DATA({
            companyName: companyName,
            productType: productType,
            productDetail: productDetail,
            manucaftureDate: manufactureDate,
            allowedAdresses: lastDPP.allowedAdresses,
            isMerged: lastDPP.isMerged,
            mergedFrom: lastDPP.mergedFrom
        });

        // Add the new DPP_DATA struct to the list at the specified uniqueIdentifier
        dppListAtIndex.push(newDPP);
    }


    // Function to get the list of DPP_DATA structs associated with a given uniqueIdentifier
    function getDPPHistory(uint256 uniqueIdentifier) public view returns (DPP_DATA[] memory) {
        return dppList[uniqueIdentifier];
    }
    
    // Function to get the last added DPP_DATA struct associated with a given random number
    function getLastDPP(uint256 uniqueIdentifier) public view returns (DPP_DATA memory) {
        // Get the list of DPP_DATA structs associated with the random number
        DPP_DATA[] memory dppArray = dppList[uniqueIdentifier];

        // Check that the list is not empty
        require(dppArray.length > 0, "No DPP found ");

        // Return the last DPP_DATA struct in the list
        return dppArray[dppArray.length - 1];
    }

    function getFirstDPP(uint256 uniqueIdentifier) public view returns (DPP_DATA memory) {
        // Get the list of DPP_DATA structs associated with the uniqueIdentifier
        DPP_DATA[] memory dppArray = dppList[uniqueIdentifier];

        // Check that the list is not empty
        require(dppArray.length > 0, "No DPP_DATA found");

        // Return the first DPP
        return dppArray[0];
    }
}
