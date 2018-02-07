/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

'use strict';

angular.module("app").factory("employeeService", ["$http", "$q", function($http, $q){
   
    var REST_SERVICE_URI = "employee/";
    var REST_DEPARTMENT_FORM_PAGE_URI = "getCreationOrUpdateFormPage";
    
    var EMPLOYEE_CREATION_TAB_NAME = 'Employee Creation';
    var EMPLOYEE_EDIT_TAB_NAME = 'Employee Edit';
     
    var factory = {
        fetchAllEmployees : fetchAllEmployees,        
        getSaveOrUpdateEmployeePage : getSaveOrUpdateEmployeePage,
        createOrUpateEmployee : createOrUpateEmployee,
        findEmployeeById : findEmployeeById,
        deleteDepartmentById : deleteEmployeeById,
        getCreationEditPageURI : getCreationEditPageURI,
        getCreationTabName : getCreationTabName,
        getEditTabName : getEditName
    };
    
    return factory;
    
    function getCreationTabName(){
        return EMPLOYEE_CREATION_TAB_NAME;
    }
    
    function getEditName(){
        return EMPLOYEE_EDIT_TAB_NAME;
    }
    
    function fetchAllEmployees($location){
        var deferred = $q.defer();
        var request = $location.path() + REST_SERVICE_URI + "all";
        request = request.replace("/#", "");
        
        $http.post(request).then(
            function(response){
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
                deferred.reject(errResponse);
            }        
        );

        return deferred.promise;        
    }
    
    function getSaveOrUpdateEmployeePage($location){
        console.log("begin employeeService on function saveOrUpdateEmployee()");
        
        var deferred = $q.defer();
        var request = $location.path() + REST_SERVICE_URI + REST_DEPARTMENT_FORM_PAGE_URI;
        request = request.replace("/#", "");
            
        $http.get(request, {format:'html'}).then(
            function(response){
                //deferred.resolve(response.data);
                //The following successfully converts the html data from response to the parent bind page.
                console.log("received response");
                //deferred.resolve function will send the data the upper level function whith .then(...)
                deferred.resolve(response.data);                
                                
            },
            function(errResponse){
                console.error("Error while fetching employee form");
                deferred.reject(errResponse);
            }        
        );

        return deferred.promise;
    }
    
    function createOrUpateEmployee($scope, $location, employee, nodeInfo){
        
        var curNodeId = nodeInfo.id;
        var curNodeType = nodeInfo.type;       
        var curFatherId = nodeInfo.fatherId;
        var curFatherType = nodeInfo.fatherType;
        if(curNodeType === null || curNodeType === ""){
            curNodeType = curFatherType;
        }
        if(curFatherType === null || curFatherType === ""){
            curNodeType = "Employee";
            curFatherType = "Department";
        }
        
        var deferred = $q.defer();
        var request =  $location.path() + REST_SERVICE_URI + "create" ;
        request = request + "/" + curNodeType + "/" + curNodeId;        
        request = request + "/" + curFatherType + "/" + curFatherId;
                
        request = request.replace("/#", "");
        
        console.log(request);
                
        $http.post(request, employee).then(
            function(response){
                //deferred.resolve function will send the data the upper level function whith .then(...)
                deferred.resolve(response.data);
                //Do not send message in service 
                //$scope.$emit("oneDepartmentCreated", deferred.promise);
            },
            function(errResponse){
                console.error("Error while fetching all employees");
                deferred.reject(errResponse);
            }        
        );
        
        return deferred.promise;
    }
        
    function findEmployeeById($scope, $location, nodeInfo){
        
        var curNodeId = nodeInfo.id;
        //var curNodeType = nodeInfo.dataType;       
                
        var deferred = $q.defer();
        
        var request =  REST_SERVICE_URI + "id/" + curNodeId;
                                
        request = request.replace("/#", "");
        
        console.log(request);
                
        $http.post(request).then(
            function(response){
                //deferred.resolve function will send the data the upper level function whith .then(...)
                deferred.resolve(response.data);                
            },
            function(errResponse){
                console.error("Error while fetching the indicated employee");
                deferred.reject(errResponse);
            }        
        );
        
        return deferred.promise;
    }
    
    function deleteEmployeeById($scope, $location, nodeInfo){
        var curNodeId = nodeInfo.id;             
                
        var deferred = $q.defer();
        
        var request =  REST_SERVICE_URI + "delete/id/" + curNodeId;
                                
        request = request.replace("/#", "");
        
        console.log(request);
                
        $http.post(request).then(
            function(response){
                //deferred.resolve function will send the data the upper level function whith .then(...)
                deferred.resolve(response.data);                
            },
            function(errResponse){
                console.error("Error while fetching the indicated employee");
                deferred.reject(errResponse);
            }        
        );
        
        return deferred.promise;
    }
    
    function getCreationEditPageURI(){
        return REST_SERVICE_URI + REST_DEPARTMENT_FORM_PAGE_URI;
    }
    
}]);
