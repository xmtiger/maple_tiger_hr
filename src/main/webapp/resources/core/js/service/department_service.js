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
        saveOrUpdateDepartment : saveOrUpdateDepartment
    };
    
    return factory;
    
    function setURI(location){
        this.uri_path = location;
    }
    
    function fetchAllDepartments(){
        var deferred = $q.defer();
        var request = this.uri_path + REST_SERVICE_URI + "all";
        
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
    
    function saveOrUpdateDepartment(){
        console.log("begin departmentService on function saveOrUpdateDepartment()");
        
        var deferred = $q.defer();
        var request = this.uri_path + REST_SERVICE_URI + "new";
        console.log(request);
        $http.get(request, {format:'html'}).then(
            function(response){
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error("Error while fetching new department form");
                deferred.reject(errResponse);
            }        
        );

        return deferred.promise; 
    }
        
}]);
