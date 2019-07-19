
// const SimpleStorage = artifacts.require('SimpleStorage');
const Data = artifacts.require('Data');

    contract("Data", async(accounts) => {
        let contractInstance;
        beforeEach(async() => {
            // runs before each test in this block
            contractInstance = await Data.deployed();
            
            });
        
        // it("Create new question", async() => {  
        //     await contractInstance.createNewQuestion("www.question.com", "title",
        //     0,"sept", "", 1111, 0, 3333); 
            
        //     await contractInstance.createNewQuestion("www.question2.com", "title2",
        //     0,"sept2", "", 1112, 0, 3332);

        //     getDetailQuestion = await contractInstance.getDetailQuestion("www.question.com");
        //     // getDetailQuestion2 = await contractInstance.getDetailQuestion("www.question2.com");
        //     getTimeQuestion = await contractInstance.getTimeQuestion("www.question.com");
        //     console.log(getDetailQuestion);
        //     // console.log(getDetailQuestion2);
        //     console.log(getTimeQuestion);

        //     assert.equal("www.question.com",getDetailQuestion['0']);
        //     assert.equal("title",getDetailQuestion['1']);
        //     assert.equal(0,getDetailQuestion['2']);
        //     assert.equal("sept",getDetailQuestion['3']);
        //     assert.equal("",getDetailQuestion['4']);
            

        //     assert.equal(1111,getTimeQuestion['0']);
        //     assert.equal(0,getTimeQuestion['1']);
        //     assert.equal(3333,getTimeQuestion['2']);

        // })

        // YES!!
        // it("create new snippet", async() => {
        //    question = await contractInstance.createNewQuestion("www.q.com","","dataQ");
        //    snippetQuestion = await contractInstance.createNewCodeSnippet("www.q.com","","snippetQ");
        //    answer = await contractInstance.createNewQuestion("www.a.com","www.qq.com","data of answer");
        //    snippetAnswer = await contractInstance.createNewCodeSnippet("www.a.com","www.qq.com","snippetA");

        //    getUUIDQuestion = await contractInstance.getUUIDQuestion("www.q.com");
        //    getUUIDSnippetQ = await contractInstance.getUUIDSnippet("www.q.com",0);
        //    getUUIDAnswer = await contractInstance.getUUIDAnswer("www.qq.com",0);
        //    getUUIDSnippetA = await contractInstance.getUUIDSnippet("www.qq.com",0);

        //    console.log(getUUIDQuestion);
        //    console.log(getUUIDSnippetQ);
        //    console.log(getUUIDAnswer);
        //    console.log(getUUIDSnippetA);
        // })
        
        // YES!!
        // it("create a new question", async() => {
        //     question = await contractInstance.createNewQuestion("www.q.com","","data");
        //     getQuestion = await contractInstance.getDetailQuestion("www.q.com");
        //     console.log(getQuestion);
        //     await contractInstance.createNewCodeSnippet("www.q.com","snippet");
        //     getQuestion2 = await contractInstance.getDetailQuestion("www.q.com");
        //     console.log(getQuestion2);
        // })
        
        // YES!!   
        it("get answer", async() => {
            question = await contractInstance.createNewQuestion("www.qq.com","","data of question");
            answer = await contractInstance.createNewQuestion("www.a.com","www.qq.com","data of answer");
            answer2 = await contractInstance.createNewQuestion("www.a2.com","www.qq.com","data of answer2");
            // answer22 = await contractInstance.createNewQuestion("www.a2.com","www.q2.com","data of answer22");
            // answer3 = await contractInstance.createNewQuestion("www.a.com","www.qqq.com","data of answer3");

            getAnswer = await contractInstance.getDetailAnswer("www.qq.com");
            // getQAndA = await contractInstance.getQAndA("www.qq.com");
            console.log(getAnswer);
        })
        
        // YES!!
        // it("get Q and A", async() => {
        //     question = await contractInstance.createNewQuestion("www.q.com","","data of question");
        //     snippetQuestion = await contractInstance.createNewCodeSnippet("www.q.com","","snippetQ");
        //     answer = await contractInstance.createNewQuestion("www.a1.com","www.q.com","data of answer");
        //     answer2 = await contractInstance.createNewQuestion("www.a2.com","www.q.com","data of answer2");
        //     getQAndA = await contractInstance.getQAndA("www.q.com");
        //     console.log(getQAndA);
        //     // console.log(getQAndA2);
        // })


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

   
