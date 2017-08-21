/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


"use strict";

angular.module("app").controller("rootController", ["$scope", "$rootScope","departmentService","$location","$sce","$document",
    function($scope, $rootScope, departmentService, $location, $sce, $document){ 
        
    var self = this;    
    
    //$scope.bindPage = "Welcome to using maple_tiger_hr System"; //This is the inital welcome text.
            
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
            console.log("$location.path(/department/new)");
            //start departmentForm.jsp to let user input new department information
            //$location.path("/department/new"); 
            departmentService.setURI($location.path());
            var response = departmentService.saveOrUpdateDepartment(data);
            var result = $document[0].getElementById("bindPage");
            if(result !== null){
                var div = angular.element(result);
                if(div !== null){
                    div.html(response);
                }
                
            }
            
            //console.log(response);
            //$scope.bindPage = response;
        }
        
    });
    
}]);
