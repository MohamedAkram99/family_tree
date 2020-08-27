// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.1;
contract FamilyTree{
    address owner;
    int256 familynumber=0;
    mapping (int256 => Family) Familys;
    int256 counter=0;
    struct person{
        string firstname;
        string lastname;
    }
    struct Family{
        person father;
        person mother;
        person child1;
        person child2;
        int256 familyno;
        string familyname;
    }

    function create_family(string memory ffirstname, string  memory flastname,string memory mfirstname,string memory mlastname,string memory c1firstname, string  memory c1lastname,string memory c2firstname,string memory c2lastname,string memory  Famliyname)public {
    owner = msg.sender;
    if(counter>0)
    {
        familynumber++;
    }
    person memory Father = person(ffirstname,flastname);
    person memory Mother = person(mfirstname,mlastname);
    person memory child1 = person(c1firstname,c1lastname);
    person memory child2 = person(c2firstname,c2lastname);
    Family memory family = Family(Father,Mother,child1,child2,familynumber,Famliyname);
    Familys[familynumber] = family;
    counter++;
    }
    function get_Family_Number()public view returns(int256 familynum){
      return familynumber;
    }
    function print_Father_First_Name(int256 familynum) public view returns(string memory firstname){
      Family memory family = Familys[familynum];
      return(family.father.firstname);
    }
    function print_Father_Last_Name(int256 familynum) public view returns(string memory lastname){
      Family memory family = Familys[familynum];
      return(family.father.lastname);
    }
    function print_Mother_First_Name(int256 familynum) public view returns(string memory firstname){
      Family memory family = Familys[familynum];
      return(family.mother.firstname);
    }
    function print_Mother_Last_Name(int256 familynum) public view returns(string memory lastname){
      Family memory family = Familys[familynum];
      return(family.mother.lastname);
    }
    function print_Child1_First_Name(int256 familynum) public view returns(string memory firstname){
      Family memory family = Familys[familynum];
      return(family.child1.firstname);
    }
    function print_Child1_Last_Name(int256 familynum) public view returns(string memory lastname){
      Family memory family = Familys[familynum];
      return(family.child1.lastname);
    }
    function print_Child2_First_Name(int256 familynum) public view returns(string memory firstname){
      Family memory family = Familys[familynum];
      return(family.child2.firstname);
    }
    function print_Child2_Last_Name(int256 familynum) public view returns(string memory lastname){
      Family memory family = Familys[familynum];
      return(family.child2.lastname);
    }
    function print_Family_Name(int256 familynum) public view returns(string memory firstname){
      Family memory family = Familys[familynum];
      return(family.familyname);
    }
}
