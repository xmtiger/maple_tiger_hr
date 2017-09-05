/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

'use strict';

angular.module("app").factory("departmentService", ["$http", "$q", function($http, $q){
        
    //var self = this;
    
    //var departmentsFromServer = {};
    
    var REST_SERVICE_URI = "department/";
    
    var uri_path = {};
    
    var factory = {
        fetchAllDepartments : fetchAllDepartments,
        setURI : setURI,
        getSaveOrUpdateDepartmentPage : getSaveOrUpdateDepartmentPage,
        createDepartment : createDepartment
    };
    
    return factory;
    
    function setURI(location){
        this.uri_path = location;
    }
    
    function fetchAllDepartments($location){
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
    
    function getSaveOrUpdateDepartmentPage($location){
        console.log("begin departmentService on function saveOrUpdateDepartment()");
        
        var deferred = $q.defer();
        var request = $location.path() + REST_SERVICE_URI + "new";
        request = request.replace("/#", "");
            
        $http.get(request, {format:'html'}).then(
            function(response){
                //deferred.resolve(response.data);
                //The following successfully converts the html data from response to the parent bind page.
                console.log("received response");
                //deferred.resolve function will send the data the upper level function whith .then(...)
                deferred.resolve(response.data);                
                //$scope.$emit("updateBindPageView", response.data);
                //return data to controller, let controller send message rather than send message in service.                                
                //return response.data;
                
            },
            function(errResponse){
                console.error("Error while fetching new department form");
                deferred.reject(errResponse);
            }        
        );

        return deferred.promise;
    }
    
    function createDepartment($scope, $location, department, nodeInfo){
        
        var curNodeId = nodeInfo.id;
        var curNodeType = nodeInfo.type;       
        var curFatherId = nodeInfo.fatherId;
        var curFatherType = nodeInfo.fatherType;
        if(curNodeType === null || curNodeType === ""){
            curNodeType = curFatherType;
        }
        if(curFatherType === null || curFatherType === ""){
            curNodeType = "Department";
            curFatherType = "Department";
        }
        
        var deferred = $q.defer();
        var request =  $location.path() + REST_SERVICE_URI + "create" ;
        request = request + "/" + curNodeType + "/" + curNodeId;        
        request = request + "/" + curFatherType + "/" + curFatherId;
                
        request = request.replace("/#", "");
        
        console.log(request);
                
        $http.post(request, department).then(
            function(response){
                //deferred.resolve function will send the data the upper level function whith .then(...)
                deferred.resolve(response.data);
                //Do not send message in service 
                //$scope.$emit("oneDepartmentCreated", deferred.promise);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
                deferred.reject(errResponse);
            }        
        );
        
        return deferred.promise;
    }
        
}]);
