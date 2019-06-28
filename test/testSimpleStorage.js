// const SimpleStorage = artifacts.require('SimpleStorage');
const Data = artifacts.require('Data');

    contract("Data", async(accounts) => {
        let contractInstance;
        beforeEach(async() => {
            // runs before each test in this block
            contractInstance = await Data.deployed();
            
            });
        
        it("Create new question", async() => {  
            await contractInstance.createNewQuestion("www.question.com","new question", "title",
            "sept", "", 0, 1111, 0, 3333);          

            getDetailQuestion = await contractInstance.getDetailQuestion(0);
            getTimeQuestion = await contractInstance.getTimeQuestion(0);
            // console.log(getDetailQuestion);
            // console.log(getTimeQuestion);

            assert.equal("www.question.com",getDetailQuestion['0']);
            assert.equal("new question",getDetailQuestion['1']);
            assert.equal("title",getDetailQuestion['2']);
            assert.equal("sept",getDetailQuestion['3']);
            assert.equal("",getDetailQuestion['4']);
            assert.equal(0,getDetailQuestion['5']);

            assert.equal(1111,getTimeQuestion['0']);
            assert.equal(0,getTimeQuestion['1']);
            assert.equal(3333,getTimeQuestion['2']);

        })

        it("Update answer", async() => {

            await contractInstance.updateNewAnswer("www.question.com","new answer","kulchol",
            "kul",4444,5555,6666);

            getDetailAnswer = await contractInstance.getDetailAnswer(0);
            getTimeAnswer = await contractInstance.getTimeAnswer(0);
            console.log(getDetailAnswer);
            console.log(getTimeAnswer);
            console.log(getTimeAnswer['0'])

            assert.equal("www.question.com",getDetailAnswer['0']);
            assert.equal("new answer",getDetailAnswer['1']);
            assert.equal("kulchol",getDetailAnswer['2']);
            assert.equal("kul",getDetailAnswer['3']);
            assert.equal(true,getDetailAnswer['4']);

            assert.equal(4444,getTimeAnswer['0']);
            assert.equal(5555,getTimeAnswer['1']);
            assert.equal(6666,getTimeAnswer['2']);
        })



    }); // end of contract

// contract("SimpleStorage", async(accounts) => {
//     let contractInstance;
//     beforeEach(async() => {
//         // runs before each test in this block
//         contractInstance = await SimpleStorage.deployed();
//         contractInstance.set(0);
//       });
    
//     it("should set number", async() => {           
//             await contractInstance.set(9);
//             getAns = await contractInstance.get();

//             // console.log("get = " + getAns.toString());

//             assert.equal(9, getAns.toString());
//         })

    

//     it("should add number", async() => {
//             await contractInstance.set(5);
//             addAns = await contractInstance.add(10);
//             getAns = await contractInstance.get();
            
//             assert.equal(15, getAns.toString());
//         })

//     }); // end of contract

   
