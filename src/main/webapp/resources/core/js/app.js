/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
'use strict';

var app_utils = angular.module("app_utils", []);
var app_department = angular.module("app_department", ["app_utils"]);
var app = angular.module("app",["ngRoute","ngSanitize","app_department", "ui.bootstrap", "ui.grid"]);

//For time being, the route setting is not required.
/*app.config(['$routeProvider', function($routeProvider){
    $routeProvider.
            when("/department/new1",{
                templateUrl : "department/new1",
                controller : "departmentController"
            }).
            otherwise({
                redirectTo: "#"
            });
}]);*/

app.config(['$controllerProvider','$provide','$compileProvider', function($controllerProvider, $provide, $compileProvider){
    
    console.log("add controller after angularjs bootstrapped");
    
    // Let's keep the older references.
    app._controller = app.controller;
    app._service = app.service;
    app._factory = app.factory;
    app._value = app.value;
    app._directive = app.directive;
    // Provider-based controller.
    app.controller = function( name, constructor ) {
        console.log("controller register");
        $controllerProvider.register( name, constructor );
        return( this );
    };
    // Provider-based service.
    app.service = function( name, constructor ) {
        $provide.service( name, constructor );
        return( this );
    };
    // Provider-based factory.
    app.factory = function( name, factory ) {
        $provide.factory( name, factory );
        return( this );
    };
    // Provider-based value.
    app.value = function( name, value ) {
        $provide.value( name, value );
        return( this );
    };
    // Provider-based directive.
    app.directive = function( name, factory ) {
        $compileProvider.directive( name, factory );
        return( this );
    };
        
}]);


//dynamic div to dynamically add html pages
app.directive('bindPage', ['$compile', '$parse', '$sce', function ($compile, $parse, $sce) {
    return {
        restrict: 'A',
        link : function(scope, element, attrs){
            console.log("in directive bindPage");
            
            /*var expression = $sce.parseAsHtml(attrs.bindPage);
            
            var getResult = function(){
                return expression(scope);
            }; */    
            
            //compile the template upon receiving the message of "DirectiveToUpdateBindPageView"             
            scope.$on("DirectiveToUpdateBindPageView", function(event, data){
                console.log("proceed the message updateBindPageView in the directive");
                
                element.html(data);
                $compile(element.contents())(scope);
                
                //scope.$emit("DirectveFinishedTheUpdate");
               
            });
        }    
              
    };
    
    /*return {
        controller: function( $scope, $element, $attrs, $transclude ) {
            console.log( $attrs.log + ' (controller)' );
            
            $scope.departmentFormSubmit = function(){
                console.log("dept form submit");
            };
            
        },
        compile: function compile( tElement, tAttributes ) {
            console.log( tAttributes.log + ' (compile)'  );
            return {
                pre: function preLink( scope, element, attributes ) {
                    console.log( attributes.log + ' (pre-link)'  );
                },
                post: function postLink( scope, element, attributes ) {
                    console.log( attributes.log + ' (post-link)'  );
                }
            };
         }
     };  */
}]);
/*
app.directive('c3PieChart1', function(){
    
    return {
        require: '^c3chart',
        restrict: 'E',        
        replace: true,
        link: pieLinker
    };
    
    var pieLinker = function (scope, element, attrs, chartCtrl) {
        var pie = {};
        if (attrs.showLabel) {
            pie.label = {"show": (attrs.showLabel === 'true')};
        }
        if (attrs.thresholdLabel) {
            if (!pie.label) {
                pie.label = {};
            }
            pie.label.threshold = parseFloat(attrs.thresholdLabel);
        }
        if (attrs.expand) {
            pie.expand = (attrs.expand === 'true');
        }
        chartCtrl.addPie(pie);
        if (attrs.labelFormatFunction) {
            chartCtrl.addPieLabelFormatFunction(scope.labelFormatFunction());
        }
    };
    
});*/

// Two-way bound treeView
//树形结构 
app.directive('ztree',function(){ 
    return{ 
        require:'?ngModel', 
        restrict:'A', 
        link:function($scope,element,attrs,ngModel){ 
            var setting = { 
                
                simpleData:{
                    enable: true,
                    idKey: "UID"
                },

                callback:{ 
                    /*beforeClick:function(treeId, treeNode) {//点击菜单时进行的处理 
                        //var zTree = $.fn.zTree.getZTreeObj("ztree"); 
                        console.log("request for beforeClick of call back of zTree");
                    } */
                    
                } 
            }; 
            
            function zTreeOnNodeCreated(event, treeId, treeNode){
                
            };
            
            //var zTreeId = "#xmTreeView";
            var zTreeObj = {};
            //var nodeToBeCreatedOrUpdated = {};
            //note: the zTree tId changes when the next node is inserted.
            //the id shall be dataType + id, and the format is: "dataType/id"
            var parentNodeUId_forNodeToBeCreatedOrUpdated = ""; 
            var nodeUId_toBeCreatedOrUpdated = "";   //tree internal id, read only.
            var branchType = "";
            var leafType = "";
            var leafKey = "";
            //向控制器发送消息，进行菜单数据的获取 
            //$scope.$emit("menu",attrs["value"]);//此处attrs["value"]为ul中的value值，此处作为标记使用 
            //接受控制器返回的菜单的消息 
            $scope.$on("zTree_displayAllDepartments",function(event,data){ 
                console.log("received zTree_displayAllDepartments" + data);
                
                var util_service = angular.element(document.body).injector().get('UtilService');
                //console.log("get util_service" + util_service);
                //var tree_nodes = tree_nodes || {};
                branchType = "Department";        
                leafType = "Employee";
                leafKey = "employees";  //This is for branch "Department" to know where is the children set besides its children departments
                
                var tree_nodes = util_service.TreeNodesGenerator(data, branchType, leafType, leafKey);
                console.log(tree_nodes);
                
                zTreeObj =  $.fn.zTree.getZTreeObj(element);
                if(zTreeObj !== null){
                    zTreeObj.destroy();
                }
                                                
                zTreeObj = $.fn.zTree.init(element, setting, tree_nodes);//进行初始化树形菜单 
                if(zTreeObj !== null){
                    console.log("successfully initiate the tree");
                    //send request 
                }
                                
            }); 
            
            $scope.$on("zTree_addOneDepartment",function(event,data){ 
                console.log("zTree received message of zTree_addOneDepartment");
                //just if one node was already created. if yes, then give up add department process
                if(nodeUId_toBeCreatedOrUpdated !== ""){
                    $scope.$emit("RefuseAddingDepartment");
                    return;
                }
                //judge if one node is selected, 
                //then send the selected node information to the root controller
                 
                if(zTreeObj !== null){
                    var nodes = zTreeObj.getSelectedNodes();
                    if(nodes === null || nodes === undefined || nodes.length === 0){
                         $scope.$emit("zTree_noNodeSelected");
                    }else{
                        //create a new node as child node of the selected node
                        var firstNode = nodes[0];
                        if(firstNode !== null){
                            //save the parent UID for future database process
                            parentNodeUId_forNodeToBeCreatedOrUpdated = firstNode.getUID();
                            
                            var util_service = angular.element(document.body).injector().get('UtilService');
                            
                            if(util_service !== null){
                                var nodeTmpValue = {name : "childDepartment"};    //new department id is -1
                                var newNode = new util_service.TreeNodeConverter();
                                newNode.setName(nodeTmpValue.name);
                                newNode.setDataType(branchType);
                                                                                                
                                var nodesAdded = zTreeObj.addNodes(firstNode,-1, newNode);
                                if(nodes.length >0){
                                    var nodeToBeCreatedOrUpdated = nodesAdded[0];
                                    //get the current node UID for future database process
                                    nodeUId_toBeCreatedOrUpdated = nodesAdded[0].getUID();
                                    
                                    zTreeObj.selectNode(nodeToBeCreatedOrUpdated);
                                    console.log("zTree create a new node, and send it to the root controller");                
                               
                                    $scope.$emit("zTreeNewNodeCreated_addNewDepartment", nodeUId_toBeCreatedOrUpdated);
                                }
                                
                            }                     
                        }                      
                    }                  
                }
            }); 
            
            // this is the deep first search, and is only for small set of data
            function findNodeByUID(nodes, key, value){
                var find = null;
                
                for(var i=0; i< nodes.length; i++){
                                        
                    if(nodes[i].hasOwnProperty(key)){
                        
                        if(nodes[i].getUID() === value){
                            find = nodes[i];
                            return find;
                        }
                    }
                    
                    if(find === null){
                        if(nodes[i].hasOwnProperty("children")){
                            find = findNodeByUID(nodes[i].children, key, value);
                            if(find !== null)
                                return find;
                        }
                    }
                    
                }
                return find;
            };
            
            $scope.$on("nameChangedToBeSentToTree", function(event, newName){
                console.log("zTree received message of nameChangedToBeSentToTree");
                if(zTreeObj === null)
                    return;
                
                if(nodeUId_toBeCreatedOrUpdated === "")
                    return;
                
                //get current node by using the function of getNodesByParam(key, value, parent)
                var key = "UID";
                var allNodes = zTreeObj.getNodes();
                
                        
                //var nodeToBeCreatedOrUpdated_array = zTreeObj.getNodeByParam("UID", nodeUId_toBeCreatedOrUpdated);             
                var nodeToBeCreatedOrUpdated = findNodeByUID(allNodes, "UID", nodeUId_toBeCreatedOrUpdated);
                //var nodeToBeCreatedOrUpdated = zTreeObj.getNodeByTId(nodeId_toBeCreatedOrUpdated);
                if(nodeToBeCreatedOrUpdated !== null){
                                        
                    if(zTreeObj !== null){
                        nodeToBeCreatedOrUpdated.setName(newName);
                        nodeUId_toBeCreatedOrUpdated = nodeToBeCreatedOrUpdated.getUID();
                        
                        zTreeObj.refresh();                  
                        
                        $scope.$emit("zTreeNodeNameUpdated");               
                        
                        /*var parent = findNodeByUID(zTreeObj.getNodes(), "UID", parentNodeUId_forNodeToBeCreatedOrUpdated);                        
                        if(parent !== null){
                            //send parent id to the department form for database process purpose                            
                            $scope.$emit("zTreeNodeNameUpdated", parentNodeUId_forNodeToBeCreatedOrUpdated);
                        }*/                        
                    }
                }
            });
            
            $scope.$on("RootCtrl_RequestCurrentTreeNodeInfo", function(event, data){
                if(zTreeObj === null)
                    return;
                
                if(nodeUId_toBeCreatedOrUpdated === "")
                    return;
                
                if(zTreeObj === null)
                    return;
                
                var nodeToBeCreatedOrUpdated = findNodeByUID(zTreeObj.getNodes(), "UID", nodeUId_toBeCreatedOrUpdated);
                //var nodeToBeCreatedOrUpdated = zTreeObj.getNodeByParam("UID", nodeUId_toBeCreatedOrUpdated);
                //var nodeToBeCreatedOrUpdated = zTreeObj.getNodeByTId(nodeId_toBeCreatedOrUpdated);
                
                if(nodeToBeCreatedOrUpdated !== null){
                                            
                    var parent = findNodeByUID(zTreeObj.getNodes(), "UID", parentNodeUId_forNodeToBeCreatedOrUpdated);

                    //var parent = zTreeObj.getNodeByTId(parentNodeId_forNodeToBeCreatedOrUpdated);
                    if(parent !== null){
                        //send the parent node and current node information to the department form for creating a new department                            
                        var dataToBeSent = {};
                        dataToBeSent.id = nodeToBeCreatedOrUpdated.getId();
                        dataToBeSent.type = nodeToBeCreatedOrUpdated.getDataType();
                        dataToBeSent.fatherId = parent.getId();
                        dataToBeSent.fatherType = parent.getDataType();

                        $scope.$emit("zTree_SendCurNodeInfo", dataToBeSent);
                    }                        
                    
                }
            });
            
            $scope.$on("RootCtrlMsg_OneDepartmentCreated", function(event, data){
                
                console.log("zTree received message of oneDepartmentCreatedByDepartmentService");
                //zTree will update the tree nodes
                if(zTreeObj === null)
                    return;
                
                if(nodeUId_toBeCreatedOrUpdated === "")
                    return;
                
                var nodeToBeCreatedOrUpdated = findNodeByUID(zTreeObj.getNodes(), "UID", nodeUId_toBeCreatedOrUpdated);
                                    
                if(nodeToBeCreatedOrUpdated !== null){

                    nodeToBeCreatedOrUpdated.id = data.department.id;
                    //var parent = findNodeByUID(zTreeObj.getNodes(), "UID", parentNodeUId_forNodeToBeCreatedOrUpdated);
                    var parent = findNodeByUID(zTreeObj.getNodes(), "UID", parentNodeUId_forNodeToBeCreatedOrUpdated);

                    if(parent !== null){
                        zTreeObj.selectNode(parent);
                        //after successfully creating a department, set tree id as empty
                        nodeUId_toBeCreatedOrUpdated = "";
                    }
                }
                
            });
            
            //The following section is for the testing and initialization of zTree
            function Department(id, name, address, begin_time) {
                this.id = id;
                this.name = name;
                this.address = address;
                this.begin_time = begin_time;
                this.children = [];
                this.open = false;

                this.IfOpenFunc = function IfOpen(){
                    if(this.children.length > 0)
                        this.open = true;
                    else 
                        this.open = false;
                };
            };

            var tree_test = new Department("", "", "", "");

            var dept01 = new Department("1","Management01", "123 Springland", "2010-09-08");

            var dept02 = new Department("2","Engineering01", "123 Springland", "2010-09-08");
            var dept021 = new Department("3","Civil01", "123 Springland", "2010-09-08");
            var dept022 = new Department("4","Structural01", "123 Springland", "2010-09-08");

            dept02.children[dept02.children.length] = dept021;
            dept02.children[dept02.children.length] = dept022;

            var dept03 = new Department("5","Accounting01", "123 Springland", "2010-09-08");

            tree_test.children[tree_test.children.length] = dept01;
            tree_test.children[tree_test.children.length] = dept02;
            tree_test.children[tree_test.children.length] = dept03;

            tree_test.IfOpenFunc();
            // this is to show the JQuery function still works, and the variable "element" is binded with zTree element
            $.fn.zTree.init(element, setting, tree_test);   
        } 
    } ;
}); 

