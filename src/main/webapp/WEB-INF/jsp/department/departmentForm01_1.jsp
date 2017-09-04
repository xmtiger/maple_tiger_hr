<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <c:set var="context" value="${pageContext.request.contextPath}"/>
        <!-- Latest compiled and minified CSS -->    
        <!-- Bootstrap CSS -->
        <!--script type="text/javascript" src="${context}/resources/vendors/bootstrap3.3.7/js/bootstrap.min.js"></script-->
        <!--link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/-->
       <!--link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/-->
        
        <!--link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" /-->
        
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrapDatePicker/css/bootstrap-datepicker.min.css"/>
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrapDatePicker/css/bootstrap-datepicker3.min.css"/>
        
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrapValidator/css/bootstrapValidator.min.css" />
        
        <title>Department Form Page</title>
        
        <style type="text/css">
            #eventForm.form-control-feedback {
                top: 0;
                right: -15px;
            }
            
            span.error{
                color: red;
                margin-left: 5px;
            }
        </style>    
        
        <!-- jQuery first, then Tether, then Bootstrap JS. -->
        <!-- jQuery library -->
        <!--script src="${context}/resources/vendors/jquery/js/jquery.min.js"></script-->
        
        <!-- Latest compiled JavaScript -->              
        <!--script src="${context}/resources/vendors/bootstrap3.3.7/js/bootstrap.min.js"></script-->

        <script src="${context}/resources/vendors/bootstrapDatePicker/js/bootstrap-datepicker.min.js"></script>
   
        <script src= "${context}/resources/vendors/bootstrapValidator/js/bootstrapValidator.min.js"> </script>   
        
        <!-- angular js -->
                
        <script type="text/javascript">
            $(document).ready(function() {
                                                           
                /*Note: the button id shall be unique, even when this jsp page is loaded from other pages
                 * otherwise the click function of this button does not work*/
                /*  var ctx ="${pageContext.request.contextPath}";
                    
                    $("#sendButton").on("click",function(e){
                    e.preventDefault();
                    
                    $('#resultContainer_click').text(ctx);
                    $('#resultContainer_click').show();
                    
                    var bootstrapValidator = $("#dept_form").data('bootstrapValidator');
                    bootstrapValidator.validate();
                    if(bootstrapValidator.isValid()){
                        $('#resultContainer_click').text("validation is passed in click function");
                        $('#resultContainer_click').show();
                        
                        $("#dept_form").submit();                       
                    } else{
                        $('#resultContainer_click').text("validation is not passed in click function");
                        $('#resultContainer_click').show();                    
                    }                         
                });*/
                
                //submit from through angularJS
                /* Submit form using Ajax. Note it does not work to use button.on("click", function(e)) 
                 * it muset be using form.on("submit", function(e) to send ajax request */
                /*$("#dept_form").on("submit",function(e){
                    
                    e.preventDefault();          
                                       
                    var bootstrapValidator = $("#dept_form").data('bootstrapValidator');
                    bootstrapValidator.validate();
                    if(bootstrapValidator.isValid()){
                        $('#resultContainer').text("validation is passed in sumbit function");
                        $('#resultContainer').show();                        
                       
                    } else{
                        $('#resultContainer').text("validation is not passed in submit function");
                        $('#resultContainer').show();
                        
                        return;
                    }
                    //$("#departmentDiv").load("index");                        
                    var url_address = ctx + "/department/create";
                    
                    var form = $('#dept_form');
                    
                    //The following conversion is necessary to send server the correct json data
                    var jsonData = {};
                    $.each($(form).serializeArray(), function() {
                        jsonData[this.name] = this.value;
                    });
                    var form_data = JSON.stringify(jsonData);
                                               
                    // Use Ajax to submit form data
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: url_address,
                        data: form_data,
                        dataType: "json",                                                                         
                        
                        success: function(res){
                            //alert("success");
                            if(res.validated){
                                
                                $('#resultContainer').text(JSON.stringify(res.department));
                                $('#resultContainer').show();
                            }else{
                                //Set error messages
                                $.each(res.errorMessages,function(key,value){
                                    $('input[name='+key+']').after('<span class="error">'+value+'</span>');
                                });
                            }
                        }
                    });
                });*/
                
                $("#datePicker").datepicker({
                    autoclose: false,
                    format: 'yyyy-mm-dd'
                    
                }).on('changeDate', function(e) {
                    // Revalidate the date field
                    //alert("datepicker.on");
                    $('#dept_form').bootstrapValidator('revalidateField', 'begin_time');
                });
                    
                $('#dept_form').bootstrapValidator({
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
            angular.module("app").controller("DepartmentFormController", ["$scope","departmentService", "$location",function($scope, departmentService, $location){
                    
                    //create a blank object to hold the form information, and $scope will allow this to pass between controller and view
                    $scope.formData = {};
                    
                    $scope.parentNodeUID = "";  //unique id for getNodeByParam(key, value, parent) method of the zTree
                    $scope.curNodeUID = "";
                    
                    $scope.parentNodeId = -1;
                    $scope.parentNodeType = "";
                    $scope.curNodeId = -1;
                    $scope.curNodeType = "";
                    
                    $scope.submit = 0;  //0 means un-submitted
                    
                    function clearContent(){
                        $scope.formData.name = "";
                        $scope.parentNodeId = -1;
                        $scope.parentNodeType = "";
                        $scope.curNodeId = -1;
                        $scope.curNodeType = "";
                    };
                    
                    /*$scope.alert = { type: 'success', msg: 'Welcome using maple_tiger system'};
       
                    $scope.addAlert = function(type, msg) {        
                        $scope.alert.type = type || 'success';
                        $scope.alert.msg = msg || 'Wecome using maple_tiger system';
                    };

                    $scope.closeAlert = function(){
                        $scope.alert = {};
                    };*/
    
                    //here the function validateDepartmentForm is jquery function, which is not recommended.
                    //but this page is end page, so it is flexible to use jquery--------------------------------------
                    function validateDepartmentForm(){
                        var bootstrapValidator = $("#dept_form").data('bootstrapValidator');
                        bootstrapValidator.validate();
                        if(bootstrapValidator.isValid()){
                            $('#resultContainer_click').text("validation is passed in click function");
                            $('#resultContainer_click').show();

                            return true;                      
                        } else{
                            $('#resultContainer_click').text("validation is not passed in click function");
                            $('#resultContainer_click').show();  

                            return false;
                        }  
                    };
                    
                    function getJsonDataFromDeptForm(){
                        var form = $('#dept_form');
                    
                        //The following conversion is necessary to send server the correct json data
                        var jsonData = {};
                        $.each($(form).serializeArray(), function() {
                            jsonData[this.name] = this.value;
                        });
                                                
                        return JSON.stringify(jsonData);
                    };
                    
                    //-----------------------------------------------------------------------------------------
                    // This is to get node information from the zTree
                    $scope.departmentFormSubmit = function(){
                        console.log("departmentFormController-departmentController-addDepartment()");     
                                                
                        if(validateDepartmentForm() === true){
                            //send request to tree for currrent node and the father node information
                            $scope.$emit("RequestCurrentTreeNodeInfo");
                            
                        } else{ 
                            //The validation is not passed
                            console.log("client validation is not passed");                            
                        }           

                    };
                    // This function is to send form data to the server for update or save a new department
                    $scope.$on("RootCtrl_SendCurNodeInfo", function(event, nodeInfo){                        
                        
                        //perform the database actions here.
                        console.log("client validation is passed, then perform database request");

                        if($scope.submit !== 0) //submit is only allowed once.
                            return;
                        
                        $scope.submit++;
                        
                        var jsonData = getJsonDataFromDeptForm();                           
                        console.log(jsonData);
                        departmentService.createDepartment($scope, $location, jsonData, nodeInfo).then(
                            function(data){
                                if(data.hasOwnProperty('validated')){
                                    if(data.validated === true){
                                        $scope.$emit("oneDepartmentCreated", data);
                                        clearContent();
                                    }else{
                                        console.log("Get Error Messages from the server");
                                        console.log(data);
                                        //Set error messages
                                        $.each(data.errorMessages,function(key,value){
                                            $('input[name='+key+']').after('<span class="error">'+value+'</span>');
                                        });
                                        
                                        //$scope.formData.name = "";
                                        //$scope.addAlert("danger", "The Department already exists");
                                    }
                                }                          
                            },
                            function(errResponse){
                                console.error("Error while create one department");
                            }  
                        );
                        
                    });
                    
                    //-----------------------------------------------------------------
                    //functions handling name changes
                    $scope.nameChange = function(){
                        
                        $scope.$emit("nameChangedToBeSent", $scope.formData.name);
                        
                        //reset submit as zero
                        if($scope.submit > 0){
                            $scope.submit = 0;
                            //reset the error messages                            
                            $("#dept_name").nextAll().remove();
                        };
                        
                    };
                    
                    //this function is not requried.
                    $scope.$on("rootMsg_zTreeNodeNameUpdated", function(event, msg){
                        //console.log("parentUId" + parentUId);  
                        //if(parentUId !== "")
                        //  $scope.parentNodeUID = parentUId;
                        //console.log("received msg of rootMsg_zTreeNodeNameUpdated");
                        //$scope.formData.name = data;
                    });
                            
                }]);
            
        </script>
        
    </head>

    <body>
        <!-- disable action and method properties of the following form action=" " method="post"
        Only activate click event and start submit from click function-->
        <form class="well form-horizontal"   id="dept_form" ng-submit="departmentFormSubmit()" ng-controller="DepartmentFormController">
            <fieldset>

                <!-- Form Name -->
                <legend>DEPARTMENT FORM</legend>

                <!-- Text input-->

                <div class="form-group">
                  <label class="col-md-4 control-label">Name</label>  
                  <div class="col-md-4 inputGroupContainer">
                  <div class="input-group">
                  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                  <input  name="name" placeholder="Name" class="form-control"  type="text" id="dept_name" ng-model="formData.name" ng-change="nameChange()"/>
                    </div>
                  </div>
                </div>
                
               
                <!-- Text input-->

                <div class="form-group">
                  <label class="col-md-4 control-label" >Address</label> 
                    <div class="col-md-4 inputGroupContainer">
                    <div class="input-group" >
                  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                  <input name="address" placeholder="Address" class="form-control"  type="text" id="dept_address" ng-model="formData.address"/>
                    </div>
                  </div>
                </div>
                
                <!--div class="col-md-4">
                    <label class="col-md-4 control-label" >Address</label> 
                    <div class="input-group">
                      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                      <input name="address" type="text" class="form-control" placeholder="address" ng-model="formData.address"  close-text="Close" />
                     
                    </div>
                  </div>
                </div-->
               
                <!-- time input -->
                <!--div class="form-group">
                    <label class="col-md-4" control-label"> Begin Date </label>
                         
                        <div class="col-md-4 inputGroupContainer">
                            <div class="input-group" >
                                <input name="begin_time" type="date" class="form-control" placeholder="yyyy-MM-dd" uib-datepicker-popup ng-model="formData.beginTime" is-open="popup2.opened" datepicker-options="dateOptions" ng-required="true" close-text="Close" />
                                
                                <span class="input-group-btn">
                                  <button type="button" class="btn btn-default" ng-click="open2()"><i class="glyphicon glyphicon-calendar"></i></button>
                                </span>
                            </div>
                        </div>
                      </div>
                </div-->
                
                <div class="form-group">
                  <label class="col-md-4 control-label" >Begin Date</label> 
                    <!--div class="col-xs-5 date"-->
                    <div class="col-md-4 date">
                        <div class="input-group input-append date" id="datePicker">
                            
                            <input type="text" placeholder="yyyy-MM-dd" class="form-control"  name="begin_time" id="dept_begin_time" ng-model="formData.beginTime"/>
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>     
                </div>
                                          
                
                <!-- Button -->
                <div class="form-group">
                  <label class="col-md-4 control-label"></label>
                  <div class="col-md-4">
                      <button id="sendButton" class="btn btn-warning" >Send <span class="glyphicon glyphicon-send"></span></button>
                  </div>
                </div>               
                
                
            </fieldset>
         </form>
        <br>       
        <!-- Result Container  -->
        <!--div uib-alert ng-class="'alert-' + (alert.type || 'warning')" close="closeAlert()">{{alert.msg}}</div-->

        <!--br>
        <div id="resultContainer_click" style="display: none;">
         <hr/>
         <h4 style="color: green;">Submit function Response and JSON Response From Server</h4>
          <pre style="color: green;">
            <code></code>
           </pre>
        </div>
        <br>
        <div id="resultContainer" style="display: none;">
         <hr/>
         <h4 style="color: green;">Click function result</h4>
          <pre style="color: green;">
            <code></code>
           </pre>
        </div-->
        
        
        
        
    </body>
  
</html>
