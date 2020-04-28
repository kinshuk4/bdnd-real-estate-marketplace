var solnSquareContract = artifacts.require('SolnSquareVerifier');
var verifierContract = artifacts.require("Verifier");
var verifierProof = require('../../zokrates/code/square/proof.json');

contract('TestSquareSolnVerifier', accounts => {
    const account_one = accounts[0];
    const account_two = accounts[1];

    // Test if a new solution can be added for contract - SolnSquareVerifier
    describe('solution add spec', function () {
        beforeEach(async function () {
            const verifier = await verifierContract.new({from: account_one});
            this.contract = await solnSquareContract.new(verifier.address, {from: account_one});
        })

        it('should add new solution', async function () {
            let result = await this.contract.addSolution(verifierProof.proof.a, verifierProof.proof.b,
                verifierProof.proof.c, verifierProof.inputs, {from: account_two});
            const solutionAddedEvent = result.logs.find((log) => log.event === 'SolutionAdded')
            assert.isNotNull(solutionAddedEvent, "SolutionAdded not emitted")
            assert.equal(solutionAddedEvent.args.tokenOwner, account_two, "Solution token owners is not sender")
        });

        it('should not allow addition of same token', async function () {
            await this.contract.addSolution(verifierProof.proof.a, verifierProof.proof.b,
                verifierProof.proof.c, verifierProof.inputs, {from: account_two});


            let secondResult = this.contract.addSolution(verifierProof.proof.a, verifierProof.proof.b,
                verifierProof.proof.c, verifierProof.inputs, {from: account_two});
            secondResult.catch(
                e => {
                    assert.equal(e.reason, 'Solution already exists')
                }
            )
        });
    });

    // Test if an ERC721 token can be minted for contract - SolnSquareVerifier
    describe('solution mint spec', function () {
        beforeEach(async function () {
            const verifier = await verifierContract.new({from: account_one});
            this.contract = await solnSquareContract.new(verifier.address, {from: account_one});
        })

        it('should mint erc721 tokens', async function () {
            await this.contract.addSolution(verifierProof.proof.a,verifierProof.proof.b,
                verifierProof.proof.c,verifierProof.inputs,{from:account_one});

            let balance = await this.contract.balanceOf(account_one);
            assert.equal(parseInt(balance), 0, "Incorrect token balance");

            await this.contract.mintNewTokens(verifierProof.proof.a,verifierProof.proof.b,
                verifierProof.proof.c,verifierProof.inputs,{from:account_one});

            balance = await this.contract.balanceOf(account_one);
            assert.equal(parseInt(balance), 1, "Incorrect token balance");

            let uri = await this.contract.getTokenURI(1,{from:account_one});
            assert.equal(uri, "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1"," Incorrect uri");
        });
    });


});
