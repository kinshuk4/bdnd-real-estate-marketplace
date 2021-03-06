// define a variable to import the <Verifier> or <renamedVerifier> solidity contract generated by Zokrates

var Verifier = artifacts.require('Verifier');
// - use the contents from proof.json generated from zokrates steps
var verifierProof = require('../../zokrates/code/square/proof.json');

contract('TestSquareVerifier', accounts => {
    const account_one = accounts[0];

    describe('test proof verification', function () {
        beforeEach(async function () {
            this.contract = await Verifier.new({from: account_one});
        })

        // Test verification with correct proof
        it('verification with correct proof', async function () {
            let isVerified = await this.contract.verifyTx.call(
                verifierProof.proof.a,
                verifierProof.proof.b,
                verifierProof.proof.c,
                verifierProof.inputs
            );
            assert.equal(isVerified, true, "verification is correct");
        })


        // Test verification with incorrect proof
        it('verification with incorrect proof', async function () {
            verifierProof.inputs = [1, 2];
            let isVerified = await this.contract.verifyTx.call(
                verifierProof.proof.a,
                verifierProof.proof.b,
                verifierProof.proof.c,
                verifierProof.inputs
            );
            assert.equal(isVerified, false, "verification is not correct");
        })
    })


});






