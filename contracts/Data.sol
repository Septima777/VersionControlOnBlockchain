pragma solidity >=0.4.0 <0.7.0;
// pragma experimental ABIEncoderV2;
// import "./Ownable.sol";

contract Data {
    
    event newAnswerAdded(string _url, string _newAnswerBody, string _newAnswerAuthor,
    string _newAnswerEditor, uint _newAnswerCreationDate, uint _newAnswerLastModified,
    uint _newAnswerLastActivity);

    event newDetailQuestionAdded(string _url, string _body, string _title, string _author, string _editor,
    uint viewCount);

    event newTimeQuestionAdded( uint _creationDate, uint _lastModified, uint _lastActivity);

    //variables
    StackOverflowInfo[] info;
    Answer[] answers;
    mapping (string => Answer) getAnswers;
    // mapping (string => CodeSnippet) public getCodeSnippet;
    mapping (string => StackOverflowInfo) public getInfo;
    // mapping (string => address) public addressQuestioner;
    address private _owner;

    struct StackOverflowInfo {
        string url;
        string questionBody;
        string questionTitle;
        string questionAuthor;
        string questionEditor;
        uint viewCount;
        uint questionCreationDate;
        uint questionLastModified;
        uint questionLastActivity;
    }

    // struct CodeSnippet {
    //     string url;
    //     uint date;
    //     string language;
    //     string projectName;
    //     string companyName;
    //     string projectPath;
    //     string projectAuthor;
    // }

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

    // constructor() internal {
    //     _owner = msg.sender;
    // }

    // create a new question
    function createNewQuestion(string memory _url, string memory _body, string memory _title,
    string memory _author, string memory _editor, uint _viewCount, uint _creationDate,
    uint _lastModified, uint _lastActivity) public {

        // addressQuestioner[_url] = msg.sender;
        
        getInfo[_url].url = _url;
        getInfo[_url].questionBody = _body;
        getInfo[_url].questionTitle = _title;
        getInfo[_url].questionAuthor = _author;
        getInfo[_url].questionEditor = _editor;
        getInfo[_url].viewCount = _viewCount;
        getInfo[_url].questionCreationDate = _creationDate;
        getInfo[_url].questionLastModified = _lastModified;
        getInfo[_url].questionLastActivity = _lastActivity;

        info.push(getInfo[_url]);

        emit newDetailQuestionAdded(getInfo[_url].url, getInfo[_url].questionBody,
        getInfo[_url].questionTitle, getInfo[_url].questionAuthor,
        getInfo[_url].questionEditor, getInfo[_url].viewCount);

        emit newTimeQuestionAdded(getInfo[_url].questionCreationDate,
        getInfo[_url].questionLastModified,getInfo[_url].questionLastActivity);
    }

    // function codeRelated() private {

    // }

    // update new answer
    // link with url from mapping
    // TO DO check owner!
    // TO Do set to private
    function updateNewAnswer(string memory _url, string memory _newAnswerBody,
    string memory _newAnswerAuthor, string memory _newAnswerEditor, uint _newAnswerCreationDate,
    uint _newAnswerLastModified, uint  _newAnswerLastActivity) public {

        if(getAnswers[_url].isValue){
            getAnswers[_url].url = _url;
            getAnswers[_url].answerBody = _newAnswerBody;
            getAnswers[_url].answerAuthor = _newAnswerAuthor;
            getAnswers[_url].answerEditor = _newAnswerEditor;
            getAnswers[_url].answerCreationDate = _newAnswerCreationDate;
            getAnswers[_url].answerLastModified = _newAnswerLastModified;
            getAnswers[_url].answerLastActivity = _newAnswerLastActivity;
        }
        else {
            getAnswers[_url].url = _url;
            getAnswers[_url].answerBody = _newAnswerBody;
            getAnswers[_url].answerAuthor = _newAnswerAuthor;
            getAnswers[_url].answerEditor = _newAnswerEditor;
            getAnswers[_url].isValue = true;
            getAnswers[_url].answerCreationDate = _newAnswerCreationDate;
            getAnswers[_url].answerLastModified = _newAnswerLastModified;
            getAnswers[_url].answerLastActivity = _newAnswerLastActivity;

            Answer memory newAnswer = Answer(getAnswers[_url].url,
                                             getAnswers[_url].answerBody,
                                             getAnswers[_url].answerAuthor,
                                             getAnswers[_url].answerEditor,
                                             getAnswers[_url].isValue,
                                             getAnswers[_url].answerCreationDate,
                                             getAnswers[_url].answerLastModified,
                                             getAnswers[_url].answerLastActivity);
            answers.push(newAnswer);
        }
       

        emit newAnswerAdded(getAnswers[_url].url, getAnswers[_url].answerBody,
        getAnswers[_url].answerAuthor, getAnswers[_url].answerEditor,
        getAnswers[_url].answerCreationDate, getAnswers[_url].answerLastModified,
        getAnswers[_url].answerLastActivity);

        // emit isUpdated(answer.url,true);
    }

    function getDetailAnswer(string memory url) public view returns (string memory, string memory, string memory,
    string memory, bool) {
        
        return (getAnswers[url].url,
                getAnswers[url].answerBody,
                getAnswers[url].answerAuthor,
                getAnswers[url].answerEditor,
                getAnswers[url].isValue);
    }

    function getTimeAnswer(string memory url) public view returns (uint, uint, uint) {
        return (getAnswers[url].answerCreationDate,
                getAnswers[url].answerLastModified,
                getAnswers[url].answerLastActivity);
    }

    function getDetailQuestion(string memory url) public view returns (string memory, string memory, string memory,
    string memory, string memory, uint) {
        return (getInfo[url].url,
                getInfo[url].questionBody,
                getInfo[url].questionTitle,
                getInfo[url].questionAuthor,
                getInfo[url].questionEditor,
                getInfo[url].viewCount);
    }

    function getTimeQuestion(string memory url) public view returns (uint, uint, uint) {
        return (getInfo[url].questionCreationDate,
                getInfo[url].questionLastModified,
                getInfo[url].questionLastActivity);
    }

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