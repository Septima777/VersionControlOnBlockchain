const csv = require('csvtojson');
const Web3 = require('web3');
const readFile = require('fs').readFile;
// const csvFile = require('output_test.csv');

        var myContract;
        var userAccount;
        console.log("test");
        // var csv = require("csvtojson");
        // csv().fromFile('output_test.csv').on("json",function(jsonArrayObj){ 
        //             console.log("jdslfm"); 
        // })

        // csv().fromFile('output_test.csv').on('json',(jsonObj)=>{
        //     // combine csv header row and csv line to a json object
        //     // jsonObj.a ==> 1 or 4
        //     // console.log("it's ok");
        // }).on('done',(error)=>{
        //     console.log('hellooo');
        // })
        
        readFile('./output_test.csv', 'utf-8', (err, fileContent) => {
            if(err) {
                console.log(err); // Do something to handle the error or just throw it
                throw new Error(err);
            }
            const jsonObj = csv.toObject(fileContent);
            console.log("qqqqqqq");
            console.log(jsonObj);
        });

        // function startApp() {
        //     var myContractAddress = "0x19c4d14640c77f872e20a3fe1efc9a9399796d5f"; // show at first deployment
        //     myContract = new web3js.eth.Contract(myContractABI, myContractAddress);

        //     web3.eth.defaultAccount = web3.eth.account[0];
        // }

        /** example */
        // function getZombieDetails(id) {
        // return cryptoZombies.methods.zombies(id).call()
        // }

        // function createNewQuestion(url, body, title, author, editor, viewcount ,
        // creationDate, lastModified, lastActivity){
        //     return myContract.methods.createNewQuestion(url, body, title, author, editor, viewcount ,
        //             creationDate, lastModified, lastActivity).call()
        // }

        // function getDetailQuestion(url){
        //     return myContract.methods.getDetailQuestion(url).call()
        // }

        // function getTimeQuestion(url){
        //     return myContract.methods.getTimeQuestion(url).call()
        // }

        // function updateNewAnswer(url, body, author, editor,
        // creationDate, lastModified, lastActivity){
        //     return myContract.methods.updateNewAnswer(url, body, author, editor,
        //             creationDate, lastModified, lastActivity).call()
        // }

        // function getDetailAnswer(url){
        //     return myContract.methods.getDetailAnswer(url).call()
        // }

        // function getTimeAnswer(url){
        //     return myContract.methods.getTimeAnswer(url).call()
        // }

        // window.addEventListener('load', function() {
        
        // // var Web3 = require('web3');

        // // Checking if Web3 has been injected by the browser (Mist/MetaMask)
        // if (typeof web3 !== 'undefined') {
        //     // Use Mist/MetaMask's provider
        //     web3 = new Web3(web3.currentProvider);
        // } else {
        //     web3 = new Web3('ws://localhost:8545');        
        // }

        // createNewQuestion("www.question.com","new question", "title",
        //     "sept", "", 0, 1111, 0, 3333).then(function(e,r){
        //     console.log("hello worldddd");
        // })

        // // Now you can start your app & access web3js freely:
        // startApp()

        // })  