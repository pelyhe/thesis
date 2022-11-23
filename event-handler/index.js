const http = require('http');
const Web3 = require('web3');
const environment = require('./config/environment.js');
const insuranceTokenABI = require('./config/insuranceTokenABI.js');
const ethers = require('ethers');
const axios = require('axios');

// declare server variables
const hostname = '127.0.0.1';
const port = 8080;

async function main() {

    const web3 = new Web3(new Web3.providers.WebsocketProvider(environment.WEBSOCKET_PROVIDER));  // has to be websocket (ws) connection
    const CONTRACT_ADDRESS = environment.CONTRACT_ADDRESS;
    const insuranceTokenContract = new web3.eth.Contract(insuranceTokenABI, CONTRACT_ADDRESS);

    const alchemyProvider = new ethers.providers.AlchemyProvider(network = "goerli", environment.API_KEY);
    const gatewayAddress = new ethers.Wallet(environment.PRIVATE_KEY, alchemyProvider);

    const contract = new ethers.Contract(environment.CONTRACT_ADDRESS, insuranceTokenABI, gatewayAddress);

    let options = {
        filter: {
            value: [],
        },
        fromBlock: "latest"
    };


    insuranceTokenContract.events.CompensationPayment(options)
        .on('data', event => {
            const data = {
                address: event.returnValues._address,
                damagePrice: event.returnValues.damagePrice
            }
            console.warn('\x1b[45m%s\x1b[0m', 'CompensationPayment:');
            console.log(data);
            console.log('\n');

            payCompensation(address, damagePrice);
        })

    insuranceTokenContract.events.ConfirmPayment(options)
        .on('data', event => {
            const data = {
                address: event.returnValues._address,
                value: event.returnValues._value
            }
            console.warn('\x1b[45m%s\x1b[0m', 'ConfirmPayment:');
            console.log(data);
            console.log('\n');
        })

    insuranceTokenContract.events.DamageDeclaration(options)
        .on('data', event => {
            const data = {
                //dataType: "DamageDeclaration",
                address: event.returnValues._address,
                reportId: event.returnValues.reportId
            }
            console.warn('\x1b[45m%s\x1b[0m', 'DamageDeclaration:');
            console.log(data);
            console.log('\n');
        })

    insuranceTokenContract.events.ReportApproved(options)
        .on('data', event => {
            const data = {
                //dataType: "DamageDeclaration",
                reportId: event.returnValues.reportId
            }
            console.warn('\x1b[45m%s\x1b[0m', 'ReportApproved:');
            console.log(data);
            console.log('\n');
        })

    insuranceTokenContract.events.ReportConfirmed(options)
        .on('data', event => {
            const data = {
                //dataType: "DamageDeclaration",
                address: event.returnValues.reviewer,
                reportId: event.returnValues.reportId
            }
            console.warn('\x1b[45m%s\x1b[0m', 'ReportConfirmed:');
            console.log(data);
            console.log('\n');
        })

    insuranceTokenContract.events.ReportRefused(options)
        .on('data', event => {
            const data = {
                //dataType: "DamageDeclaration",
                address: event.returnValues.reviewer,
                reportId: event.returnValues.reportId
            }
            console.warn('\x1b[45m%s\x1b[0m', 'ReportRefused:');
            console.log(data);
            console.log('\n');
        })


    insuranceTokenContract.events.MontlyFeePayment(options)
        .on('data', event => {
            const data = {
                //dataType: "MontlyFeePayment",
                address: event.returnValues._address,
                value: event.returnValues._value
            }
            console.log('\x1b[45m%s\x1b[0m', 'MontlyFeePayment:');
            console.log(data);
            console.log('\n');
            
            payMonthlyFee(data.address, data.value);
        })

    insuranceTokenContract.events.SwitchHigherPlan(options)
        .on('data', event => {
            const data = {
                address: event.returnValues._address,
                planNumber: event.returnValues.planNumber,
                feeDifference: event.returnValues.feeDifference
            }
            console.warn('\x1b[45m%s\x1b[0m', 'SwitchHigherPlan:');
            console.log(data);
            console.log('\n');
            
            switchToHigherPlan(data.address, data.planNumber, data.feeDifference);
        })

    insuranceTokenContract.events.SwitchLowerPlan(options)
        .on('data', event => {
            const data = {
                //dataType: "SwitchLowerPlan",
                address: event.returnValues._address,
                utilityTokens: event.returnValues.utilityTokens
            }
            console.warn('\x1b[45m%s\x1b[0m', 'SwitchLowerPlan:');
            console.log(data);
            console.log('\n');
        })

    insuranceTokenContract.events.InsuranceResigned(options)
        .on('data', event => {
            const data = {
                address: event.returnValues._address,
            }
            console.warn('\x1b[45m%s\x1b[0m', 'InsuranceResigned:');
            console.log(data);
            console.log('\n');
        })

    insuranceTokenContract.events.InsuranceRegistration(options)
        .on('data', event => {

            const data = {
                address: event.returnValues._address,
                planNumber: event.returnValues.planNumber
            }
            console.warn('\x1b[45m%s\x1b[0m', 'InsuranceRegistration:');
            console.log(data);
            console.log('\n');
        })

    insuranceTokenContract.events.ClientSuspended(options)
        .on('data', event => {
            const data = {
                address: event.returnValues._address,
            }
            console.warn('\x1b[45m%s\x1b[0m', 'ClientSuspended:');
            console.log(data);
            console.log('\n');
        })


    function payMonthlyFee(address, value) {

        var nonce;
        axios.get('http://vm.niif.cloud.bme.hu:9200/nonce', {
            params: {
                address: environment.addresses[address]
            }
        })
            .then(function (response) {
                nonce = response.data.response;

                var idx;
                if (address == '0x53751f8b8b82DC367C82D00095BAaB7b4dA16F3e') {    // client 1
                    idx = 1;
                } else { // client 2
                    idx = 2;
                }

                const signature = signTransaction(
                    idx,
                    environment.addresses[address],
                    environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC'],
                    value / 100,
                    "default",
                    parseInt(nonce)
                );

                axios.post('http://vm.niif.cloud.bme.hu:9200/transferAsset', {
                    "amount": parseInt(value / 100),
                    "from": environment.addresses[address],
                    "nonce": parseInt(nonce),
                    "pocket": "default",
                    "r": signature.r.toString("base64"),
                    "s": signature.s.toString("base64"),
                    "to": environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC'],
                    "v": signature.v
                })
                    .then(function (response) {
                        console.log(response.data);
                        contract.functions.confirmMonthlyFeePayment(address, parseInt(value), {
                            gasLimit: 100000,
                          });
                    })
                    .catch(function (error) {
                        console.log(error);
                    })
            })
            .catch(function (error) {
                console.log(error);
            })
    }

    function payCompensation(address, value) {

        var nonce;
        axios.get('http://vm.niif.cloud.bme.hu:9200/nonce', {
            params: {
                address: environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC']
            }
        })
            .then(function (response) {
                nonce = response.data.response;

                const signature = signTransaction(
                    0,
                    environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC'],
                    environment.addresses[address],
                    value / 100,
                    "default",
                    parseInt(nonce)
                );

                axios.post('http://vm.niif.cloud.bme.hu:9200/transferAsset', {
                    "amount": parseInt(value / 100),
                    "from": environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC'],
                    "nonce": parseInt(nonce),
                    "pocket": "default",
                    "r": signature.r.toString("base64"),
                    "s": signature.s.toString("base64"),
                    "to": environment.addresses[address],
                    "v": signature.v
                })
                    .then(function (response) {
                        console.log(response.data);
                    })
                    .catch(function (error) {
                        console.log(error);
                    })
            })
            .catch(function (error) {
                console.log(error);
            })
    }

    function switchToHigherPlan(address, planNumber, value) {
        var nonce;
        axios.get('http://vm.niif.cloud.bme.hu:9200/nonce', {
            params: {
                address: environment.addresses[address]
            }
        })
            .then(function (response) {
                nonce = response.data.response;

                var idx;
                if (address == '0x53751f8b8b82DC367C82D00095BAaB7b4dA16F3e') {    // client 1
                    idx = 1;
                } else { // client 2
                    idx = 2;
                }

                const signature = signTransaction(
                    idx,
                    environment.addresses[address],
                    environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC'],
                    value / 100,
                    "default",
                    parseInt(nonce)
                );

                axios.post('http://vm.niif.cloud.bme.hu:9200/transferAsset', {
                    "amount": parseInt(value / 100),
                    "from": environment.addresses[address],
                    "nonce": parseInt(nonce),
                    "pocket": "default",
                    "r": signature.r.toString("base64"),
                    "s": signature.s.toString("base64"),
                    "to": environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC'],
                    "v": signature.v
                })
                    .then(function (response) {
                        console.log(response.data);
                        contract.functions.confirmHigherPlanSwitchPayment(address, parseInt(planNumber), parseInt(value), {
                            gasLimit: 100000,
                          });
                    })
                    .catch(function (error) {
                        console.log(error);
                    })
            })
            .catch(function (error) {
                console.log(error);
            })
    }


    function signTransaction() {
        const jsutil = require('ethereumjs-util');

        if (arguments.length <= 1) {
            console.error('ERROR: Insufficient number of arguments');
            console.error('Usage: node sign_home_native_message.js <keyIndex> <...message parts>');
            return;
        }

        const keyPairs = require('./keys.json').keypair;
        const signingKeyIndex = arguments[0];

        if ((signingKeyIndex < 0) || (signingKeyIndex >= keyPairs.length)) {
            console.error(`ERROR: Key index out of range [0,${keyPairs.length - 1}]`);
            return;
        }

        var signingKey = keyPairs[signingKeyIndex].privateKeyString;
        if (signingKey.startsWith('0x')) {
            signingKey = signingKey.substring(2);
        }

        const messageParts = Array.prototype.slice.call(arguments, 1);
        const message = Buffer.from(messageParts.map(a => a.toString()).join(' '));

        const messageHash = jsutil.hashPersonalMessage(message);
        const keyBuffer = Buffer.from(signingKey, 'hex');
        const signature = jsutil.ecsign(messageHash, keyBuffer);

        console.log("Signature v: " + signature.v);
        console.log("Signature r (base64): " + signature.r.toString("base64"));
        console.log("Signature s (base64): " + signature.s.toString("base64"));

        return signature;
    }

}


const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n');
});

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
    main();
});