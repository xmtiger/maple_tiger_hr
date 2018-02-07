/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

"use strict";
// The dynamic registration of the controller must be done before the definition of the indicated ng-controller in the html content
angular.module("app").controller("EmployeeFormController", ["$scope","employeeService", "$location",function($scope,employeeService, $location){

    $scope.formTitle = 'EMPLOYEE FORM';
    $scope.button = 'Create';
    $scope.displayDeleteButton = false;
    //create a blank object to hold the form information, and $scope will allow this to pass between controller and view
    $scope.form_data = {};
    $scope.form_data.invalid = true;

    $scope.parentNodeUID = "";  //unique id for getNodeByParam(key, value, parent) method of the zTree
    $scope.curNodeUID = "";

    $scope.parentNodeId = -1;
    $scope.parentNodeType = "";
    $scope.curNodeId = -1;
    $scope.curNodeType = "";

    $scope.submit = 0;  //0 means un-submitted
    $scope.delete = 0;  //0 means un-deleted

    //-------------------------------------------------------------------------
    //$scope.page_url = "tab_0/employeeForm";		
    $scope.page_url = employeeService.getCreationEditPageURI();
    $scope.employee = {};
    $scope.employee_original_data = {};

    function keepOriginalEmployeeData(newData){
        $scope.employee_original_data.firstName = newData.firstName;
        $scope.employee_original_data.middleName = newData.middleName;
        $scope.employee_original_data.lastName = newData.lastName;

        $scope.employee_original_data.home_address = newData.home_address;

        $scope.employee_original_data.birth_date = newData.birth_date;

        $scope.employee_original_data.gender = newData.gender;
    }

    $scope.$on("tabFinishedLoading", function(event, tab_info){
        console.log("EmployeeFormController received message of tabFinishedLoading");
        if(typeof tab_info === 'object' && tab_info.hasOwnProperty('url')){
            if(tab_info.url === $scope.page_url && tab_info.hasOwnProperty('node')){
                if(tab_info.node.id > 0){
                    //proceed with update or delete 
                    //proceed with infilling data
                    employeeService.findEmployeeById($scope, $location, tab_info.node).then(
                        function(data){
                            if(data.id >0){
                               $scope.employee = data; 

                               keepOriginalEmployeeData(data);

                               $scope.$emit("EmployeePageFormToBeFilled");                                         
                            }
                        },function(errResponse){
                            console.error("Error while delete one employee");
                        } 
                    );

                }else{
                    //proceed with creation form
                    $scope.formTitle = 'EMPLOYEE CREATION FORM';
                }

            }
        }
    });          

    $scope.$on("EmployeePageFormToBeFilled", function(event, obj){

        $scope.formTitle = 'EMPLOYEE UPDATE FORM';
        $scope.button = 'Update';     
        $scope.displayDeleteButton = true;                            

    });

    //-----------------------------------------------
    $scope.today = function() {
            //$scope.dt = new Date();
            $scope.employee.beginTime = new Date();
    };

    $scope.today();

    $scope.clear = function() {
            //$scope.dt = null;
            $scope.employee.beginTime = null;
    };

    $scope.inlineOptions = {
            customClass: getDayClass,
            minDate: new Date(),
            showWeeks: true
    };

    $scope.dateOptions = {
            dateDisabled: disabled,
            formatYear: 'yy',
            maxDate: new Date(2020, 5, 22),
            minDate: new Date(),
            startingDay: 1
    };

    // Disable weekend selection
    function disabled(data) {
            var date = data.date,
            mode = data.mode;
            return mode === 'day' && (date.getDay() === 0 || date.getDay() === 6);
    }

    $scope.toggleMin = function() {
            $scope.inlineOptions.minDate = $scope.inlineOptions.minDate ? null : new Date();
            $scope.dateOptions.minDate = $scope.inlineOptions.minDate;
    };

    $scope.toggleMin();

    $scope.open2 = function() {
            $scope.popup2.opened = true;
    };

    $scope.setDate = function(year, month, day) {
            $scope.employee.beginTime = new Date(year, month, day);
    };

    $scope.formats = ['yyyy-MM-dd','dd-MM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
    $scope.format = $scope.formats[0];
    $scope.altInputFormats = ['yyyy/M!/d!'];				

    $scope.popup2 = {
            opened: false
    };

    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    var afterTomorrow = new Date();
    afterTomorrow.setDate(tomorrow.getDate() + 1);

    $scope.events = [
            {
              date: tomorrow,
              status: 'full'
            },
            {
              date: afterTomorrow,
              status: 'partially'
            }
    ];

    function getDayClass(data) {
            var date = data.date,
            mode = data.mode;
            if (mode === 'day') {
                    var dayToCheck = new Date(date).setHours(0,0,0,0);

                    for (var i = 0; i < $scope.events.length; i++) {
                            var currentDay = new Date($scope.events[i].date).setHours(0,0,0,0);

                            if (dayToCheck === currentDay) {
                                    return $scope.events[i].status;
                            }
                    }		
            }

            return '';
    }

    //----------------------------------------------------------------------------------

    function clearContent(){
        $scope.formData.name = "";
        $scope.parentNodeId = -1;
        $scope.parentNodeType = "";
        $scope.curNodeId = -1;
        $scope.curNodeType = "";
    };                

    //here the function validateDepartmentForm is jquery function, which is not recommended.
    //but this page is end page, so it is flexible to use jquery--------------------------------------
    function validateEmployeeForm($scope){

        var valid = true;
        if($scope.formData.first_name.$invalid === true)
            valid = false;

        if($scope.formData.last_name.$invalid === true)
            valid = false;

        if($scope.formData.address.$invalid === true)
            valid = false;

        console.log($scope.formData);
        if($scope.formData.birth_date.$invalid === true)
            valid = false;

        if (valid) {

                return true;
        }else{
                alert('The form is invalid, please verfiy the form and resubmit it');
                return false;
        }       

    };

    function getJsonDataFromEmployeeForm(){

        return $scope.employee;
    };

    //-----------------------------------------------------------------------------------------
    // This is to get node information from the zTree
    $scope.employeeFormSubmit = function(){

        if(validateEmployeeForm($scope) === true){
            //send request to tree for currrent node and the father node information
            var message = {type:"createOrUpdateEmployee", data:{}};
            $scope.$emit("RequestCurrentTreeNodeInfo", message);

        } else{ 
            //The validation is not passed
            console.log("client validation is not passed");                            
        }           

    };
    // This function is to send form data to the server for update or save a new department
    $scope.$on("RootCtrl_SendCurNodeInfo", function(event, msg){                   

        if(typeof msg === 'object' && msg.hasOwnProperty('type') && msg.hasOwnProperty('data')){
            var nodeInfo = msg.obj;

            if(msg.type === 'createOrUpdateEmployee'){                                
                saveOrUpdateEmployee(nodeInfo);
            }else if(msg.type === 'deleteEmployee'){
                console.log("delete employee");
                deleteEmployee(nodeInfo);
                $scope.$emit("removeEmployeeNode");
            }
        }               

    });

    function deleteEmployee(nodeInfo){

        if($scope.delete !== 0)
            return;

        $scope.delete++;    //only allow delete once

        employeeService.deleteEmployeeById($scope, $location, nodeInfo).then(
            function(data){
                if(data.hasOwnProperty('validated')){
                    if(data.validated === true){
                        var str = "<h4 style='color:green'>The deletion was successfully done!</h4> <hr>";

                        $scope.$emit("DirectiveToUpdateBindPage", str);
                        clearContent();
                    }else{
                        console.log("Get Error Messages from the server");
                        console.log(data);
                        var str_error = "";
                        $.each(data.errorMessages,function(key,value){
                            str_error = str_error + value + "; ";                                            
                        });
                        var message = { type: 'warning', msg: str_error};

                        $scope.$emit("Alert_Msg", message);
                    }
                }
            },function(errResponse){
                console.error("Error while delete one employee");
            } 
        );
    };

    //
    function saveOrUpdateEmployee(nodeInfo){
        //perform the database actions here.
        console.log("client validation is passed, then perform database request");

        if($scope.submit !== 0) //submit is only allowed once.
            return;

        $scope.submit++;

        var jsonData = getJsonDataFromEmployeeForm();                           
        console.log(jsonData);
        employeeService.createOrUpateEmployee($scope, $location, jsonData, nodeInfo).then(
            function(data){
                if(data.hasOwnProperty('validated')){
                    if(data.validated === true){

                        var str = "<h4 style='color:green'>The Process was successfully done!</h4> <hr>";

                        if($scope.button === 'Update'){
                            str = "<h4 style='color:green'>The Employee was successfully Updated!</h4> <hr>";

                        }else if($scope.button === 'Create'){

                            str = "<h4 style='color:green'>The Employee was successfully Created!</h4> <hr>";

                        }       

                        $scope.$emit("DirectiveToUpdateBindPage", str);
                        clearContent();

                    }else{
                        console.log("Get Error Messages from the server");
                        console.log(data);
                        //Set error messages
                        $.each(data.errorMessages,function(key,value){
                            $('input[name='+key+']').after('<span class="error">'+value+'</span>');
                        });

                    }
                }                          
            },
            function(errResponse){
                console.error("Error while create one employee");
            }  
        );
    };                    

    //-----------------------------------------------------------------
    //functions handling name changes
    $scope.nameChange = function(){
                            //$scope.currentTab.invalid = this.formData.$invalid;
        //console.log($scope.employee.first_name);                    
        $scope.$emit("nameChangedToBeSent", $scope.employee.firstName + " " + $scope.employee.middleName + " " + $scope.employee.lastName);
        formChanged($scope, this);
        //reset submit as zero
        if($scope.submit > 0){
            $scope.submit = 0;
            //reset the error messages                            
            //$("#employee_first_name").nextAll().remove();
        };

    };

    $scope.addressChange = function(){
                            //$scope.currentTab.invalid = this.formData.$invalid;
        formChanged($scope, this);
    };

    $scope.birthDateChange = function(){

        formChanged($scope, this);
    };

    function formChanged($scope, self){
        $scope.currentTab.invalid = self.formData.$invalid;

        if($scope.employee.hasOwnProperty('firstName') && $scope.employee.firstName !== ''
                && $scope.employee.hasOwnProperty('lastName') && $scope.employee.lastName !== ''){
                $scope.currentTab.invalid = false;

        }else{
                $scope.currentTab.invalid = true;
        }

        if($scope.employee.hasOwnProperty('home_address') && $scope.employee.home_address !== ''){
                $scope.currentTab.invalid = false;

        }else{
                $scope.currentTab.invalid = true;
        }

        $scope.$emit("employeeForm_changed");
    };

    //this function is not requried.
    $scope.$on("rootMsg_zTreeNodeNameUpdated", function(event, msg){

    });               

    //--------------------------------------------------------------------------
    $scope.employeeFormDelete = function(){
        var rs = confirm("The deletion is irrevocable. Please make sure you really want delete the item");
        if(rs === true){
            //delete the item
            var message = {type:"deleteEmployee", data:{}};
            $scope.$emit("RequestCurrentTreeNodeInfo", message);
        }
    };

    $scope.employeeFormCancel = function(){
        //send the following message to root controller
        if($scope.employee.hasOwnProperty('id')){
            console.log('$scope has the property of id');
            if($scope.employee.id >= 0){
                console.log('$scope has the property of id which is bigger than 1');
                console.log($scope.employee_original_data);
                $scope.$emit('employeeForm_edit_cancel', $scope.employee_original_data);
            }
        }else{
            console.log('$scope does not have the property of id');
            $scope.$emit('employeeForm_creation_cancel');
        }
        //$scope.$emit("employeeForm_cancel");
    };

}]);