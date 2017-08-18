/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


"use strict";

angular.module("app").controller("rootController", ["$scope", "departmentService", function($scope, departmentService){
        
    var self = this;
    self.departmentsFromServer = {};
    
        
    $scope.$on("DisplayAllDepartments", function(event, msg){
        console.log("received displayAllDepartments message");
    });
    
}]);
