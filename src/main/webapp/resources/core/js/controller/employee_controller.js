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