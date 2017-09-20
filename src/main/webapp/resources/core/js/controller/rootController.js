/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


"use strict";

angular.module("app").controller("rootController", ["$scope", "$rootScope","departmentService","employeeService","$location",
    function($scope, $rootScope, departmentService, employeeService, $location){ 
     
    //-----------------------------------------------------------------------------
    //tabs
    $scope.tabs = [{
            index: 0,
            title: 'tab_0',
            url: 'tab_0',
            disabled: false,
            invalid: true
            }, {
            index: 1,
            title: 'tab_1',
            url: 'tab_1',
            disabled : false,
            invalid: true
            }, {
            index: 2,
            title: 'tab_2',
            url: 'tab_2',
            disabled : false,
            invalid: true
        }
    ];				

    $scope.currentTab = $scope.tabs[0];
    
    $scope.employeeFormURL = 'tab_0/employeeForm';
    
    $scope.tabFinishLoading = function(){
        console.log("tab finished loading");
        //emit message to child controller to infill the data
        $rootScope.$broadcast("tabFinishedLoading", $scope.currentTab);
    };
                
    //The following $scope.items is for the dropdown button, which gives dynamically selection choice.
    $scope.items = [
        {id: '', name:'The first choice!'}        
    ];
    
    //The following 'alert' is to show all the messages including warnings or success messages.
    $scope.alert = { type: 'success', msg: 'Welcome using maple_tiger system'};
       
    $scope.addAlert = function(type, msg) {        
        $scope.alert.type = type || 'success';
        $scope.alert.msg = msg || 'Wecome using maple_tiger system';
    };
    
    $scope.closeAlert = function(){
        $scope.alert = {};
    };
   
    $scope.bindPage = ""; //This is the inital welcome text.
    //---------------------------------------------------------------------------------
    //alert to receive message
    $scope.$on("Alert_Msg", function(event, message){
        if(typeof message === 'object' && message.hasOwnProperty('type') && message.hasOwnProperty('msg')){
            $scope.addAlert(message.type, message.msg);
        }
    });
    
    //$scope.addDepartmentInProcess = false;  //to avoid multiple click add button  
    //------------------------------------------------------------------------
    //This function is to add either 'Department' or 'Employee' or others
    $scope.setChoiceIndex_AddButton = function($index){        
        //console.log($scope.items[$index].id);
        var choice = $scope.items[$index].id;
        if(choice === 'Department'){
            $scope.$emit("addOneDepartment");
        }else if(choice === 'Employee'){
            
        }
    };
    
    /*$scope.$on("RefuseAddingDepartment", function(event, msg){
        $scope.addAlert("warning", "Only Allow One Creation Prcess at One Time!");
    });*/
    
    //---------------------------------------------------------------------
    $scope.edit_button = function(){
        $scope.$emit("edit_item");
    };
    
    $scope.$on("edit_item", function(event, msg){
        
        $rootScope.$broadcast("zTree_editItem");
    });
    
    $scope.$on("ZTreeNodeSelected_ToBeEdited", function(event, node_in){
        //send request to server to get the update html page
        if(typeof node_in === 'object' && node_in.hasOwnProperty('dataType')){
            if(node_in.dataType === 'Department'){
                departmentService.getSaveOrUpdateDepartmentPage($location).then(
                    function(data){
                        var message = {obj: node_in, pageContent: data };
                        $rootScope.$broadcast("DirectiveToUpdateBindPage_RootMsg", message);

                    },
                    function(errResponse){
                        console.error("Error while fetching department form page");
                    }   
                );
            }else if(node_in.dataType === 'Employee'){
                //instead of requesting page from server, use ng-include to set page url
                $scope.tabs[0].title = 'EmployeeForm';
                $scope.tabs[0].url = $scope.employeeFormURL;
                
                $scope.currentTab.node = node_in;
                
                if($scope.currentTab.url === $scope.employeeFormURL){
                    //send message directly
                    $rootScope.$broadcast("tabFinishedLoading", $scope.currentTab);
                }else{
                    //add page first, and then send messag in function after loading the page
                    $scope.currentTab = $scope.tabs[0];
                }
                // this is additaionl information
                
                //get employee data from server and infill into the employeeForm page
                
                /*employeeService.getSaveOrUpdateEmployeePage($location).then(
                    function(data){
                        var message = {obj: node_in, pageContent: data };
                        $rootScope.$broadcast("DirectiveToUpdateBindPage_RootMsg", message);
                    },
                    function(errResponse){
                        console.error("Error while fetching employee form page");
                    }
                );*/
            }
        }        
        
    });
    
    $scope.$on("DirectiveToUpdateBindPage", function(event, msg){
        
        $rootScope.$broadcast("DirectiveToUpdateBindPage_RootMsg", msg);
                
    });
    
    $scope.$on("DirectveFinishedTheUpdate", function(event, msg){
        if(typeof msg === 'object' && msg.hasOwnProperty('obj')){
            if(msg.obj !== null){
                //fill the form with obj
                if(msg.obj.dataType === 'Department'){
                    $rootScope.$broadcast("DepartmentPageFormToBeFilled", msg.obj);
                }else if(msg.obj.dataType === 'Employee'){
                    $rootScope.$broadcast("EmployeePageFormToBeFilled", msg.obj);
                }
            }
        }
    });
    //----------------------------------------------------------------------------------
    $scope.delete_button = function(){
        $scope.$emit("delete_item");
    };
    
    $scope.$on("delete_item", function(event, msg){
        
        $rootScope.$broadcast("zTree_deleteItem");
    });
    
    
    //---------------------------------------------------------------------
                    
    $scope.$on("DisplayAllDepartments", function(event, msg){
        console.log("received displayAllDepartments message", msg);
        //use department service to deal with database transactions
        departmentService.fetchAllDepartments($location).then(
            function(data){
                //dynamically add dropdown menu for the add button at the left column underneath of the tree view.
                $scope.items[0] = { id: 'Department', name:'Add Department'};
                $scope.items[1] = { id: 'Employee', name:'Add Employee'};
                
                $rootScope.$broadcast("zTree_displayAllDepartments", data);
                $rootScope.$broadcast("MainGridOne_DisplayInfo", {type: 'Department', msg: data});
                $rootScope.$broadcast("MainGridTwo_DisplayInfo", {type: 'Employee', msg: data});
                $rootScope.$broadcast("C3PiePlotChart_DisplayInfo", {type: 'Employee', msg: data});
                $rootScope.$broadcast("C3BarPlotChart_DisplayInfo", {type: 'Employee', msg: data});
            },
            function(errResponse){
                console.error("Error while fetching all departments");
            }
        );                          
        
    });
    
    //--------------------------------------------------------
    // The following functions are for adding one department
    $scope.$on("addOneDepartment", function(event, msg){
        
        console.log("received addOneDepartment request");
        $rootScope.$broadcast("zTree_addOneDepartment");
        
    });
    
    /*$scope.$on("zTree_noNodeSelected", function(event, msg){
        //alert user that no tree node is selected.
        $scope.addAlert("danger", "No node selected");
    });*/
            
    //-----------------------------------------------------------------
    //The message for the communication for update the tree node name
    $scope.$on("nameChangedToBeSent", function(event, msg){
        console.log("rootController received nameChangedToBeSent Message");
        $rootScope.$broadcast("nameChangedToBeSentToTree", msg);
    });
    
    $scope.$on("zTreeNodeNameUpdated", function(event, msg){
        $rootScope.$broadcast("rootMsg_zTreeNodeNameUpdated", msg);
    });
    
    $scope.$on("departmentForm_changed", function(event, msg){
        $rootScope.$broadcast("departmentForm_changed_sent");
    });
    
    //-----------------------------------------------------------------    
    
    $scope.$on("zTreeNewNodeCreated_addNewDepartment", function(event, nodeId){
       
        $scope.addAlert("success", "one new department node was created in the tree view");
        
        if(nodeId === ""){
            //console.log("no node selected");            
            $scope.addAlert("warning", "No node is selected, please select one node!");
            return;
        }
            
        console.log("$location.path(/department/new)");
        //start departmentForm.jsp to let user input new department information                                
        //departmentService.setURI($location.path());
        departmentService.getSaveOrUpdateDepartmentPage($location).then(
            function(data){
                //$scope.$emit("updateBindPageView", response.data);
                $rootScope.$broadcast("DirectiveToUpdateBindPage_RootMsg", data);
                
            },
            function(errResponse){
                console.error("Error while fetching all departments");
            }   
        );
               
    });
    
    $scope.$on("RequestCurrentTreeNodeInfo", function(event, msg){
        $rootScope.$broadcast("RootCtrl_RequestCurrentTreeNodeInfo", msg);
    });
    
    $scope.$on("zTree_SendCurNodeInfo", function(event, msg){
        $rootScope.$broadcast("RootCtrl_SendCurNodeInfo", msg);
    });
    
    /*$scope.$on("updateBindPageView", function (event, data){
        
        console.log("received message from service to update bindPage");
        
        // send messag to the directive, 
        // Note can not send same message as the one received, otherwise it will be indefinte cycle of receiving and sending
        $rootScope.$broadcast("DirectiveToUpdateBindPageView", data);
        
    });*/
    
    /*$scope.$on("oneDepartmentCreated", function(event, data){
        
        $rootScope.$broadcast("RootCtrlMsg_OneDepartmentCreated", data);
        
        //update the bindPgae by sending the message to the registered directive
        var str = "<h4 style='color:green'>The Department was successfully Created</h4> <hr>";
        $rootScope.$broadcast("DirectiveToUpdateBindPageView", str);
        //$scope.bindPage = $sce.trustAsHtml("The Department was successfully Created");
        
    });*/
    
}]);

//********************************************************************************************************
// This is for ui.grid to display data in the ui.grid table
angular.module("app").controller('MainGridController', ['$scope', 'UtilService', function ($scope, UtilService) {
        
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
        if(typeof obj_in !== 'object')
            return;
        
        if(!obj_in.hasOwnProperty('type'))
            return;
        
        if(!obj_in.hasOwnProperty('msg'))
            return;
        
        var type = obj_in.type;
        var obj = obj_in.msg;
        
        if(type === 'Department'){
            displayDepartments(obj);
            $scope.showMainGridOne = true;
        }
        
    });
    
    $scope.$on("MainGridTwo_DisplayInfo", function(event, obj_in){
        if(typeof obj_in !== 'object')
            return;
        
        if(!obj_in.hasOwnProperty('type'))
            return;
        
        if(!obj_in.hasOwnProperty('msg'))
            return;
        
        var type = obj_in.type;
        var obj = obj_in.msg;
        
        if(type === 'Employee'){
            displayEmployees(obj);
            $scope.showMainGridTwo = true;     
        }
    });
    
    function displayDepartments(obj){
        if(!obj.hasOwnProperty('data')){                
            return;
        }
        
        if(UtilService === null)
            return;
        
        //it does not work to direct use data from server
        var keysFilter = ['name', 'begin_time', 'address'];
        //var fieldColumnNames = Object.keys(obj);
        var values = [];
        
        UtilService.defineGridColumns(keysFilter, $scope.mainGridOne);
        
        UtilService.gridDataFilter(keysFilter, obj, values); 
                        
        $scope.mainGridOne.data = values;
        
                
    }
    
    function displayEmployees(obj){
        if(!obj.hasOwnProperty('data')){                
            return;
        }
        
        if(UtilService === null)
            return;
        
        var keysFilter = ['firstName', 'lastName', 'home_address', 'birth_date', 'department'];
        
        var values = [];
        UtilService.defineGridColumns(keysFilter, $scope.mainGridTwo);
        
        UtilService.gridDataFilter_ForEmployee(keysFilter, obj, values); 
        
        $scope.mainGridTwo.data = values;
        
          
    }
    
    /*function defineGridColumns(keysFilter, grid){
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
                        
                        //note: the department date type is @Temporal(TemporalType.DATE), and no need for conversion
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
                                //note: the employee birthday is @Temporal(TemporalType.TIMESTAMP)
                                if(key === 'birth_date'){
                                    // The conversion of the date
                                    var date = new Date(parseInt(employee[key]));
                                    var month = date.getUTCMonth();
                                    var day = date.getUTCDate();
                                    if(month < 10)
                                        month = '0' + month;
                                    if(day < 10)
                                        day = '0' + day;
                                    
                                    var date_str = date.getUTCFullYear() + "-" + month + "-" + day;
                                    
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
    };    */    
    
}]);

//*******************************************************************************************************************************
//C3.js based on D3.js

angular.module("app").controller('C3PieChartController', ['$scope','UtilService', function ($scope, UtilService) {

    $scope.data = [["data1", 70], ["data2", 30], ["data3", 100]];
        
    $scope.showPieChat= false;
    
    $scope.chart = null;
     
    $scope.showGraph = function() {
        $scope.chart = c3.generate({
            bindto: '#C3PieChart',
            
            size: { width:300, height : 300},
            
            data: {
              columns: $scope.data  ,
              type : 'pie'
            },

            pie: {
                    label: {
                        format: function (value, ratio, id) {
                            return d3.format('')(value);
                    }
                }
            }        
            
        });
            
    };
    
    // This is to show how many employees the each department has. 
    $scope.$on("C3PiePlotChart_DisplayInfo", function(event, obj_in){
       if(typeof obj_in !== 'object')
            return;
        
        if(!obj_in.hasOwnProperty('type'))
            return;
        
        if(!obj_in.hasOwnProperty('msg'))
            return;
        
        var type = obj_in.type;
        var obj = obj_in.msg;
        
        var keysFilter = ['firstName', 'lastName', 'department'];
        var values = [];                
        UtilService.gridDataFilter_ForEmployee(keysFilter, obj, values);
        
        var data = [];
        UtilService.getC3Data_Department2Emplyee(keysFilter,values,data);
        //console.log(data);
        $scope.data = data;
        $scope.showPieChat = true;
        $scope.showGraph();
    });
}]);

angular.module("app").controller('C3BarChartController', ['$scope','UtilService', function ($scope, UtilService) {

    $scope.data = [["data1", 70], ["data2", 30], ["data3", 100]];
        
    $scope.showBarChat= false;
    
    $scope.chart = null;
     
    $scope.showGraph = function() {
        $scope.chart = c3.generate({
            bindto: '#C3BarChart',
            
            size: { width: 300, height : 300},
            
            data: {
              columns: $scope.data  ,
              type : 'bar'
            },
            
            /*axis: {
                
                y: {
                    show: true,
                    min : 1
                    
                    //padding: 0              
                }
            },*/
            
            bar: {
                zerobased: true
            }
            

        });
            
    };
    
    // This is to show how many employees the each department has. 
    $scope.$on("C3BarPlotChart_DisplayInfo", function(event, obj_in){
       if(typeof obj_in !== 'object')
            return;
        
        if(!obj_in.hasOwnProperty('type'))
            return;
        
        if(!obj_in.hasOwnProperty('msg'))
            return;
        
        var type = obj_in.type;
        var obj = obj_in.msg;
        
        var keysFilter = ['firstName', 'lastName', 'department'];
        
        var values = [];
                
        UtilService.gridDataFilter_ForEmployee(keysFilter, obj, values); 
        
        var data = [];
        UtilService.getC3Data_Department2Emplyee(keysFilter,values,data);
        //console.log(data);
        $scope.data = data;
        
        $scope.showGraph();
        
        $scope.showBarChat = true;
    });    
    
}]);

//************************************************************************************
//D3 controller - angular-nvd3 with nvd3
/*angular.module("app").controller('D3PieChartController', ['$scope','UtilService', function ($scope, UtilService) {

    $scope.$on("D3PieChart_DisplayInfo", function(event, obj_in){        
        
        var type = obj_in.type;
        var obj = obj_in.msg;
        
        if(type === 'Department'){
            
        }
        
    });
    
    $scope.options = {
        chart: {
            type: 'pieChart',
            height: 300,
            x: function(d){return d.key;},
            y: function(d){return d.y;},
            showLabels: true,
            duration: 500,
            labelThreshold: 0.01,
            labelSunbeamLayout: true,
            legend: {
                rightAlign: false,
                margin: {
                    top: 5,
                    right: 5,
                    bottom: 5,
                    left: 5
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
}]);*/