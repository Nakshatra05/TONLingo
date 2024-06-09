contract TONLingo {
    struct User {
        address userAddress;
        uint256 points;
    }

    mapping(address => User) public users;
    uint256 public totalPoints;
    address public owner;

    event PointsEarned(address indexed user, uint256 points);
    event LotteryWon(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function registerUser(address _user) public onlyOwner {
        users[_user] = User(_user, 0);
    }

    function awardPoints(address _user, uint256 _points) public onlyOwner {
        users[_user].points += _points;
        totalPoints += _points;
        emit PointsEarned(_user, _points);
    }

    function drawLottery(address _winner, uint256 _amount) public onlyOwner {
        require(users[_winner].userAddress != address(0), "User not registered");
        emit LotteryWon(_winner, _amount);
    }

    function getUserPoints(address _user) public view returns (uint256) {
        return users[_user].points;
    }
}
