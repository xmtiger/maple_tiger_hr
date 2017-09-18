<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   
        <meta name="viewport" content="width=device-width, initial-scale=1">       
        
        <title>Employee Form</title>
			
        
        <script type="text/javascript">				
			
            // The dynamic registration of the controller must be done before the definition of the indicated ng-controller
            angular.module("app").controller("EmployeeFormController", ["$scope","employeeService", "$location",function($scope,employeeService, $location){
                    
                $scope.formTitle = 'EMPLOYEE CREATION FORM';
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
                
                //-----------------------------------------------------------------------------
                //tabs
                $scope.tabs = [{
                    index: 0,
                    title: 'EmployeeForm',
                    url: 'one.tpl.html',
					disabled: false,
					invalid: true
							}, {
					index: 1,
					title: 'Two',
					url: 'two.tpl.html',
					disabled : false,
					invalid: true
							}, {
					index: 2,
					title: 'Three',
					url: 'three.tpl.html',
					disabled : false,
					invalid: true
				}];				
				
				$scope.currentTab = $scope.tabs[0];
				
				$scope.user = {};
                
                $scope.tabFinishLoading = function(){
                    console.log("tab finished loading");
                    
                };
				//-----------------------------------------------
				$scope.today = function() {
					//$scope.dt = new Date();
					$scope.user.beginTime = new Date();
				};
				
				$scope.today();

				$scope.clear = function() {
					//$scope.dt = null;
					$scope.user.beginTime = null;
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
					$scope.user.beginTime = new Date(year, month, day);
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
                    /*var bootstrapValidator = $("#employee_form").data('bootstrapValidator');
                    bootstrapValidator.validate();
                    if(bootstrapValidator.isValid()){
                        
                        return true;                      
                    } else{
                        
                        return false;
                    }  */
					
					if (!$scope.form_data.invalid) {
						alert('our form is valid');
						return true;
					}else{
						alert('our form is invalid');
						return false;
					}       
                    
                };

                function getJsonDataFromEmployeeForm(){
                    /*var form = $('#employee_form');

                    //The following conversion is necessary to send server the correct json data
                    var jsonData = {};
                    $.each($(form).serializeArray(), function() {
                        jsonData[this.name] = this.value;
                    });

                    return JSON.stringify(jsonData);*/
					
					return $scope.user;
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
					//$scope.currentTab.invalid = this.formData.$invalid;
					
                    $scope.$emit("nameChangedToBeSent", $scope.user.name);
                    formChanged($scope, this);
                    //reset submit as zero
                    if($scope.submit > 0){
                        $scope.submit = 0;
                        //reset the error messages                            
                        $("#employee_name").nextAll().remove();
                    };

                };

                $scope.addressChange = function(){
					//$scope.currentTab.invalid = this.formData.$invalid;
                    formChanged($scope, this);
                };

                $scope.beginTimeChange = function(){
				
                    formChanged($scope, this);
                };

                function formChanged($scope, self){
					$scope.currentTab.invalid = self.formData.$invalid;
					
					if($scope.user.hasOwnProperty('name') && $scope.user.name !== ''){
						$scope.currentTab.invalid = false;
						
					}else{
						$scope.currentTab.invalid = true;
					}
					
					if($scope.user.hasOwnProperty('address') && $scope.user.address !== ''){
						$scope.currentTab.invalid = false;
						
					}else{
						$scope.currentTab.invalid = true;
					}
					
                    $scope.$emit("employeeForm_changed");
                };

                //this function is not requried.
                $scope.$on("rootMsg_zTreeNodeNameUpdated", function(event, msg){
                    
                });

                $scope.$on("EmployeePageFormToBeFilled", function(event, obj){
                    
                    $scope.formTitle = 'EMPLOYEE UPDATE FORM';
                    $scope.button = 'Update';     
                    $scope.displayDeleteButton = true;                            
                   
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
    <body ng-controller="EmployeeFormController">
        
		<uib-tabset active="active" >
			
			<!--uib-tab ng-repeat="tab in tabs" index="tab.index" heading="{{tab.title}}" disable="tab.disabled">
				<div ng-include = "tab.url" onload = "tabFinishLoading()"></div>			
			</uib-tab-->
			
                    <uib-tab index="0", heading="tab1">
				<form class="well form-horizontal"   id="employee_form" name="formData" validate >
				<fieldset>

					<!-- Form Name -->
					<legend>{{formTitle}}</legend>

					<!-- Text input-->
					<!-- NAME -->
											
					<div class="form-group" ng-class="{ 'has-error' : formData.name.$invalid && !formData.name.$pristine }">
						<label class="col-md-4 control-label">Name</label>  
						<div class="col-md-8 inputGroupContainer">
							<div class="input-group">
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input  name="name" placeholder="Name" class="form-control"  type="text" ng-model="user.name" ng-change="nameChange()" ng-minlength="3" />							
							</div>
							<p ng-show="formData.name.$error.minlength" class="help-block">The Name is required.</p>
						</div>
					</div>
									
							
					<!-- Text input-->
					<div class="form-group" ng-class="{ 'has-error' : formData.address.$invalid && !formData.address.$pristine }">
						<label class="col-md-4 control-label" >Home Address</label> 
						<div class="col-md-8 inputGroupContainer">
							<div class="input-group" >
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input name="address" placeholder="Address" class="form-control"  type="text" ng-model="user.address" ng-change="addressChange()" ng-minlength="3"/>							
							</div>
							<p ng-show="formData.address.$error.minlength" class="help-block">The Address is too short.</p>
						</div>
					</div>        
						
					
					<div class="form-group" ng-class="{ 'has-error' : formData.begin_time.$invalid && !formData.begin_time.$pristine }">
					  <label class="col-md-4 control-label" >Begin Date</label> 
						
						<div class="col-md-8 date">                       
							
							<p class="input-group">
								<input name="begin_time" type="text" class="form-control" uib-datepicker-popup ng-model="user.beginTime" ng-change="beginTimeChange()" is-open="popup2.opened" datepicker-options="dateOptions" ng-required="true" close-text="Close" />
								<span class="input-group-btn">
									<button type="button" class="btn btn-default" ng-click="open2()"><i class="glyphicon glyphicon-calendar"></i></button>
								</span>
								<p ng-show="formData.begin_time.$invalid && !formData.begin_time.$pristine" class="help-block">The date is required.</p>
							</p>
								
						</div>     
					</div>
								 
					
					
				</fieldset>
				<!-- Button -->
					<div class="form-group">
						<label class="col-md-4 control-label"></label>
						<div class="col-md-4">
							<button class="btn btn-primary" ng-click="employeeFormSubmit()" ng-disabled="currentTab.invalid">{{button}}<span class="glyphicon glyphicon-send"></span></button>
							<button type="button" class="btn btn-warning" ng-click="employeeFormCancel()">Cancel</button>
						</div>
						
						<div class = "col-md-4">
							<button type="button" class="btn btn-danger" ng-click="employeeFormDelete()" ng-show="displayDeleteButton">Delete</button>
						</div>
					</div> 
				
			</form>
			</uib-tab>
			
			<uib-tab index="1", heading="tab2">
				<h1> tab2 </h1>
			</uib-tab>
			
			<uib-tab index="2", heading="tab3">
				<h1> tab3 </h1>
			</uib-tab>
			
			
		</uib-tabset>
		
		<!-- Buttons -->
		<!--div class="form-group">
			<label class="col-md-4 control-label"></label>
			<div class="col-md-4">
				<button id="sendButton" class="btn btn-primary" ng-click="employeeFormSubmit()">{{button}}<span class="glyphicon glyphicon-send"></span></button>
				<button type="button" class="btn btn-warning" ng-click="employeeFormCancel()">Cancel</button>
			</div>
			
			<div class = "col-md-4">
				<button type="button" class="btn btn-danger" ng-click="employeeFormDelete()" ng-show="displayDeleteButton">Delete</button>
			</div>
		</div-> 
        
        <!-- disable action and method properties of the following form action=" " method="post"
        Only activate click event and start submit from click function-->
        
		<script type="text/ng-template" id="one.tpl.html">
			
			<form class="well form-horizontal"   id="employee_form" name="formData" validate >
				<fieldset>

					<!-- Form Name -->
					<legend>{{formTitle}}</legend>

					<!-- Text input-->
					<!-- NAME -->
											
					<div class="form-group" ng-class="{ 'has-error' : formData.name.$invalid && !formData.name.$pristine }">
						<label class="col-md-4 control-label">Name</label>  
						<div class="col-md-4 inputGroupContainer">
							<div class="input-group">
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input  name="name" placeholder="Name" class="form-control"  type="text" ng-model="user.name" ng-change="nameChange()" ng-minlength="3" />							
							</div>
							<p ng-show="formData.name.$error.minlength" class="help-block">The Name is required.</p>
						</div>
					</div>
									
							
					<!-- Text input-->
					<div class="form-group" ng-class="{ 'has-error' : formData.address.$invalid && !formData.address.$pristine }">
						<label class="col-md-4 control-label" >Home Address</label> 
						<div class="col-md-4 inputGroupContainer">
							<div class="input-group" >
								<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								<input name="address" placeholder="Address" class="form-control"  type="text" ng-model="user.address" ng-change="addressChange()" ng-minlength="3"/>							
							</div>
							<p ng-show="formData.address.$error.minlength" class="help-block">The Address is too short.</p>
						</div>
					</div>        
						
					
					<div class="form-group" ng-class="{ 'has-error' : formData.begin_time.$invalid && !formData.begin_time.$pristine }">
					  <label class="col-md-4 control-label" >Begin Date</label> 
						
						<div class="col-md-4 date">                       
							
							<p class="input-group">
								<input name="begin_time" type="text" class="form-control" uib-datepicker-popup ng-model="user.beginTime" ng-change="beginTimeChange()" is-open="popup2.opened" datepicker-options="dateOptions" ng-required="true" close-text="Close" />
								<span class="input-group-btn">
									<button type="button" class="btn btn-default" ng-click="open2()"><i class="glyphicon glyphicon-calendar"></i></button>
								</span>
								<p ng-show="formData.begin_time.$invalid && !formData.begin_time.$pristine" class="help-block">The date is required.</p>
							</p>
								
						</div>     
					</div>
								 
					
					
				</fieldset>
				<!-- Button -->
					<div class="form-group">
						<label class="col-md-4 control-label"></label>
						<div class="col-md-4">
							<button class="btn btn-primary" ng-click="employeeFormSubmit()" ng-disabled="currentTab.invalid">{{button}}<span class="glyphicon glyphicon-send"></span></button>
							<button type="button" class="btn btn-warning" ng-click="employeeFormCancel()">Cancel</button>
						</div>
						
						<div class = "col-md-4">
							<button type="button" class="btn btn-danger" ng-click="employeeFormDelete()" ng-show="displayDeleteButton">Delete</button>
						</div>
					</div> 
				
			</form>
		</script>
		
		<script type="text/ng-template" id="two.tpl.html">
			<div id="viewOne">
				<h1>View One</h1>
				<p>Content of tab 2</p>
			</div>
		</script>
		
		<script type="text/ng-template" id="three.tpl.html">
			<div id="viewTwo">
				<h1>View Two</h1>
				<p>Content of tab 3</p>
			</div>
		</script>
                        
    </body>
</html>