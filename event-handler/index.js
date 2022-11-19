const http = require('http');
const Web3 = require('web3');
const environment = require('./config/environment.js');
const insuranceTokenABI = require('./config/insuranceTokenABI.js');

// declare server variables
const hostname = '127.0.0.1';
const port = 8080;

async function main() {

    const web3 = new Web3(new Web3.providers.WebsocketProvider(environment.WEBSOCKET_PROVIDER));  // has to be websocket (ws) connection
    const CONTRACT_ADDRESS = environment.CONTRACT_ADDRESS;

    const insuranceTokenContract = new web3.eth.Contract(insuranceTokenABI, CONTRACT_ADDRESS);

    let options = {
        filter: {
            value: [],
        },
        fromBlock: 0
    };

    class Report {
        //uint32 id;
        //bytes pictureIpfsHash;
        //bytes documentIpfsHash;
        //uint32 damagePrice;
        //uint32 compensationPrice;
        //uint8 numberOfConfirmations;
        //bool approved;
    }

    insuranceTokenContract.events.CompensationPayment(options)
        .on('data', event => {
            const data = {
                dataType: "CompensationPayment",
                address: event.returnValues._address,
                damagePrice: event.returnValues.damagePrice
            }
            console.log(data);

            // TODO: API CALL
        })

    insuranceTokenContract.events.DamageDeclaration(options)
        .on('data', event => {
            const data = {
                dataType: "DamageDeclaration",
                address: event.returnValues._address,
                report: event.returnValues.report
            }
            console.log(data);

            // TODO: API CALL
        })

    insuranceTokenContract.events.MontlyFeePayment(options)
        .on('data', event => {
            const data = {
                dataType: "MontlyFeePayment",
                address: event.returnValues._address,
                value: event.returnValues.value
            }
            console.log(data);

            // TODO: API CALL
        })

    insuranceTokenContract.events.SwitchHigherPlan(options)
        .on('data', event => {
            const data = {
                dataType: "SwitchHigherPlan",
                address: event.returnValues._address,
                feeDifference: event.returnValues.feeDifference
            }
            console.log(data);

            // TODO: API CALL
        })

    insuranceTokenContract.events.SwitchLowerPlan(options)
        .on('data', event => {
            const data = {
                dataType: "SwitchLowerPlan",
                address: event.returnValues._address,
                utilityTokens: event.returnValues.utilityTokens
            }
            console.log(data);

            // TODO: API CALL
        })

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