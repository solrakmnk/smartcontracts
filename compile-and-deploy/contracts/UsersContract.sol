pragma solidity ^0.4.24;

contract UsersContract{
    struct User {
        string name;
        string surname;
    }

    mapping(address=> User) private users;
    mapping(address=>bool) private joinedUsers;
    address[] total;

    event onUserJoined(address,string);

    function join(string name,string surname) public {
        require(!usersJoined(msg.sender));
        User storage user=users[msg.sender];
        user.name=name;
        user.surname=surname;
        joinedUsers[msg.sender]=true;
        total.push(msg.sender);
        onUserJoined(msg.sender,string(abi.encodePacked(name," ",surname)));
    }
    function getUser(address addr) public view returns(string,string){
        require(usersJoined(addr));
        User memory user= users[addr];
        return (user.name,user.surname);
    }
    function usersJoined(address addr) private view returns (bool){
        return joinedUsers[addr];
    }

    function totalUsers() public view returns(uint){
        return total.length;
    }
}