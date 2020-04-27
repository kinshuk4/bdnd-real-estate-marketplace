var ERC721MintableComplete = artifacts.require('CustomERC721Token');

contract('TestERC721Mintable', accounts => {

    const account_one = accounts[0];
    const account_two = accounts[1];
    const numTokens = 10;
    describe('match erc721 spec', function () {
        beforeEach(async function () {
            this.contract = await ERC721MintableComplete.new({from: account_one});

            // DONE: mint multiple tokens
            for (var i = 1; i <= numTokens; i++) {
                await this.contract.mint(account_two, i, {from: account_one});
            }
        })

        it('should return total supply', async function () {
            let totalSupply = await this.contract.totalSupply.call({from: account_one});
            assert.equal(totalSupply, numTokens, "Incorrect token supply in contract");
        })

        it('should get token balance', async function () {
            let tokenBalance = await this.contract.balanceOf.call(account_two, {from: account_one});
            let tokenBalanceReversed = await this.contract.balanceOf.call(account_one, {from: account_two});
            assert.equal(tokenBalance, numTokens, "Incorrect token balance");
            assert.equal(tokenBalanceReversed, 0, "Incorrect token balance");
        })

        // token uri should be complete i.e: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1
        it('should return token uri', async function () {
            let tokenId = 2;
            let tokenURI = await this.contract.getTokenURI.call(tokenId, {from: account_one});
            assert.equal(tokenURI, `https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/${tokenId}`, "Token URI is incorrect for given token id");
        })

        it('should transfer token from one owner to another', async function () {
            let tokenId = 1;
            let fromAccount = account_two;
            let toAccount = account_one;

            await this.contract.safeTransferFrom(fromAccount, toAccount, 1, {from: fromAccount});

            let newOwner = await this.contract.ownerOf.call(tokenId, {from: account_one});
            assert.equal(toAccount, newOwner, "Token transfer failed");

        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () {
            this.contract = await ERC721MintableComplete.new({from: account_one});
        })

        it('should fail when minting when address is not contract owner', async function () {

            let hasFailed = false;
            try {
                await this.contract.mint(account_two, 11, {from: account_two});
            } catch (e) {
                hasFailed = true;
            }
            assert.equal(hasFailed, true, "Minting is not restricted to contract owner");
        })

        it('should return contract owner', async function () {
            let owner = await this.contract.getOwner.call({from: account_one});
            assert.equal(owner, account_one, "Owner is account_one");
        })

    });
})