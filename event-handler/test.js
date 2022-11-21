const environment = require('./config/environment.js');
const insuranceTokenABI = require('./config/insuranceTokenABI.js');
const { Alchemy, Network, Wallet, Utils } = require("alchemy-sdk");
const ethers = require('ethers');
const axios = require('axios');
const http = require('http');

// declare server variables
const hostname = '127.0.0.1';
const port = 8081;

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
                nonce
            );

            axios.post('http://vm.niif.cloud.bme.hu:9200/transferAsset', {
                "amount": value,
                "from": environment.addresses[address],
                "nonce": nonce,
                "pocket": "default",
                "r": signature.r,
                "s": signature.s,
                "to": environment.addresses['0xFfcBb58AD6892853c86192C108837f827D4b23eC'],
                "v": signature.v
            })
            .then(function (response) {
                console.log(response.data);
                //contract.functions.confirmMonthlyFeePayment(address);
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

    console.log(keyPairs.length);
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

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n');
});

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
    signTransaction(1, '0x85e87dc35ce10ae2080555e598381a1ee72de979', '0x436f5fa13b07f29c1bc3d24e0db3789d3e72b6d4', 1, 'default', 1);
});