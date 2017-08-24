/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


"use strict";

angular.module("app").controller("rootController", ["$scope", "$rootScope","departmentService","$location","$sce","$compile", "$injector",
    function($scope, $rootScope, departmentService, $location, $sce, $compile, $injector){ 
        
    $scope.alert = { type: 'success', msg: 'Welcome to using maple_tiger_hr System'};
       
    $scope.addAlert = function(type, msg) {
        
        $scope.alert.type = type || 'warning';
        $scope.alert.msg = msg;
    };
   
    $scope.bindPage = "Welcome"; //This is the inital welcome text.
            
    $scope.$on("DisplayAllDepartments", function(event, msg){
        console.log("received displayAllDepartments message", msg);
        
        $rootScope.$broadcast("zTree_displayAllDepartments", msg);
    });
    
    $scope.$on("addOneDepartment", function(event, msg){
        
        console.log("received addOneDepartment request");
        
        $rootScope.$broadcast("zTree_addOneDepartment");
    });
    
    $scope.$on("zTree_noNodeSelected", function(event, msg){
        //alert user that no tree node is selected.
        $scope.addAlert("danger", "No node selected");
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
            departmentService.getSaveOrUpdateDepartmentPage($scope);             
        }        
    });
    
    $scope.$on("updateBindPageView", function (event, data){
        
        console.log("received message from service to update bindPage");
        
        // send messag to the directive, 
        // Note can not send same message as the one received, otherwise it will be indefinte cycle of receiving and sending
        $rootScope.$broadcast("DirectiveToUpdateBindPageView", data);
        
    });
    
    $scope.$on("oneDepartmentCreated", function(event, data){
        
        $rootScope.$broadcast("oneDepartmentCreatedByDepartmentService", data);
        
    });
    
}]);
