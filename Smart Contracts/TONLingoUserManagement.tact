//This contract will manage user registration, point accumulation, and reward distribution.

contract TONLingoUserManagement {
    struct User {
        address userAddress;
        uint256 points;
    }

    mapping(address => User) public users;
    uint256 public totalPoints;
    address public owner;

    event PointsEarned(address indexed user, uint256 points);
    event PointsRedeemed(address indexed user, uint256 points);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function registerUser(address _user) public onlyOwner {
        require(users[_user].userAddress == address(0), "User already registered");
        users[_user] = User(_user, 0);
    }

    function awardPoints(address _user, uint256 _points) public onlyOwner {
        require(users[_user].userAddress != address(0), "User not registered");
        users[_user].points += _points;
        totalPoints += _points;
        emit PointsEarned(_user, _points);
    }

    function redeemPoints(address _user, uint256 _points) public onlyOwner {
        require(users[_user].userAddress != address(0), "User not registered");
        require(users[_user].points >= _points, "Insufficient points");
        users[_user].points -= _points;
        totalPoints -= _points;
        emit PointsRedeemed(_user, _points);
    }

    function getUserPoints(address _user) public view returns (uint256) {
        return users[_user].points;
    }
}
