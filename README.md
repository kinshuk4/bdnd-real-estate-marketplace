# bdnd-real-estate-marketplace

The capstone will build upon the knowledge you have gained in the course in order to build a decentralized housing product. 


## Using Zokrates
Succinct Zero-Knowledge proofs (zkSnarks) are proving to be one of the most promising frameworks for enhancing privacy and scalability in the blockchain space.

Projects like Zcash are using zkSnarks to make payments anonymous (rather than pseudonymous). Other projects such as Coda are experimenting with trustless light clients by using recursive zkSnarks to dramatically reduce the number of state verifications blockchain clients have to perform when coming online. Ethereum founder, Vitalik Buterin wrote how zkSnarks can be used to scale transaction speed on Ethereum

We implement zkSnarks using ZoKrates, a toolbox for zkSNARKs on Ethereum. Traditionally, snarks are written using NP complete arithmetic circuits which can be compared to writing assembly code in traditional machine programming. ZoKrates provides a higher level programming language (something like C in the same metaphor) which compiles down to the underlying constraint system and thus allows programmers to write snarks much closer to how they are used to programming.

### Installation
1. Install docker and run docker daemon.
2. Run zokrates
    ```bash
    docker run -v <path to your project folder>:/home/zokrates/code -ti zokrates/zokrates /bin/bash
    ```
    If you are in terminal in the project, just use "$(pwd)" for project path.
    ```bash
    docker run -v $(pwd)/zokrates/code:/home/zokrates/code -ti zokrates/zokrates /bin/bash
    ```
    
    Here is what command does:
    - `docker run` - Run a docker container
    - `-v <path to your project folder>:/home/zokrates/code` - Create a host mapped volume inside the container
    - `-it` - Connect the container to terminal
    - `zokrates/zokrate`s - Pull the docker image from here: https://hub.docker.com/r/zokrates/zokrates
    - `/bin/bash` - Run /bin/bash in the container

3. List the directories and see if "code" exists and `cd code/square`
4. Update the [square.code](./zokrates/code/square/square.code).
5. Run `~/zokrates compile -i square.code`
6. Run `~/zokrates setup`
7. Run `~/zokrates compute-witness -a 3 9`
8. Run `~/zokrates generate-proof`- generates proof.json.
9. Run `~/zokrates export-verifier`



```bash
docker run -v ${project_path}:/home/zokrates/code -ti zokrates/zokrates /bin/bash
```
# Project Resources

* [Remix - Solidity IDE](https://remix.ethereum.org/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [Truffle Framework](https://truffleframework.com/)
* [Ganache - One Click Blockchain](https://truffleframework.com/ganache)
* [Open Zeppelin ](https://openzeppelin.org/)
* [Interactive zero knowledge 3-colorability demonstration](http://web.mit.edu/~ezyang/Public/graph/svg.html)
* [Docker](https://docs.docker.com/install/)
* [ZoKrates](https://github.com/Zokrates/ZoKrates)
