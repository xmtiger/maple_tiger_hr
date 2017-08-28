/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


"use strict";

angular.module("app").controller("rootController", ["$scope", "$rootScope","departmentService","$location",
    function($scope, $rootScope, departmentService, $location){ 
        
    $scope.alert = { type: 'success', msg: 'Welcome using maple_tiger system'};
       
    $scope.addAlert = function(type, msg) {
        
        $scope.alert.type = type || 'success';
        $scope.alert.msg = msg || 'Wecome using maple_tiger system';
    };
   
    $scope.bindPage = "Welcome"; //This is the inital welcome text.
                    
    $scope.$on("DisplayAllDepartments", function(event, msg){
        console.log("received displayAllDepartments message", msg);
        //use department service to deal with database transactions
        departmentService.fetchAllDepartments($location).then(
            function(data){
                
                $rootScope.$broadcast("zTree_displayAllDepartments", data);
                $rootScope.$broadcast("MainGrid_DisplayInfo", data);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
            }
        );                          
        
    });
    
    //--------------------------------------------------------
    // The following functios are for adding one department
    $scope.$on("addOneDepartment", function(event, msg){
        
        console.log("received addOneDepartment request");
        
        $rootScope.$broadcast("zTree_addOneDepartment");
    });
    
    $scope.$on("zTree_noNodeSelected", function(event, msg){
        //alert user that no tree node is selected.
        $scope.addAlert("danger", "No node selected");
    });
            
    //-----------------------------------------------------------------
    //The message for the communication for update the tree node name
    $scope.$on("nameChangedToBeSent", function(event, msg){
        console.log("rootController received nameChangedToBeSent Message");
        $rootScope.$broadcast("nameChangedToBeSentToTree", msg);
    });
    
    $scope.$on("zTreeNodeNameUpdated", function(event, msg){
        $rootScope.$broadcast("rootMsg_zTreeNodeNameUpdated", msg);
    });
    //-----------------------------------------------------------------    
    
    $scope.$on("zTreeNewNodeCreated_addNewDepartment", function(event, nodeId){
       
        $scope.addAlert("success", "one new department node was created in the tree view");
        
        if(nodeId === ""){
            //console.log("no node selected");            
            $scope.addAlert("danger", "No node selected");
            return;
        }
            
        console.log("$location.path(/department/new)");
        //start departmentForm.jsp to let user input new department information                                
        departmentService.setURI($location.path());
        departmentService.getSaveOrUpdateDepartmentPage($location).then(
            function(data){
                //$scope.$emit("updateBindPageView", response.data);
                $rootScope.$broadcast("DirectiveToUpdateBindPageView", data);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
            }   
        );
               
    });
    
    $scope.$on("RequestCurrentTreeNodeInfo", function(event, data){
        $rootScope.$broadcast("RootCtrl_RequestCurrentTreeNodeInfo", data);
    });
    
    $scope.$on("zTree_SendCurNodeInfo", function(event, data){
        $rootScope.$broadcast("RootCtrl_SendCurNodeInfo", data);
    });
    
    /*$scope.$on("updateBindPageView", function (event, data){
        
        console.log("received message from service to update bindPage");
        
        // send messag to the directive, 
        // Note can not send same message as the one received, otherwise it will be indefinte cycle of receiving and sending
        $rootScope.$broadcast("DirectiveToUpdateBindPageView", data);
        
    });*/
    
    $scope.$on("oneDepartmentCreated", function(event, data){
        
        $rootScope.$broadcast("RootCtrlMsg_OneDepartmentCreated", data);
        
        //update the bindPgae by sending the message to the registered directive
        var str = "The Department was successfully Created";
        $rootScope.$broadcast("DirectiveToUpdateBindPageView", str);
        //$scope.bindPage = $sce.trustAsHtml("The Department was successfully Created");
        
    });
    
}]);

//********************************************************************************************************
// This is for ui.grid to display data in the ui.grid table
angular.module("app").controller('MainGridController', ['$scope', function ($scope) {
        
    $scope.$on("MainGrid_DisplayInfo", function(event, obj){
        
        /*$scope.mainGridOne = {
        enableSorting: true,
        columnDefs: [
          { name:'firstName', field: 'first-name' },
          { name:'1stFriend', field: 'friends[0]' },
          { name:'city', field: 'address.city'},
          { name:'getZip', field: 'getZip()'}
        ],
        data : [      {
                           "first-name": "Cox",
                           "friends": ["friend0"],
                           "address": {street:"301 Dove Ave", city:"Laurel", zip:"39565"},
                           "getZip" : function() {return this.address.zip;}
                       }
                   ]
        };*/
        //it does not work to direct use data from server
        var fieldColumnNames = Object.keys(obj);
        var values = [];
        for(var key in obj) {
            var value = obj[key];
            values.push(value);
        }
                
        $scope.mainGridOne.enableSorting = true;
        $scope.mainGridOne.columnDefs = [];
        for(var i=0; i < fieldColumnNames.length; i++){
            //$scope.gridOption.columnDefs
            var tmpColumnDef = { field : fieldColumnNames[i] };
            $scope.mainGridOne.columnDefs.push(tmpColumnDef);
        }
        
        $scope.mainGridOne.data = values;
        
    });
 
    $scope.mainGridOne = {};    
    
        
    /*$scope.mainGridOne.data = [
        {
            "firstName": "Cox",
            "lastName": "Carney",
            "company": "Enormo",
            "employed": true
        },
        {
            "firstName": "Lorraine",
            "lastName": "Wise",
            "company": "Comveyer",
            "employed": false
        },
        {
            "firstName": "Nancy",
            "lastName": "Waters",
            "company": "Fuelton",
            "employed": false
        }
    ];*/
}]);