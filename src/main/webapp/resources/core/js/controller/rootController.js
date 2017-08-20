/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


"use strict";

angular.module("app").controller("rootController", ["$scope", "$rootScope","departmentService",
    function($scope, $rootScope, departmentService){
        
    var self = this;    
        
    $scope.$on("DisplayAllDepartments", function(event, msg){
        console.log("received displayAllDepartments message", msg);
        
        $rootScope.$broadcast("zTree_displayAllDepartments", msg);
    });
    
    $scope.$on("IfOneNodeSelected", function(event, msg){
        
        console.log("received IfOneNodeSelected request");
        
        $rootScope.$broadcast("zTree_ifOneNodeSelected", msg);
    });
    
    $scope.$on("zTreeNodeSelected", function(event, data){
       
        console.log("received zTreeNodeSelected response", data);
        
        if(data === null || data === undefined || data.length === 0){
            console.log("no node selected");
        }else{
            
            //start departmentForm.jsp to let user input new department information
            
            //departmentService.saveOrUpdateDepartment(data);
        }
        
    });
    
}]);
