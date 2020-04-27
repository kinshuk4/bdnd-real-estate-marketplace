install:
	npm i -g truffle@nodeLTS
	npm install

compile:
	cd eth-contracts && \
	truffle compile

clean:
	cd eth-contracts && \
	truffle networks --clean && \
	rm -rf ./build

reset: clean
	cd eth-contracts && \
	truffle migrate --reset

migrate:
	cd eth-contracts && \
	truffle migrate --network development

migrate-rinkeby:
	cd eth-contracts && \
	truffle migrate --network rinkeby

migrate-ropsten:
	cd eth-contracts && \
	truffle migrate --network ropsten

migrate-live:
	cd eth-contracts && \
	truffle migrate --network live

gcli:
	ganache-cli

test:
	cd eth-contracts && \
	truffle test --network development

console:
	cd eth-contracts && \
	truffle console --network development