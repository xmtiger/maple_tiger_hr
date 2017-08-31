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
   
    $scope.bindPage = ""; //This is the inital welcome text.
                    
    $scope.$on("DisplayAllDepartments", function(event, msg){
        console.log("received displayAllDepartments message", msg);
        //use department service to deal with database transactions
        departmentService.fetchAllDepartments($location).then(
            function(data){
                
                $rootScope.$broadcast("zTree_displayAllDepartments", data);
                $rootScope.$broadcast("MainGridOne_DisplayInfo", {type: 'Department', msg: data});
                $rootScope.$broadcast("MainGridTwo_DisplayInfo", {type: 'Employee', msg: data});
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
        
    $scope.showMainGridOne = false;   
    $scope.showMainGridTwo = false;  
    
    $scope.mainGridOne = {};  
    $scope.mainGridTwo = {}; 
        
    $scope.$on("MainGridOne_DisplayInfo", function(event, obj_in){
        
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
        var type = obj_in.type;
        var obj = obj_in.msg;
        
        if(type === 'Department'){
            displayDepartments(obj);
        }
        
    });
    
    $scope.$on("MainGridTwo_DisplayInfo", function(event, obj_in){
        var type = obj_in.type;
        var obj = obj_in.msg;
        
        if(type === 'Employee'){
            displayEmployees(obj);
        }
    });
    
    function displayDepartments(obj){
        if(!obj.hasOwnProperty('data')){                
            return;
        }
        //it does not work to direct use data from server
        var keysFilter = ['name', 'begin_time', 'address'];
        //var fieldColumnNames = Object.keys(obj);
        var values = [];
        
        defineGridColumns(keysFilter, $scope.mainGridOne);
        
        gridDataFilter(keysFilter, obj, values); 
                        
        $scope.mainGridOne.data = values;
        
        $scope.showMainGridOne = true;        
    }
    
    function displayEmployees(obj){
        if(!obj.hasOwnProperty('data')){                
            return;
        }
        
        var keysFilter = ['firstName', 'lastName', 'home_address', 'birth_date', 'department'];
        
        var values = [];
        defineGridColumns(keysFilter, $scope.mainGridTwo);
        
        gridDataFilter_ForEmployee(keysFilter, obj, values); 
        
        $scope.mainGridTwo.data = values;
        
        $scope.showMainGridTwo = true;       
    }
    
    function defineGridColumns(keysFilter, grid){
        if(typeof grid !== 'object')
            return;
        
        if(Array.isArray(keysFilter) !== true)
            return;
        
        grid.enableSorting = true;
        grid.columnDefs = [];
        for(var i=0; i < keysFilter.length; i++){
            //$scope.gridOption.columnDefs
            var tmpColumnDef = { field : keysFilter[i] };
            grid.columnDefs.push(tmpColumnDef);
        }      
    }
    
    // this function is to get information from "data" property of the object   
    function gridDataFilter(keysFilter, obj, values){
        
        if(typeof obj !== 'object')
            return;
                
        //only search infomation in the object.data
        if(obj.hasOwnProperty('data') && typeof obj.data === 'object'){
            if(!Array.isArray(keysFilter))
                return;
                        
            if(typeof values !== 'object' && Array.isArray(values) !== true)
                return;

            var tmpVar = {};
            var find = false;

            for(var key in obj.data) {      

                for(var i =0; i < keysFilter.length; i++){
                    if(key === keysFilter[i]){               
                        //dynamically add both property and value to the object, tmpVar.
                        tmpVar[key] = obj.data[key];                     
                        find = true;
                        //break;
                    }
                }              
            }

            if(find){
                values.push(tmpVar);
            }
        }        
                        
        if(obj.hasOwnProperty('children')){
            for(var j=0; j < obj.children.length; j++){
                gridDataFilter(keysFilter, obj.children[j], values);
            }
        }
    };
        
    // this function is to get information from "data" property of the object   
    function gridDataFilter_ForEmployee(keysFilter, obj, values){
        
        if(typeof obj !== 'object')
            return;
                
        //only search infomation in the object.data
        if(obj.hasOwnProperty('data') && typeof obj.data === 'object'){
            if(!Array.isArray(keysFilter))
                return;
                        
            if(typeof values !== 'object' && Array.isArray(values) !== true)
                return;

            var tmpVar = {};
            var find = false;
            
            var department = obj.data;
            if(department.hasOwnProperty('employees')){
                for(var i = 0; i < department.employees.length; i++){
                    var employee = department.employees[i];
                                
                    for(var key in employee){
                        
                        for(var j=0; j < keysFilter.length; j++){
                            if(key === keysFilter[j]){
                                
                                if(key === 'birth_date'){
                                    // The conversion of the date
                                    var date = new Date(parseInt(employee[key]));
                                    var date_str = date.getUTCFullYear() + "-" + date.getUTCMonth() + "-" + date.getUTCDate();
                                    
                                    tmpVar[key] = date_str;
                                }else{
                                    tmpVar[key] = employee[key]; 
                                }                                                                                
                                
                            }
                        }
                    }
                    
                    tmpVar['department'] = department.name;
                    find = true;
                }
            }

            if(find){
                values.push(tmpVar);
            }
        }        
                        
        if(obj.hasOwnProperty('children')){
            for(var j=0; j < obj.children.length; j++){
                gridDataFilter_ForEmployee(keysFilter, obj.children[j], values);
            }
        }
    };
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

//************************************************************************************
//D3 controller
angular.module("app").controller('D3PieChartController', ['$scope', function ($scope) {

        $scope.options = {
            chart: {
                type: 'pieChart',
                height: 500,
                x: function(d){return d.key;},
                y: function(d){return d.y;},
                showLabels: true,
                duration: 500,
                labelThreshold: 0.01,
                labelSunbeamLayout: true,
                legend: {
                    margin: {
                        top: 5,
                        right: 35,
                        bottom: 5,
                        left: 0
                    }
                }
            }
        };

        $scope.data = [
            {
                key: "One",
                y: 5
            },
            {
                key: "Two",
                y: 2
            },
            {
                key: "Three",
                y: 9
            },
            {
                key: "Four",
                y: 7
            },
            {
                key: "Five",
                y: 4
            },
            {
                key: "Six",
                y: 3
            },
            {
                key: "Seven",
                y: .5
            }
        ];
    }]);