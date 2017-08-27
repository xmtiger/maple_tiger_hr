/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


"use strict";

angular.module("app").controller("rootController", ["$scope", "$rootScope","departmentService","$location","$sce","$compile",
    function($scope, $rootScope, departmentService, $location, $sce, $compile){ 
        
    $scope.alert = { type: 'success', msg: 'Welcome using maple_tiger system'};
       
    $scope.addAlert = function(type, msg) {
        
        $scope.alert.type = type || 'success';
        $scope.alert.msg = msg || 'Wecome using maple_tiger system';
    };
   
    $scope.bindPage = "Welcome"; //This is the inital welcome text.
                    
    $scope.$on("DisplayAllDepartments", function(event, data){
        console.log("received displayAllDepartments message", data);
                        
        $rootScope.$broadcast("zTree_displayAllDepartments", data);
    });
    
    $scope.$on("addOneDepartment", function(event, msg){
        
        console.log("received addOneDepartment request");
        
        $rootScope.$broadcast("zTree_addOneDepartment");
    });
    
    $scope.$on("zTree_noNodeSelected", function(event, msg){
        //alert user that no tree node is selected.
        $scope.addAlert("danger", "No node selected");
    });
    
    //---------------------------------------------------------------------------------
    //The message for the communication for update the tree node name
    $scope.$on("nameChangedToBeSent", function(event, msg){
        console.log("rootController received nameChangedToBeSent Message");
        $rootScope.$broadcast("nameChangedToBeSentToTree", msg);
    });
    
    $scope.$on("zTreeNodeNameUpdated", function(event, msg){
        $rootScope.$broadcast("rootMsg_zTreeNodeNameUpdated", msg);
    });
    //---------------------------------------------------------------------------------
    
    $scope.$on("zTreeNewNodeCreated_addNewDepartment", function(event, nodeId){
       
        console.log("received zTreeNodeSelected response", nodeId);
        
        if(nodeId === ""){
            console.log("no node selected");
            return;
        }
            
        console.log("$location.path(/department/new)");
        //start departmentForm.jsp to let user input new department information                                
        departmentService.setURI($location.path());
        departmentService.getSaveOrUpdateDepartmentPage($location).then(
            function(data){
                //$scope.$emit("updateBindPageView", response.data);
                $rootScope.$broadcast("DirectiveToUpdateBindPageView", data);
            },
            function(errResponse){
                console.error("Error while fetching all departments");
            }   
        );
               
    });
    
    $scope.$on("RequestCurrentTreeNodeInfo", function(event, data){
        $rootScope.$broadcast("RootCtrl_RequestCurrentTreeNodeInfo", data);
    });
    
    $scope.$on("zTree_SendCurNodeInfo", function(event, data){
        $rootScope.$broadcast("RootCtrl_SendCurNodeInfo", data);
    });
    
    /*$scope.$on("updateBindPageView", function (event, data){
        
        console.log("received message from service to update bindPage");
        
        // send messag to the directive, 
        // Note can not send same message as the one received, otherwise it will be indefinte cycle of receiving and sending
        $rootScope.$broadcast("DirectiveToUpdateBindPageView", data);
        
    });*/
    
    $scope.$on("oneDepartmentCreated", function(event, data){
        
        $rootScope.$broadcast("RootCtrlMsg_OneDepartmentCreated", data);
        
        //update the bindPgae by sending the message to the registered directive
        var str = "The Department was successfully Created";
        $rootScope.$broadcast("DirectiveToUpdateBindPageView", str);
        //$scope.bindPage = $sce.trustAsHtml("The Department was successfully Created");
        
    });
    
}]);
