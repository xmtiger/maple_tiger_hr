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
    
    var factory = {
        fetchAllDepartments : fetchAllDepartments
    };
    
    return factory;
    
    function fetchAllDepartments(){
        var deferred = $q.defer();
        
        var request = REST_SERVICE_URI + "all";
        
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
        
}]);
