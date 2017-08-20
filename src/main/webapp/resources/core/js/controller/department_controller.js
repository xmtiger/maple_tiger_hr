/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

"use strict";

angular.module("app_department").controller("departmentController", ["$scope", "departmentService", "$location", function($scope, departmentService, $location){
        
    var self = this;
    self.departmentsFromServer = {};
    //fetchAllDepartments();
        
    function fetchAllDepartments(){
        departmentService.setURI($location.path());             //set current path to the service
        departmentService.fetchAllDepartments().then(
            function(d){
                departmentService.departmentsFromServer = d;    //d means data
                console.log("fetchAllDepartments" + d);
                $scope.$emit("DisplayAllDepartments" , d);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
            }
        );        
    }
    
    $scope.displayAll = function(){
       //console.log("enter departmentController displayAll()");
       fetchAllDepartments();
       //console.log("departmentController emit displayAll message");
       
       
    };
    
    $scope.addDepartment = function(){
        console.log("enter departmentController addDepartment()");
        
        //1. send a message to zTree via the root controller for requesting if one node is selected. 
        //If no selected node, send alert to use for requesting selecting node
        $scope.$emit("IfOneNodeSelected");
    };
    
}]);
