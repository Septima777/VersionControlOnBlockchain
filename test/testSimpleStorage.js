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

        // it("Update answer", async() => {
                
        //     await contractInstance.updateNewAnswer("www.question.com","new answer","kulchol",
        //     "kul",4444,5555,6666);

        //     getDetailAnswer = await contractInstance.getDetailAnswer("www.question.com");
        //     getTimeAnswer = await contractInstance.getTimeAnswer("www.question.com");
        //     console.log(getDetailAnswer);
        //     console.log(getTimeAnswer);

        //     assert.equal("www.question.com",getDetailAnswer['0']);
        //     assert.equal("new answer",getDetailAnswer['1']);
        //     assert.equal("kulchol",getDetailAnswer['2']);
        //     assert.equal("kul",getDetailAnswer['3']);
        //     assert.equal(true,getDetailAnswer['4']);

        //     assert.equal(4444,getTimeAnswer['0']);
        //     assert.equal(5555,getTimeAnswer['1']);
        //     assert.equal(6666,getTimeAnswer['2']);
        // })

        it("Create new code snippet", async() => {
            await contractInstance.createNewCodeSnippet("www.question.com","1234", "python",
            "name", "company", "/build/path/", "sept");

            await contractInstance.createNewCodeSnippet("www.question.com","5678", "java",
            "name2", "company2", "/build/path/2", "kul");            
            
            // getDetailCodeSnippet = await contractInstance.getDetailCodeSnippet("www.question.com");
            // console.log(getDetailCodeSnippet);

                // assert.equal("www.question.com",getDetailCodeSnippet[0]['url']);
                // assert.equal("1234",getDetailCodeSnippet[0]['date']);
                // assert.equal("python",getDetailCodeSnippet[0]['language']);
                // assert.equal("name",getDetailCodeSnippet[0]['projectName']);
                // assert.equal("company",getDetailCodeSnippet[0]['companyName']);
                // assert.equal("/build/path/",getDetailCodeSnippet[0]['projectPath']);
                // assert.equal("sept",getDetailCodeSnippet[0]['projectAuthor']);

                // assert.equal("www.question.com",getDetailCodeSnippet[1]['url']);
                // assert.equal("5678",getDetailCodeSnippet[1]['date']);
                // assert.equal("java",getDetailCodeSnippet[1]['language']);
                // assert.equal("name2",getDetailCodeSnippet[1]['projectName']);
                // assert.equal("company2",getDetailCodeSnippet[1]['companyName']);
                // assert.equal("/build/path/2",getDetailCodeSnippet[1]['projectPath']);
                // assert.equal("kul",getDetailCodeSnippet[1]['projectAuthor']);
           
            getIndexOfCodeSnippet = await contractInstance.getIndexOfCodeSnippet("www.question.com");
            console.log(getIndexOfCodeSnippet);
            getDetailCodeSnippet = await contractInstance.getDetailCodeSnippet("www.question.com",0);
            console.log(getDetailCodeSnippet);

            

            
            

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

   
