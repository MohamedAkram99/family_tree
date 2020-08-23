App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    return await App.initWeb3();
  },

  initWeb3: async function() {
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        // Request account access
        await window.ethereum.enable();
      } catch (error) {
        // User denied account access...
        console.error("User denied account access")
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    // If no injected web3 instance is detected, fall back to Ganache
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);
    return App.initContract();
  },

   initContract: function() {
    $.getJSON('FamilyTree.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with @truffle/contract
      var FamilyTreeArtifact = data;
      App.contracts.FamilyTree = TruffleContract(FamilyTreeArtifact);
    
      // Set the provider for our contract
      App.contracts.FamilyTree.setProvider(App.web3Provider);
    
      // Use our contract to retrieve and mark the adopted pets
      return App.renderGUI();
    });
    return App.bindEvents();
  },
  bindEvents: function(){
    var familyInstance;
    $(document).ready(function(){
      $("#AddFamily").click(function(){
        App.contracts.FamilyTree.deployed().then(function(instance){
          familyInstance = instance;
          familyInstance.create_family(document.getElementById("ffname").value,document.getElementById("flname").value,document.getElementById("mfname").value,document.getElementById("mlname").value,document.getElementById("c1fname").value,document.getElementById("c1lname").value,document.getElementById("c2fname").value,document.getElementById("c2lname").value,document.getElementById("familyname").value);
        });
        
        });
    });
  },
  renderGUI: function(){
    var familyInstance;
    $(document).ready(function(){
      $("#ShowFamilyNumber").click(function(){
        App.contracts.FamilyTree.deployed().then(function(instance){
          familyInstance = instance;
          return instance.get_Family_Number();
          }).then(function(val){
            val=val.toNumber();
            document.getElementById("Familynum").innerHTML=val;
          });
      });
      $("#ShowFamily").click(function(){
        var tbl = document.getElementById("myTable");
        var row = tbl.insertRow();
        App.contracts.FamilyTree.deployed().then(function(instance){
          familyInstance=instance;
         return instance.print_Family_Name(document.getElementById("familynumber").value);
        }).then(function(val){
          var cell1 = row.insertCell();
          cell1.innerHTML=val;
          })
        App.contracts.FamilyTree.deployed().then(function(instance){
        familyInstance=instance;
       return instance.print_Father_First_Name(document.getElementById("familynumber").value);
      }).then(function(val){
        var cell2 = row.insertCell();
        cell2.innerHTML=val;
        })
        App.contracts.FamilyTree.deployed().then(function(instance){
          familyInstance=instance;
         return instance.print_Mother_First_Name(document.getElementById("familynumber").value);
        }).then(function(val){
          var cell3 = row.insertCell();
          cell3.innerHTML=val;
          })
          App.contracts.FamilyTree.deployed().then(function(instance){
            familyInstance=instance;
           return instance.print_Child1_First_Name(document.getElementById("familynumber").value);
          }).then(function(val){
            var cell4 = row.insertCell();
            cell4.innerHTML=val;
            })
            App.contracts.FamilyTree.deployed().then(function(instance){
              familyInstance=instance;
             return instance.print_Child2_First_Name(document.getElementById("familynumber").value);
            }).then(function(val){
              var cell5 = row.insertCell();
              cell5.innerHTML=val;
              })
              var cell6= row.insertcell();
              cell6.innerHTML=document.getElementById("familynumber").value;
      });
        });
      },
    },
  $(function() {
    $(window).load(function() {
      App.init();
    });
  });