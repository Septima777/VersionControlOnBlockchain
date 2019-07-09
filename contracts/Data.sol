pragma solidity >=0.4.0 <0.7.0;
// pragma experimental ABIEncoderV2;
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
    event newCodeSnippetAdded(string _url, string _date, string _language, string _projectName,
    string _companyName, string _projectPath, string _projectAuthor);

    // array of stack overflow info
    StackOverflowInfo[] info;
    // array of answer
    Answer[] answers;
    // map answer (struct) with url (string)
    mapping (string => Answer) public getAnswers;
    // map code snippet (array of struct) with url (string)
    mapping (string => CodeSnippet[]) public getCodeSnippet;
    // map stack overflow info (struct) with url (string)
    mapping (string => StackOverflowInfo) public getInfo;

    // mapping (string => address) public addressQuestioner;
    // address private _owner;

    // This is a struct of stack overflow info
    struct StackOverflowInfo {
        // url of question
        string url;
        // title of question
        string questionTitle;
        // number of view of question
        uint viewCount;
        // author of question
        string questionAuthor;
        // editor of question
        string questionEditor;
        // creation date of question
        uint questionCreationDate;
        // last activity date of question
        uint questionLastActivity;
        // last modified date of question
        uint questionLastModified;
    }

    // This is a struct of code snippet
    struct CodeSnippet {
        // url of code snippet (same for question)
        string url;
        // date of code snippet
        string date;
        // language of code snippet
        string language;
        // project's name of code snippet
        string projectName;
        // company's name of code snippet
        string companyName;
        // project's path of code snippet
        string projectPath;
        // project's author of code snippet
        string projectAuthor;
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

    // constructor() internal {
    //     _owner = msg.sender;
    // }

    /// create a new question
    /// @param _url url of question
    /// @param _title title of question
    /// @param _viewCount number of view of question
    /// @param _author author of question
    /// @param _editor editor of question
    /// @param _creationDate creation date of question
    /// @param _lastActivity last activity date of question
    /// @param _lastModified last modified date of question
    function createNewQuestion(string memory _url, string memory _title,
    uint _viewCount, string memory _author, string memory _editor,
    uint _creationDate, uint _lastActivity, uint _lastModified) public {
        // collecting data into map getInfo that link with _url
        getInfo[_url].url = _url;
        getInfo[_url].questionTitle = _title;
        getInfo[_url].viewCount = _viewCount;
        getInfo[_url].questionAuthor = _author;
        getInfo[_url].questionEditor = _editor;
        getInfo[_url].questionCreationDate = _creationDate;
        getInfo[_url].questionLastActivity = _lastActivity;
        getInfo[_url].questionLastModified = _lastModified;

        // push map getInfo into array of stack overflow info (StackOverflowInfo[])
        // for collecting all of data
        info.push(getInfo[_url]);

        // call event
        emit newDetailQuestionAdded(getInfo[_url].url,
        getInfo[_url].questionTitle, getInfo[_url].viewCount,
        getInfo[_url].questionAuthor, getInfo[_url].questionEditor );
        // call event
        emit newTimeQuestionAdded(getInfo[_url].questionCreationDate,
        getInfo[_url].questionLastActivity,getInfo[_url].questionLastModified);
    }

    // create a new code snippet
    /// @param _url url of code snippet
    /// @param _date date of code snippet
    /// @param _language language of code snippet
    /// @param _projectName project's name of code snippet
    /// @param _companyName company's name of code snippet
    /// @param _projectPath project's path of code snippet
    /// @param _projectAuthor project's author of code snippet
    function createNewCodeSnippet(string memory _url, string memory _date, string memory _language,
    string memory _projectName, string memory _companyName, string memory _projectPath,
    string memory _projectAuthor) public {

        // create new code snippet
        CodeSnippet memory newCode = CodeSnippet(_url, _date, _language, _projectName,
         _companyName, _projectPath, _projectAuthor);
        // push new code snippet into map getCodeSnippet that link with _url
        getCodeSnippet[_url].push(newCode);

        // call event
        emit newCodeSnippetAdded(newCode.url, newCode.date, newCode.language, newCode.projectName,
        newCode.companyName, newCode.projectPath, newCode.projectAuthor);

    }

    // update a new answer of each question.
    // link with url from mapping.
    // TO DO check owner!
    // TO Do set to private
    /// @param _url url of answer
    /// @param _newAnswerBody body of answer
    /// @param _newAnswerAuthor author of answer
    /// @param _newAnswerEditor editor of answer
    /// @param _newAnswerCreationDate cration date of answer
    /// @param _newAnswerLastActivity last activity date of answer
    /// @param _newAnswerLastModified last modified date of answer
    // function updateNewAnswer(string memory _url, string memory _newAnswerBody,
    // string memory _newAnswerAuthor, string memory _newAnswerEditor, uint _newAnswerCreationDate,
    //  uint  _newAnswerLastActivity, uint _newAnswerLastModified) public {

    //     if(getAnswers[_url].isValue){
    //         getAnswers[_url].url = _url;
    //         getAnswers[_url].answerBody = _newAnswerBody;
    //         getAnswers[_url].answerAuthor = _newAnswerAuthor;
    //         getAnswers[_url].answerEditor = _newAnswerEditor;
    //         getAnswers[_url].answerCreationDate = _newAnswerCreationDate;
    //         getAnswers[_url].answerLastActivity = _newAnswerLastActivity;
    //         getAnswers[_url].answerLastModified = _newAnswerLastModified;
            
    //     }
    //     else {
    //         getAnswers[_url].url = _url;
    //         getAnswers[_url].answerBody = _newAnswerBody;
    //         getAnswers[_url].answerAuthor = _newAnswerAuthor;
    //         getAnswers[_url].answerEditor = _newAnswerEditor;
    //         getAnswers[_url].isValue = true;
    //         getAnswers[_url].answerCreationDate = _newAnswerCreationDate;
    //         getAnswers[_url].answerLastActivity = _newAnswerLastActivity;
    //         getAnswers[_url].answerLastModified = _newAnswerLastModified;
            
    //         Answer memory newAnswer = Answer(getAnswers[_url].url,
    //                                          getAnswers[_url].answerBody,
    //                                          getAnswers[_url].answerAuthor,
    //                                          getAnswers[_url].answerEditor,
    //                                          getAnswers[_url].isValue,
    //                                          getAnswers[_url].answerCreationDate,
    //                                          getAnswers[_url].answerLastActivity,
    //                                          getAnswers[_url].answerLastModified);
    //         answers.push(newAnswer);
    //     }
       
           // call event
    //     emit newAnswerAdded(getAnswers[_url].url, getAnswers[_url].answerBody,
    //     getAnswers[_url].answerAuthor, getAnswers[_url].answerEditor,
    //     getAnswers[_url].answerCreationDate, getAnswers[_url].answerLastActivity,
    //     getAnswers[_url].answerLastModified);

    // }

    // get answer's detail
    /// @param url url of question that user need to reply
    /// @return url, body, author, editor, and isValue (check that this url has previous answer or not)
    /// of answer
    function getDetailAnswer(string memory url) public view returns (string memory, string memory, string memory,
    string memory, bool) {
        return (getAnswers[url].url,
                getAnswers[url].answerBody,
                getAnswers[url].answerAuthor,
                getAnswers[url].answerEditor,
                getAnswers[url].isValue);
    }

    /// get answer's time
    /// @param url url of question that user need to reply
    /// @return creation date, last activity date, and last modified date of answer
    function getTimeAnswer(string memory url) public view returns (uint, uint, uint) {
        return (getAnswers[url].answerCreationDate,
                getAnswers[url].answerLastActivity,
                getAnswers[url].answerLastModified);
    }

    /// get question's detail (stack overflow info)
    /// @param url url of question
    /// @return url, title, viewcount, author, and editor of question
    function getDetailQuestion(string memory url) public view returns (string memory, string memory,
    uint, string memory, string memory) {
        return (getInfo[url].url,
                getInfo[url].questionTitle,
                getInfo[url].viewCount,
                getInfo[url].questionAuthor,
                getInfo[url].questionEditor);
    }

    /// get question's time
    /// @param url url of question
    /// @return creation date, last activity date, and last modified date of question
    function getTimeQuestion(string memory url) public view returns (uint, uint, uint) {
        return (getInfo[url].questionCreationDate,
                getInfo[url].questionLastActivity,
                getInfo[url].questionLastModified);
    }

    /// get the number of code snippet for each url
    /// @param url url of code snippet
    /// @return the number of code snippet for each url
    function getIndexOfCodeSnippet(string memory url) public view returns (uint){
        return (getCodeSnippet[url].length);
    }

    /// get code snippet's detail for each url
    /// @param url url of code snippet
    /// @param index the number of url
    /// @return url, date, language, project's name, company's name, project's path,
    ///         and project's author
    function getDetailCodeSnippet(string memory url, uint index) public view returns (string memory,
    string memory, string memory, string memory, string memory, string memory, string memory){
        return (getCodeSnippet[url][index].url,
                getCodeSnippet[url][index].date,
                getCodeSnippet[url][index].language,
                getCodeSnippet[url][index].projectName,
                getCodeSnippet[url][index].companyName,
                getCodeSnippet[url][index].projectPath,
                getCodeSnippet[url][index].projectAuthor);
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