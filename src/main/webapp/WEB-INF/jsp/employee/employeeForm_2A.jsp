<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   
        <meta name="viewport" content="width=device-width, initial-scale=1">       
        
        <title>Employee Form</title>
	<c:set var="context" value="${pageContext.request.contextPath}"/>     			
			
        <script type="text/javascript" src="${context}/resources/core/js/controller/employee_controller.js"></script> 
   
    </head>
    <body >
        
        <div ng-controller="EmployeeFormController">
            
        
            <form class="well form-horizontal"   id="employee_form" name="formData" validate >
                <fieldset>

                <!-- Form Name -->
                <legend>{{formTitle}}</legend>

                <!-- Text input-->
                <!-- NAME -->

                <div class="form-group" ng-class="{ 'has-error' : formData.first_name.$invalid && !formData.first_name.$pristine }">
                        <label class="col-md-2 control-label">First Name</label>  
                        <div class="col-md-8 inputGroupContainer">
                                <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input  name="first_name" placeholder="First Name" class="form-control"  type="text" ng-model="employee.firstName" ng-change="nameChange()" ng-minlength="3" />							
                                </div>
                                <p ng-show="formData.first_name.$error.minlength" class="help-block">The Name is required and the input length is too short.</p>
                        </div>
                </div>
                
                <div class="form-group" >
                        <label class="col-md-2 control-label">Middle Name</label>  
                        <div class="col-md-8 inputGroupContainer">
                                <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input  name="middle_name" placeholder="Middle Name" class="form-control"  type="text" ng-model="employee.middleName" ng-change="nameChange()" />							
                                </div>
                                
                        </div>
                </div>

                <div class="form-group" ng-class="{ 'has-error' : formData.last_name.$invalid && !formData.last_name.$pristine }">
                        <label class="col-md-2 control-label">Last Name</label>  
                        <div class="col-md-8 inputGroupContainer">
                                <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input  name="last_name" placeholder="Last Name" class="form-control"  type="text" ng-model="employee.lastName" ng-change="nameChange()" ng-minlength="3" />							
                                </div>
                                <p ng-show="formData.last_name.$error.minlength" class="help-block">The Name is required and the input length is too short.</p>
                        </div>
                </div>

                <!-- Text input-->
                <div class="form-group" ng-class="{ 'has-error' : formData.address.$invalid && !formData.address.$pristine }">
                        <label class="col-md-2 control-label" >Home Address</label> 
                        <div class="col-md-8 inputGroupContainer">
                                <div class="input-group" >
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input name="address" placeholder="Address" class="form-control"  type="text" ng-model="employee.home_address" ng-change="addressChange()" ng-minlength="3"/>							
                                </div>
                                <p ng-show="formData.address.$error.minlength" class="help-block">The Address is too short.</p>
                        </div>
                </div>        


                <div class="form-group" ng-class="{ 'has-error' : formData.birth_date.$invalid && !formData.birth_date.$pristine }">
                  <label class="col-md-2 control-label" >Birth Date</label> 

                        <div class="col-md-8 date">                       

                                <p class="input-group">
                                        <input name="birth_date" type="text" class="form-control" uib-datepicker-popup ng-model="employee.birth_date" ng-change="birthDateChange()" is-open="popup2.opened" datepicker-options="dateOptions" ng-required="true" close-text="Close" />
                                        <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" ng-click="open2()"><i class="glyphicon glyphicon-calendar"></i></button>
                                        </span>
                                        <p ng-show="formData.birth_date.$invalid && !formData.birth_date.$pristine" class="help-block">The date is required.</p>
                                </p>

                        </div>     
                </div>
                
                <div class="form-group" >
                        <label class="col-md-2 control-label">Gender</label>  
                        <div class="col-md-8 inputGroupContainer">
                                <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <label class="radio-inline col-md-1"></label>
                                        <label class="radio-inline col-md-2"><input type="radio" ng-model="employee.gender" value="MALE">Male</label>
                                        <label class="radio-inline col-md-2"><input type="radio" ng-model="employee.gender" value="FEMALE">Female</label>
                                        <label class="radio-inline col-md-2"><input type="radio" ng-model="employee.gender" ng-value="UNKNOWN">Unknown</label>							
                                </div>
                                
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
			
		
	</div>		
                        
    </body>
</html>