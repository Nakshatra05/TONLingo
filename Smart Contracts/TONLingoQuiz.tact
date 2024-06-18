// This contract will manage quiz questions and user answers, awarding points based on correct answers.

contract TONLingoQuiz {
    struct Quiz {
        uint256 id;
        string question;
        string correctAnswer;
        uint256 points;
    }

    mapping(uint256 => Quiz) public quizzes;
    mapping(address => mapping(uint256 => bool)) public userAnswered;
    address public owner;
    uint256 public nextQuizId;

    event QuizCreated(uint256 indexed quizId, string question, uint256 points);
    event QuizAnswered(address indexed user, uint256 indexed quizId, bool correct, uint256 points);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() public {
        owner = msg.sender;
        nextQuizId = 1;
    }

    function createQuiz(string memory _question, string memory _correctAnswer, uint256 _points) public onlyOwner {
        quizzes[nextQuizId] = Quiz(nextQuizId, _question, _correctAnswer, _points);
        emit QuizCreated(nextQuizId, _question, _points);
        nextQuizId++;
    }

    function answerQuiz(uint256 _quizId, string memory _answer) public {
        require(quizzes[_quizId].id != 0, "Quiz does not exist");
        require(!userAnswered[msg.sender][_quizId], "Quiz already answered");

        bool correct = keccak256(abi.encodePacked(_answer)) == keccak256(abi.encodePacked(quizzes[_quizId].correctAnswer));
        if (correct) {
            // Award points to the user
            // Call the UserManagement contract to award points
        }

        userAnswered[msg.sender][_quizId] = true;
        emit QuizAnswered(msg.sender, _quizId, correct, correct ? quizzes[_quizId].points : 0);
    }
}
