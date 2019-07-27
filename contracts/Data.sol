pragma solidity >=0.4.10 <0.7.0;
pragma experimental ABIEncoderV2;
// import "./Ownable.sol";

/// @title Data
/// @author Noppawan Kulchol
/// @dev This contract was created to stored data
///      both stack overflow information and code snippet on blockchain.
contract Data {
    
    // event of adding a new answer to the question
    // event newAnswerAdded(string _url, string _newAnswerBody, string _newAnswerAuthor,
    // string _newAnswerEditor, uint _newAnswerCreationDate, uint _newAnswerLastModified,
    // uint _newAnswerLastActivity);

    // // event of adding the question's detail
    // event newDetailQuestionAdded(string _url, string _title, uint viewCount,
    // string _author, string _editor);

    // // event of adding the question's time
    // event newTimeQuestionAdded( uint _creationDate, uint _lastActivity,uint _lastModified);

    // array that collect answer link
    string[] answerLink;
    // map question url to question data
    mapping (string => Question) public getQuestion;
    // map question url to answer
    mapping (string => string[]) public getAnswer;
    // map answer url to answer
    mapping (string => string[]) public getOneAnswer;
    // map code snippet url to code snippet data
    mapping (string => Snippet[]) public getSnippet;
    // map question url to question UUID
    mapping (string => uint) public getUUIDFromQuestion;
    // map answer url to answer UUID
    mapping (string => uint[]) public getUUIDFromAnswer;

    // This is a struct of question from stack overflow information
    struct Question {
        string url;
        string data;
        uint uuidFromSnippet;
        bool isValue;
    }

    // This is a struct of code snippet
    struct Snippet {
        string data;
        uint uuid;
    }

    // This is a struct of answer of each question
    struct NewAnswer {
        string url;
        string data;
    }

    // constructor() internal {
    //     _owner = msg.sender;
    // }

    ///@param _url url from csv file
    ///@param _link question url (if url is an answer link)
    ///@param _data detail of question
    // create question and answer
    function createNewQuestion(string memory _url,string memory _link, string memory _data) public {
        // if _link equal to "", it is a question
        if( (keccak256(abi.encodePacked((_link))) == keccak256(abi.encodePacked(("")))) ){
            getQuestion[_url].url = _url;
            getQuestion[_url].data = _data;
        } else{ // _link has value, it is a answer
            if(hasAnswerLink(_url)){
                assert(hasAnswerLink(_url));
            }else{
                answerLink.push(_url);
                // collect answer per question
                getOneAnswer[_url].push(_data);
                // collect all answer of each question
                addAnswer(_link,_data);
            }
        }
        setValue(_url);
    }
    ///@param _url questionlink of answer
    ///@param _data data of question
    // add answer of each question
    function addAnswer(string memory _url, string memory _data) public {
        getAnswer[_url].push(_data);
    }
    ///@param _url question url
    ///@param _id UUID from code snippet
    // update question UUID, which generate from code snippet
    function updateUUIDToQuestion(string memory _url, uint _id) private {
        // check url in array and add uuid of code snippet in struct of stackoverflowInfo
        if(contains(_url)){
            getQuestion[_url].uuidFromSnippet = _id;
            getUUIDFromQuestion[_url] = _id;
        }
        else{
            // in case that have not generate uuid from snippet method yet.
            getQuestion[_url].uuidFromSnippet = 0;
        }
    }
    ///@param _url question link of answer
    ///@param _id UUID from code snippet
    // update answer UUID, which generate from code snippet
    function updateUUIDToAnswer(string memory _url, uint _id) private {
        getUUIDFromAnswer[_url].push(_id);
    }

    ///@param _url url from csv file
    ///@param _link question url (if url is an answer link)
    ///@param _data data of code snippet
    // create code snippet and generate UUID for question and answer
    function createNewCodeSnippet(string memory _url, string memory _link, string memory _data) public {
        // create new code snippet and generate uuid
        // push new code snippet into map getCodeSnippet that link with _url
        uint uuid = getUUID(appendString(_data,bytes32ToString(blockNumber())));
        Snippet memory snippet = Snippet(_data,uuid);

        if( (keccak256(abi.encodePacked((_link))) == keccak256(abi.encodePacked(("")))) ){
            getSnippet[_url].push(snippet);
            updateUUIDToQuestion(_url,uuid);
        }else{
            getSnippet[_link].push(snippet);
            updateUUIDToAnswer(_link,uuid);
        }

        // // call event
        // emit newCodeSnippetAdded(newCode.url, newCode.date, newCode.language, newCode.projectName,
        // newCode.companyName, newCode.projectPath, newCode.projectAuthor);
    }
    
    ///@param _url code snippet url
    // get index of code snippet
    function getIndexOfSnippet(string memory _url) public view returns (uint) {
        return (getSnippet[_url].length);
    }

    ///@param _url question link of answer
    // get index of answer
    function getIndexOfAnswerFromQuestionLink(string memory _url) public view returns (uint) {
        return (getAnswer[_url].length);
    }

    ///@param _url question url
    // get detail of each question
    function getDetailQuestion(string memory _url) public view returns (uint, string memory, bool){
        return (getQuestion[_url].uuidFromSnippet,
                getQuestion[_url].data,
                getQuestion[_url].isValue);
    }
    
    ///@param _url answer url
    // get answer from each answer link
    function getAnswerFromAnswerLink(string memory _url) public view returns (string[] memory){
        return (getOneAnswer[_url]);
    }
    
    ///@param _url question url
    // get all answer from each question link
    function getAnswerFromQuestionLink(string memory _url) public view returns (string[] memory){
        return (getAnswer[_url]);
    }

    ///@param _url question url of answer or answer url
    // can get answer per each question and all answer
    function getDetailAnswer(string memory _url) public view returns (string[] memory){
        if(hasAnswerLink(_url)){
            return getAnswerFromAnswerLink(_url);
        }else{
            return getAnswerFromQuestionLink(_url);
        }
    }

    ///@param _url question url
    // get question and answer of this url
    function getQAndA(string memory _url) public view returns (uint, string memory, string[] memory){
        return (getQuestion[_url].uuidFromSnippet,
                getQuestion[_url].data,
                getAnswerFromQuestionLink(_url));
    }
    ///@param _url code snippet url
    ///@param _index index of code snippet
    // get detail of code snippet
    function getDetailSnippet(string memory _url, uint _index) public view returns (string memory, uint){
        // require((_index > getSnippet[_url].length) || (_index < 0),"index out of bound");
        return (getSnippet[_url][_index].data,
                getSnippet[_url][_index].uuid);
    }

    ///@param s code snippet data that will be changed to UUID
    // generate UUID
    function getUUID(string memory s) public pure returns (uint){
        bytes memory data = stringToBytes(s);
       return uint(keccak256(abi.encodePacked(data)));
    }

    ///@param _url question url
    // get question UUID
    function getUUIDQuestion(string memory _url) public view returns (uint){
        return getUUIDFromQuestion[_url];
    }

    ///@param _url answer url
    // get answer UUID
    function getUUIDAnswer(string memory _url, uint _index) public view returns (uint){
        // require((_index > getUUIDFromAnswer[_url].length) || (_index < 0),"index out of bound");
        return getUUIDFromAnswer[_url][_index];
    }

    ///@param _url code snippet url
    ///@param _index index of code snippet
    // get code snippet UUID
    function getUUIDSnippet(string memory _url, uint _index) public view returns (uint){
        // require((_index > getSnippet[_url].length) || (_index < 0),"index out of bound");
        return getSnippet[_url][_index].uuid;
    }

    ///@param s any string word, which you want to convert it to byte
    // convert string to bytes
    function stringToBytes(string memory s) public pure returns (bytes memory){
        bytes memory b = bytes(s);
        return b;
    }

    // convert block number to bytes
    function blockNumber() public view returns (bytes32) {
        return bytes32(block.number);
    }

    ///@param data any bytes32, which you want to convert it to string
    // convert bytes32 to string
    function bytes32ToString (bytes32 data) public pure returns (string memory) {
        bytes memory bytesString = new bytes(32);
        for(uint j = 0; j < 32; j++){
            byte char = byte(bytes32(uint(data) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[j] = char;
            }
        }
        return string(bytesString);
    }

    ///@param _url question url
    // set status of question
    function setValue(string memory _url) public{
        getQuestion[_url].isValue = true;
    }

    ///@param _url question url
    // check question contain in array
    function contains(string memory _url) public view returns (bool){
        return getQuestion[_url].isValue;
    }

    ///@param a first string
    ///@param b second string
    // append first and second string together
    function appendString(string memory a, string memory b) public pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

    ///@param _url answer url
    // check answer link contain in array
    function hasAnswerLink(string memory _url) public view returns (bool){
        bool check = false;
        for( uint i = 0; i < answerLink.length; i++){
            if( (keccak256(abi.encodePacked((answerLink[i]))) == keccak256(abi.encodePacked((_url)))) ){
                check = true;
                break;
            }
        }
        return check;
    }


   // function getDetailCodeSnippet(string memory url) public view returns (CodeSnippet[] memory snippet){
    //     CodeSnippet[] memory code = new CodeSnippet[](getCodeSnippet[url].length);
    //     uint count = 0;
    //     for (uint i = 0; i < getCodeSnippet[url].length; i++) {
    //         code[count] = getCodeSnippet[url][i];
    //         count++;
    //     }
    //     return (code);
    // }

    // function owner() public view returns(address) {
    //     return _owner;
    // }

    // function isOwner() public view returns(bool) {
    //     return msg.sender == _owner;
    // }

    // modifier onlyOwner() {
    //     require(isOwner());
    //     _;
    // }

}