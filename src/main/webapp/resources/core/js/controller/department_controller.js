/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

"use strict";

angular.module("app_department").controller("departmentController", ["$scope", "departmentService", function($scope, departmentService){
        
    var self = this;
    self.departmentsFromServer = {};
    //fetchAllDepartments();
        
    function fetchAllDepartments(){
        departmentService.fetchAllDepartments().then(
            function(d){
                departmentService.departmentsFromServer = d;
                console.log("fetchAllDepartments" + d);
                $scope.$emit("DisplayAllDepartments" , d);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
            }
        );        
    }
    
    $scope.displayAll = function(){
       console.log("enter departmentController displayAll()");
       fetchAllDepartments();
       console.log("departmentController emit displayAll message");
       
       
    };
    
}]);
