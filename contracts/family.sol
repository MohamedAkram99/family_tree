// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
contract family{
    address owner;
    int256 familynumber;
    string familyname;
    int256 familymembersno;
    mapping (int256 => person) Family;
    int256 noofchildren;
    bool father_assigned;
    bool mother_assigned;
    struct person{
        string firstname;
        string lastname;
    }
        event FamilyCreated(address fromAddress, string firstname, string lastname);
        event familymemberadded(address fromAddress, string firstname, string lastname);

    constructor(string memory firstname, string  memory lastname,int256 number,string memory role,string memory name) public payable{
        owner = msg.sender;
        father_assigned = false;
        mother_assigned = false;
        noofchildren = 0;
        familynumber = number;
        familyname = name;
        familymembersno = 1;
        person memory p1 = person(firstname,lastname);
        Family[0] = p1;
        emit FamilyCreated(owner,firstname,lastname);
        check_Role(role);
    }
    function add_Member(string memory firstname,string memory lastname,string memory role) private {
        owner = msg.sender;
        person memory p2 = person(firstname,lastname);
        Family[familymembersno] = p2;
        familymembersno ++;
        check_Role(role);
        emit familymemberadded(owner,firstname,lastname);

    }
    function check_Role(string memory role) private 
    {
        if(keccak256(abi.encodePacked((role))) == keccak256(abi.encodePacked(("father")))) father_assigned = true;
        else if(keccak256(abi.encodePacked((role))) == keccak256(abi.encodePacked(("mother")))) mother_assigned = true;
        else noofchildren++;
    }
    function getnumberoffamilymembers() public view returns (int256){
        return familymembersno;
    }
    function add_Child(string memory firstname,string memory lastname) public
    {
        add_Member(firstname,lastname,"child");
    }
    function add_mother(string memory firstname,string memory lastname) public{
        if(mother_assigned == false){
        add_Member(firstname,lastname,"mother");
        }
    }
    function add_father(string memory firstname,string memory lastname) public{
        if(father_assigned == false){
        add_Member(firstname,lastname,"father");
        }
    }
    function get_childrencount()public view returns(int256){
        return noofchildren;
    }
    function get_family_number()public view returns(int256){
        return familynumber;
    }
    function get_family_name()public view returns(string memory){
        return familyname;
    }
}
