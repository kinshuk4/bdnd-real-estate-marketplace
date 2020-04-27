pragma solidity >=0.4.21 <0.6.0;

import "./ERC721Mintable.sol";

// DONE define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
// Verifier Interface is defined below

// DONE define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is CustomERC721Token {

    // DONE define a solutions struct that can hold an index & an address
    struct Solution {
        uint256 tokenId;
        address tokenOwner;
        bool isMinted;
        bool exists;
    }

    // DONE define an array of the above struct
    Solution[] solutions;

    // DONE define a mapping to store unique solutions submitted
    mapping(bytes32 => Solution) private uniqueSolutions;


    // DONE Create an event to emit when a solution is added
    event SolutionAdded(uint256 tokenId, address owner);


    // TODO Create a function to add the solutions to the array and emit the event
    function addSolution(
        uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[2] memory input,
        uint _tokenId, address _tokenOwner
    )
    public
    {
        bytes32 solutionKey = getSolutionKey(a, b, c, input);
        Solution memory solution = Solution({
            tokenId : _tokenId,
            tokenOwner : _tokenOwner,
            isMinted : false,
            exists : true
            });
        solutions.push(solution);

        require(!uniqueSolutions[solutionKey].exists, "Solution already exists");
        uniqueSolutions[solutionKey] = solution;
        emit SolutionAdded(_tokenId, _tokenOwner);
    }

    function getSolutionKey
    (
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input
    )
    internal pure
    returns (bytes32)
    {
        return keccak256(abi.encodePacked(a, b, c, input));
    }
    // TODO Create a function to mint new NFT only after the solution has been verified
    //  - make sure the solution is unique (has not been used before)
    //  - make sure you handle metadata as well as tokenSupply
    function mintNewTokens(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input
    )
    public
    {
        bytes32 solutionKey = getSolutionKey(a, b, c, input);
        require(uniqueSolutions[solutionKey].exists, "Solution does not exist");
        require(uniqueSolutions[solutionKey].tokenOwner == msg.sender, "Caller is not solution owner");
        require(!uniqueSolutions[solutionKey].isMinted, "Solution is already minted");

        super.mint(uniqueSolutions[solutionKey].tokenOwner, uniqueSolutions[solutionKey].tokenId);
        uniqueSolutions[solutionKey].isMinted = true;
    }
}


contract Verifier {
    function verifyTx
    (
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input
    )
    public
    returns (bool);
}


























