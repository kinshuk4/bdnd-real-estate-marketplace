pragma solidity >=0.4.21 <0.6.0;

import "./ERC721Mintable.sol";
import 'openzeppelin-solidity/contracts/drafts/Counters.sol';

// DONE define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
// Verifier Interface is defined below

// DONE define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is CustomERC721Token {
    Verifier private verifierContract;

    constructor(address verifierAddress)
    public
    {
        verifierContract = Verifier(verifierAddress);
    }

    // DONE define a solutions struct that can hold an index & an address
    struct Solution {
        uint256 tokenId;
        address tokenOwner;
        bool isMinted;
        bool exists;
    }

    // DONE define an array of the above struct
    Counters.Counter private numSolutions;

    // DONE define a mapping to store unique solutions submitted
    mapping(bytes32 => Solution) private solutions;


    // DONE Create an event to emit when a solution is added
    event SolutionAdded(uint256 tokenId, address tokenOwner);


    // DONE Create a function to add the solutions to the array and emit the event
    function addSolution(
        uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[2] memory input
    )
    public
    {
        bytes32 solutionKey = getSolutionKey(a, b, c, input);

        require(!solutions[solutionKey].exists, "Solution already exists");
        require(verifierContract.verifyTx(a,b,c,input), "Solution cannot be verified");

        numSolutions.increment();
        solutions[solutionKey] = Solution({
            tokenId : numSolutions.current(),
            tokenOwner : msg.sender,
            isMinted : false,
            exists : true
            });
        emit SolutionAdded(solutions[solutionKey].tokenId, solutions[solutionKey].tokenOwner);
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

    // DONE Create a function to mint new NFT only after the solution has been verified
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
        require(solutions[solutionKey].exists, "Solution does not exist");
        require(solutions[solutionKey].tokenOwner == msg.sender, "Caller is not solution owner");
        require(!solutions[solutionKey].isMinted, "Solution is already minted");

        super.mint(solutions[solutionKey].tokenOwner, solutions[solutionKey].tokenId);
        solutions[solutionKey].isMinted = true;
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


























