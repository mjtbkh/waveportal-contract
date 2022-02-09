const main = async () => {
	const [deployer] = await hre.ethers.getSigners();
	const accountBalance = await deployer.getBalance();

	console.log("Deploying contracts with account: ", deployer.address);
        console.log("Account balance: ", accountBalance);

	const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
	const waveContract = await waveContractFactory.deploy({ value: hre.ethers.utils.parseEther("0.1") });
	await waveContract.deployed();

    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
	console.log("WavePortal address", waveContract.address);
    console.log("WavePortal balance", hre.ethers.utils.formatEther(contractBalance));

    let waveTx = await waveContract.wave("Initial wave");
    await waveTx.wait();

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract balance:", hre.ethers.utils.formatEther(contractBalance));
}

const runMain = async () => {
	try {
		await main();
		process.exit(0);
	} catch (error) {
		console.log(error);
		process.exit(1);
	}
}

runMain();
