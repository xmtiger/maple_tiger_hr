<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <c:set var="context" value="${pageContext.request.contextPath}"/>
        
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrapDatePicker/css/bootstrap-datepicker.min.css"/>
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrapDatePicker/css/bootstrap-datepicker3.min.css"/>        
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrapValidator/css/bootstrapValidator.min.css" />
        
        <script src="${context}/resources/vendors/bootstrapDatePicker/js/bootstrap-datepicker.min.js"></script>   
        <script src= "${context}/resources/vendors/bootstrapValidator/js/bootstrapValidator.min.js"> </script> 
        
        <!--script src= "${context}/resources/core/js/controller/employee_controller.js"> </script--> 
        
        <title>Employee Form</title>
        
        <script type="text/javascript">
            $(document).ready(function() {      
                
                $("#datePicker").datepicker({
                    autoclose: false,
                    format: 'yyyy-mm-dd'
                    
                }).on('changeDate', function(e) {
                    // Revalidate the date field
                    //alert("datepicker.on");
                    $('#employee_form').bootstrapValidator('revalidateField', 'begin_time');
                });
                    
                $('#employee_form').bootstrapValidator({
                    // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
                    framework: "bootstrap",
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        name: {
                            row: '.col-xs-4',
                            validators: {
                                    stringLength: {
                                    min: 2,
                                    message: 'The minimum length is 2'
                                },
                                    notEmpty: {
                                    message: 'Please input a name'
                                }
                            }
                        },
                        address: {
                            validators: {
                                 stringLength: {
                                    min: 2,
                                    message: 'The minimum length is 2'
                                },
                                notEmpty: {
                                    message: 'Please input an address'
                                }
                            }
                        },
                        begin_time: {
                            validators: {
                                date: {
                                    format: 'YYYY-MM-DD',
                                    message: 'The value is not a valid date'
                                },
                                notEmpty: {
                                    message: 'Please input or pick a date'
                                }
                            }
                        }
                    }
                });               
                
            });           
                    
            // The dynamic registration of the controller must be done before the definition of the indicated ng-controller
            angular.module("app").controller("EmployeeFormController", ["$scope","employeeService", "$location",function($scope, employeeService, $location){
                    
                $scope.formTitle = 'EMPLOYEE CREATION FORM';
                $scope.button = 'Create';
                $scope.displayDeleteButton = false;
                //create a blank object to hold the form information, and $scope will allow this to pass between controller and view
                $scope.formData = {};

                $scope.parentNodeUID = "";  //unique id for getNodeByParam(key, value, parent) method of the zTree
                $scope.curNodeUID = "";

                $scope.parentNodeId = -1;
                $scope.parentNodeType = "";
                $scope.curNodeId = -1;
                $scope.curNodeType = "";

                $scope.submit = 0;  //0 means un-submitted
                $scope.delete = 0;  //0 means un-deleted

                function clearContent(){
                    $scope.formData.name = "";
                    $scope.parentNodeId = -1;
                    $scope.parentNodeType = "";
                    $scope.curNodeId = -1;
                    $scope.curNodeType = "";
                };                

                //here the function validateDepartmentForm is jquery function, which is not recommended.
                //but this page is end page, so it is flexible to use jquery--------------------------------------
                function validateEmployeeForm(){
                    var bootstrapValidator = $("#employee_form").data('bootstrapValidator');
                    bootstrapValidator.validate();
                    if(bootstrapValidator.isValid()){
                        
                        return true;                      
                    } else{
                        
                        return false;
                    }  
                };

                function getJsonDataFromEmployeeForm(){
                    var form = $('#employee_form');

                    //The following conversion is necessary to send server the correct json data
                    var jsonData = {};
                    $.each($(form).serializeArray(), function() {
                        jsonData[this.name] = this.value;
                    });

                    return JSON.stringify(jsonData);
                };

                //-----------------------------------------------------------------------------------------
                // This is to get node information from the zTree
                $scope.employeeFormSubmit = function(){
                    
                    if(validateDepartmentForm() === true){
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
                            saveOrUpdateDepartment(nodeInfo);
                        }else if(msg.type === 'deleteEmployee'){
                            console.log("delete employee");
                            deleteEmployee(nodeInfo);
                        }
                    }               

                });

                function deleteEmployee(nodeInfo){

                    if($scope.delete !== 0)
                        return;

                    $scope.delete++;    //only allow delete once

                    departmentService.deleteDepartmentById($scope, $location, nodeInfo).then(
                        function(data){
                            if(data.hasOwnProperty('validated')){
                                if(data.validated === true){
                                    var str = "<h4 style='color:green'>The deletion was successfully done!</h4> <hr>"

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
                    employeeService.createOrUpateDepartment($scope, $location, jsonData, nodeInfo).then(
                        function(data){
                            if(data.hasOwnProperty('validated')){
                                if(data.validated === true){

                                    var str = "<h4 style='color:green'>The Process was successfully done!</h4> <hr>"

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

                    $scope.$emit("nameChangedToBeSent", $scope.formData.name);
                    formChanged();
                    //reset submit as zero
                    if($scope.submit > 0){
                        $scope.submit = 0;
                        //reset the error messages                            
                        $("#employee_name").nextAll().remove();
                    };

                };

                $scope.addressChange = function(){
                    formChanged();
                };

                $scope.beginTimeChange = function(){
                    formChanged();
                };

                function formChanged(){
                    $scope.$emit("employeeForm_changed");
                };

                //this function is not requried.
                $scope.$on("rootMsg_zTreeNodeNameUpdated", function(event, msg){
                    
                });

                $scope.$on("EmployeePageFormToBeFilled", function(event, obj){
                    
                    $scope.formTitle = 'EMPLOYEE UPDATE FORM';
                    $scope.button = 'Update';     
                    $scope.displayDeleteButton = true;
                            
                    /*employeeService.employeeById($scope, $location, obj).then(
                        function(data){
                            console.log(data);
                            $scope.formData.name = data.name;
                            $scope.formData.address = data.address;
                            $scope.formData.beginTime = data.begin_time;                            
                        },
                        function(errResponse){
                            console.error("Error while fetching the indicated employee");
                        }  

                    );*/
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
                    alert("cancel button");
                };

            }]);
            
        </script>
        
        
    </head>
    <body>
        <!-- disable action and method properties of the following form action=" " method="post"
        Only activate click event and start submit from click function-->
        <form class="well form-horizontal"   id="employee_form" ng-controller="EmployeeFormController">
            <fieldset>

                <!-- Form Name -->
                <legend>{{formTitle}}</legend>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label">Name</label>  
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input  name="name" placeholder="Name" class="form-control"  type="text" id="employee_name" ng-model="formData.name" ng-change="nameChange()"/>
                        </div>
                    </div>
                </div>
                
               
                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" >Home Address</label> 
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group" >
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input name="address" placeholder="Address" class="form-control"  type="text" id="home_address" ng-model="formData.address" ng-change="addressChange()"/>
                        </div>
                    </div>
                </div>        
                               
                <div class="form-group">
                  <label class="col-md-4 control-label" >Begin Date</label> 
                    <!--div class="col-xs-5 date"-->
                    <div class="col-md-4 date">
                        <div class="input-group input-append date" id="datePicker">                            
                            <input type="text" placeholder="yyyy-MM-dd" class="form-control"  name="begin_time" id="employee_begin_time" ng-model="formData.beginTime" ng-change="beginTimeChange()"/>
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>     
                </div>
                             
                <!-- Button -->
                <div class="form-group">
                    <label class="col-md-4 control-label"></label>
                    <div class="col-md-4">
                        <button id="sendButton" class="btn btn-primary" ng-click="employeeFormSubmit()">{{button}}<span class="glyphicon glyphicon-send"></span></button>
                        <button type="button" class="btn btn-warning" ng-click="employeeFormCancel()">Cancel</button>
                    </div>
                    <!-- Indicates a dangerous or potentially negative action -->
                    <div class = "col-md-4">
                        <button type="button" class="btn btn-danger" ng-click="employeeFormDelete()" ng-show="displayDeleteButton">Delete</button>
                    </div>
                </div> 
                
            </fieldset>
            
        </form>
                        
    </body>
</html>