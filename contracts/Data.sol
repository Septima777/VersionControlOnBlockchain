pragma solidity >=0.4.0 <0.7.0;
// pragma experimental ABIEncoderV2;
import "./Ownable.sol";

contract Data is Ownable {

    
    event newAnswerAdded(string _url, string _newAnswerBody, string _newAnswerAuthor,
    string _newAnswerEditor, uint _newAnswerCreationDate, uint _newAnswerLastModified,
    uint _newAnswerLastActivity);

    event newQuestionAdded(string _url, string _body, string _title, string _author, string _editor,
    uint viewCount, uint _creationDate, uint _lastModified, uint _lastActivity);

    event isUpdated(string _url, bool _done);

    //variables
    StackOverflowInfo[] info;
    Answer[] answers;
    mapping (string => Answer) getAnswers;
    mapping (string => CodeSnippet) public getCodeSnippet;
    mapping (string => StackOverflowInfo) public getInfo;
    // mapping (string => address) public addressQuestioner;
    // address[] private person;

    // function user() {
    //     owner = msg.sender;
    // }

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

    struct CodeSnippet {
        string url;
        uint date;
        string language;
        string projectName;
        string companyName;
        string projectPath;
        string projectAuthor;
    }

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

    // create a new question
    function createNewQuestion(string memory _url, string memory _body, string memory _title,
    string memory _author, string memory _editor, uint _viewCount, uint _creationDate,
    uint _lastModified, uint _lastActivity) public {

        // addressQuestioner[_url] = msg.sender;
        
        StackOverflowInfo memory newInfo = StackOverflowInfo(_url, _body, _title, _author, _editor,
        _viewCount, _creationDate, _lastModified, _lastActivity);
        
        info.push(newInfo);

        emit newQuestionAdded(newInfo.url, newInfo.questionBody, newInfo.questionTitle,
        newInfo.questionAuthor, newInfo.questionEditor, newInfo.viewCount,
        newInfo.questionCreationDate, newInfo.questionLastModified, newInfo.questionLastActivity);
    }

    // function codeRelated() private {

    // }

    // update new answer
    // link with url from mapping
    // TO DO check owner!
    // TO Do set to private
    function updateNewAnswer(string memory _url, string memory _newAnswerBody,
    string memory _newAnswerAuthor, string memory _newAnswerEditor, uint _newAnswerCreationDate,
    uint _newAnswerLastModified, uint  _newAnswerLastActivity) public onlyOwner {

        Answer memory answer = getAnswers[_url];
        if(answer.isValue){
            answer.url = _url;
            answer.answerBody = _newAnswerBody;
            answer.answerAuthor = _newAnswerAuthor;
            answer.answerEditor = _newAnswerEditor;
            answer.isValue = true;
            answer.answerCreationDate = _newAnswerCreationDate;
            answer.answerLastModified = _newAnswerLastModified;
            answer.answerLastActivity = _newAnswerLastActivity;
        }
        else{
            answer = Answer(_url,
                            _newAnswerBody,
                            _newAnswerAuthor,
                            _newAnswerEditor,
                            true,
                            _newAnswerCreationDate,
                            _newAnswerLastModified,
                            _newAnswerLastActivity);
            answers.push(answer);
        }

        // emit newAnswerAdded(answer.url, answer.answerBody, answer.answerAuthor,
        // answer.answerEditor, answer.answerCreationDate, answer.answerLastModified,
        // answer.answerLastActivity);
    }

    function getDetailAnswer(uint index) public view returns (string memory, string memory, string memory,
    string memory, bool) {
        
        return (answers[index].url,
                answers[index].answerBody,
                answers[index].answerAuthor,
                answers[index].answerEditor,
                answers[index].isValue);
    }

    function getTimeAnswer(uint index) public view returns (uint, uint, uint) {
        return (answers[index].answerCreationDate,
               answers[index].answerLastModified,
               answers[index].answerLastActivity);
    }

    function getDetailQuestion(uint index) public view returns (string memory, string memory, string memory,
    string memory, string memory, uint) {
        return (info[index].url,
                info[index].questionBody,
                info[index].questionTitle,
                info[index].questionAuthor,
                info[index].questionEditor,
                info[index].viewCount);
    }

    function getTimeQuestion(uint index) public view returns (uint, uint, uint) {
        return (info[index].questionCreationDate,
                info[index].questionLastModified,
                info[index].questionLastActivity);
    }

}