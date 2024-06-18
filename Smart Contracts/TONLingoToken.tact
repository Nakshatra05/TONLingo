contract TONLingoToken {
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor(uint256 initialSupply) public {
        owner = msg.sender;
        totalSupply = initialSupply;
        balances[owner] = initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function mint(address _to, uint256 _value) public onlyOwner {
        totalSupply += _value;
        balances[_to] += _value;
        emit Mint(_to, _value);
    }

    function burn(address _from, uint256 _value) public onlyOwner {
        require(balances[_from] >= _value, "Insufficient balance to burn");
        balances[_from] -= _value;
        totalSupply -= _value;
        emit Burn(_from, _value);
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}
