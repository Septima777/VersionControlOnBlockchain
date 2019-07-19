pragma solidity >=0.4.10 <0.7.0;
pragma experimental ABIEncoderV2;
// import "./Ownable.sol";

/// @title Data
/// @author Noppawan Kulchol
/// @dev This contract was created to stored data
///      both stack overflow info and code snippet on blockchain.
contract Data {
    
    // event of adding a new answer to the question
    event newAnswerAdded(string _url, string _newAnswerBody, string _newAnswerAuthor,
    string _newAnswerEditor, uint _newAnswerCreationDate, uint _newAnswerLastModified,
    uint _newAnswerLastActivity);

    // event of adding the question's detail
    event newDetailQuestionAdded(string _url, string _title, uint viewCount,
    string _author, string _editor);

    // event of adding the question's time
    event newTimeQuestionAdded( uint _creationDate, uint _lastActivity,uint _lastModified);

    // event of adding code snippet to url
    // event newCodeSnippetAdded(string _url, string _date, string _language, string _projectName,
    // string _companyName, string _projectPath, string _projectAuthor);

    // uuid which was generated in code snippet
    // uint public uuid = 0;
    // array of stack overflow info
    // StackOverflowInfo[] info;
    // array of answer
    // Answer[] answers;
    string[] answerLink;
    // map answer (struct) with url (string)
    mapping (string => Answer) public getAnswers;

    mapping (string => Question) public getQuestion;
    mapping (string => string[]) public getAnswer;
    // map code snippet (array of struct) with url (string)
    // mapping (string => CodeSnippet[]) public getCodeSnippet;
    // map stack overflow info (struct) with url (string)
    // mapping (string => StackOverflowInfo) public getInfo;
    //
    mapping (string => Snippet[]) public getSnippet;
    mapping (string => uint) public getUUIDFromQuestion;
    mapping (string => uint[]) public getUUIDFromAnswer;

    // mapping (string => address) public addressQuestioner;
    // address private _owner;

    // This is a struct of stack overflow info
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
    struct Answer {
        string url;
        string answerBody;
        string answerAuthor;
        string answerEditor;
        bool isValue;
        uint answerCreationDate;
        uint answerLastModified;
        uint answerLastActivity;
    }

    struct NewAnswer {
        string url;
        string data;
    }

    // constructor() internal {
    //     _owner = msg.sender;
    // }

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
                addAnswer(_link,_data);
            }
            
        }
        setValue(_url);
    }

    function addAnswer(string memory _url, string memory _data) public {
        getAnswer[_url].push(_data);
    }

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

    function updateUUIDToAnswer(string memory _url, uint _id) private {
        getUUIDFromAnswer[_url].push(_id);
    }

    // duplicate!!!!!!!!!!
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

    function getIndexOfSnippet(string memory _url) public view returns (uint) {
        return (getSnippet[_url].length);
    }

    function getIndexOfAnswer(string memory _url) public view returns (uint) {
        return (getAnswer[_url].length);
    }

    function getDetailQuestion(string memory _url) public view returns (uint, string memory, bool){
        return (getQuestion[_url].uuidFromSnippet,
                getQuestion[_url].data,
                getQuestion[_url].isValue);
    }

    function getDetailAnswer(string memory _url) public view returns (string[] memory){
        return (getAnswer[_url]);
    }

    function getQAndA(string memory _url) public view returns (uint, string memory, string[] memory){
        return (getQuestion[_url].uuidFromSnippet,
                getQuestion[_url].data,
                getAnswer[_url]);
    }

    function getDetailSnippet(string memory _url, uint _index) public view returns (string memory, uint){
        // require((_index > getSnippet[_url].length) || (_index < 0),"index out of bound");
        return (getSnippet[_url][_index].data,
                getSnippet[_url][_index].uuid);
    }

    function getUUID(string memory s) public pure returns (uint){
        bytes memory data = stringToBytes(s);
       return uint(keccak256(abi.encodePacked(data)));
    }

    function getUUIDQuestion(string memory _url) public view returns (uint){
        return getUUIDFromQuestion[_url];
    }

    function getUUIDAnswer(string memory _url, uint _index) public view returns (uint){
        // require((_index > getUUIDFromAnswer[_url].length) || (_index < 0),"index out of bound");
        return getUUIDFromAnswer[_url][_index];
    }

    function getUUIDSnippet(string memory _url, uint _index) public view returns (uint){
        // require((_index > getSnippet[_url].length) || (_index < 0),"index out of bound");
        return getSnippet[_url][_index].uuid;
    }


    function stringToBytes(string memory s) public pure returns (bytes memory){
        bytes memory b = bytes(s);
        return b;
    }

    function blockNumber() public view returns (bytes32) {
        return bytes32(block.number);
    }

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

    function setValue(string memory _url) public{
        getQuestion[_url].isValue = true;
    }

    function contains(string memory _url) public view returns (bool){
        return getQuestion[_url].isValue;
    }

    function appendString(string memory a, string memory b) public pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

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