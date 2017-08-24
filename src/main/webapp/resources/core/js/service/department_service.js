/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

'use strict';

angular.module("app").factory("departmentService", ["$http", "$q", function($http, $q){
        
    var self = this;
    
    var departmentsFromServer = {};
    
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
    
    function fetchAllDepartments(){
        var deferred = $q.defer();
        var request = this.uri_path + REST_SERVICE_URI + "all";
        request = request.replace("/#", "");
        
        $http.get(request).then(
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
    
    function getSaveOrUpdateDepartmentPage($scope){
        console.log("begin departmentService on function saveOrUpdateDepartment()");
        
        var deferred = $q.defer();
        var request = this.uri_path + REST_SERVICE_URI + "new";
        request = request.replace("/#", "");
            
        $http.get(request, {format:'html'}).then(
            function(response){
                //deferred.resolve(response.data);
                //The following successfully converts the html data from response to the parent bind page.
                console.log("received response");
                                
                $scope.$emit("updateBindPageView", response.data);
                                                
                //var template = $sce.trustAsHtml(response.data);
                //var template2 = angular.element(template);
                //$compile(template2)($scope);
                //$scope.contentTest = template;
                
                //$scope.bindPage = template;
                //$scope.bindtest = response.data;
                //process compile
                //$compile(template)($scope); 
                
                // Convert the html to an actual DOM node
                
                // Append it to the directive element
                //$scope.bindPage = template2;
                // And let Angular $compile it
                
            },
            function(errResponse){
                console.error("Error while fetching new department form");
                deferred.reject(errResponse);
            }        
        );

        return deferred.promise;
    }
    
    function createDepartment($scope, $location, department){
        
        uri_path = $location.path();
        
        var deferred = $q.defer();
        var request = this.uri_path + REST_SERVICE_URI + "create";
        request = request.replace("/#", "");
        
        console.log(request);
        $http.post(request, department).then(
            function(response){
                deferred.resolve(response.data);
                
                $scope.$emit("oneDepartmentCreated", deferred.promise);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
                deferred.reject(errResponse);
            }        
        );
    }
        
}]);
