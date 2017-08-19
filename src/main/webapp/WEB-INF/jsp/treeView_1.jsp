<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" >    
    
    <head>        
        
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <c:set var="context" value="${pageContext.request.contextPath}"/>
        <title>mapletiger_HR_System</title>
        
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrap3.3.7/css/bootstrap.min.css" type="text/css"/>
        <!--jsp:include page="./fragments/header.jsp"/-->        
        
        <link rel="stylesheet" href="${context}/resources/vendors/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
        
        <style type="text/css">
            #maincontainer {
                width:100%;
                height: 100%;
              }

              #leftcolumn {
                float:left;
                display:inline-block;
                width: 220px;
                height: 100%;
                background: white;
              }

              #contentwrapper {
                float:left;
                display:inline-block;
                width: -moz-calc(100% - 220px);
                width: -webkit-calc(100% - 220px);
                width: calc(100% - 220px);
                height: 100%;
                background-color: white;
              }
             
             div.clear{clear:both;}
             
        </style>        
    </head>
    
    <body ng-app="app" ng-controller="rootController">

        <c:set var="urlHome" value="${context}" />
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                
                <div class="navbar-header">
                    <a class="navbar-brand" href="${urlHome}">Home Page</a>
                </div>
                
                <ul class="nav navbar-nav">

                    <li class="dropdown" ng-controller="departmentController as deptCtrl">
                        <a id="department_menu" class="dropdown-toggle" data-toggle="dropdown" href="#" >DEPARTMENT<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" id="department_menu_display" ng-click="displayAll()">Dispaly All</a></li>
                            <li class="divider"></li>
                            <li><a href="#" id="department_menu_add">Add</a></li>
                            <li><a href="#" id="department_menu_edit">Edit</a></li>
                            <li><a href="#" id="department_menu_delete">Remove</a></li>
                        </ul>   
                    </li>
                    
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                          <li><a href="#">Page 1-1</a></li>
                          <li><a href="#">Page 1-2</a></li>
                          <li><a href="#">Page 1-3</a></li>
                        </ul>
                    </li>
                    
                    <li><a href="#">Page 2</a></li>
                    <li><a href="#">Page 3</a></li>
                </ul>                   

            </div>
                
        </nav>
    
    
         
        <div id="maincontainer">
            <!-- 3 setup a container element -->
            <div id = "leftcolumn">
                
                
                    <div style="height:300px; min-height:0px; max-height: 75%; border: 1px solid black">
                        <ul ztree id="xmTreeView" class="ztree" ng-model ="selectNode"></ul>  
                    </div>
                
                
                
                <br>
                <div class="btn-group">
                    <button id="addButton" type="button" class="btn btn-primary">Add</button>
                    <button id="editButton" type="button" class="btn btn-primary">Edit</button>
                    <button id="removeButton" type="button" class="btn btn-primary">Remove</button>
                </div>
                <form>
                <br>
                Search <input id="search_tree" type="text" /> 
                </form>
                
            </div>   
            
            <div id ="contentwrapper">
                <br>
                <ul id ="departmentDiv"></ul>
            </div>
            
        </div>
        <div class="clear"></div>       
        
        <br>       
        
        <script type="text/javascript" src="${context}/resources/vendors/jquery/js/jquery.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/bootstrap3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/zTree/js/jquery.ztree.all.min.js"></script>
        <!-- angular js -->
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular.min.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/app.js"></script>        
        <script type="text/javascript" src="${context}/resources/core/js/service/app_utils.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/service/department_service.js"></script>        
        <script type="text/javascript" src="${context}/resources/core/js/controller/department_controller.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/controller/rootController.js"></script>
        
        <script>
            /*Search if the key exists in the indicated object. 
             * Use maxSerchLeves to define how deep the search shall go. 1 means search current level*/
            /*function ShallowSearchKeysInJson(obj, keyToBeSearched, maxSearchLevels){
                this.search_result = false;
                             
                maxSearchLevels--;
                if(maxSearchLevels < 0 )
                    return this.search_result;
                
                Object.keys(obj).forEach(function(key){
                   if(key === keyToBeSearched){
                        this.search_result = true;
                        return true;        //note: this return only jump out forEach function, not the ouside function ShallowSearchKeysInJson(...)
                   } 
                });
                
                if(this.search_result === true)
                    return true;             
                                
                for( eachOne in obj){
                    if(typeof obj[eachOne] === "object"){
                        this.search_result = ShallowSearchKeysInJson(obj[eachOne], keyToBeSearched, maxSearchLevels);
                        
                        if(this.search_result === true)
                            return true;
                    }
                }
                
                return this.search_result;
            }; 
            
            function DeepSearchKeysInJson(obj, keyToBeSearched){
                this.search_result = false;
                
                Object.keys(obj).forEach(function(key){
                   if(key === keyToBeSearched){
                        this.search_result = true;
                        
                   } 
                });
                
                if(this.search_result === true)
                    return true;
                
                for( eachOne in obj){
                    if(typeof obj[eachOne] === "object"){
                        this.search_result = DeepSearchKeysInJson(obj[eachOne], keyToBeSearched);
                        
                        if(this.search_result === true)
                            return true;
                    }
                }
                
                return this.search_result;
            };   
                        
            function ContainsKeyValue( obj, key, value ){
                if( obj[key] === value ) 
                    return true;
                for( eachOne in obj )
                {
                    if( obj[eachOne] !== null && obj[eachOne][key] === value ){
                        return true;
                    }
                    if( typeof obj[eachOne] === "object" && obj[eachOne]!== null ){
                        var found = ContainsKeyValue( obj[eachOne], key, value );
                        if( found === true ) 
                            return true;
                    }
                }
                return false;
            };
            
            function FindKeyValue( obj, key, value ){
                if( obj[key] === value ) 
                    return null;
                for( eachOne in obj )
                {
                    if( obj[eachOne] !== null && obj[eachOne][key] === value ){
                        return obj[eachOne][key];
                    }
                    if( typeof obj[eachOne] === "object" && obj[eachOne]!== null ){
                        var found = FindKeyValue( obj[eachOne], key, value );
                        return found;
                    }
                }
                return null;
            };
            
            var typeOfBranchOfTree = "Department";
            var keyOfLeafOfBranchOfTree = "employees";
            var typeOfLeafOfTree = "Employee";
            
            function TreeNodeConverter(objFromServer){
                this.id = -1;
                this.name = "";     //name property is used by ZTree
                //the objFromServer shall have dataType field, since it is warpped with TreeNode Class
                this.dataType = objFromServer.dataType;
                //this children array includes both departments and employees
                this.children = [];
                this.open = false;  //open property is used by ZTree           
                
                //In this function, the TreeNodeConveter objects are made with matching properties from objFromServer
                //It is very important function for showing nodes in ZTree  
                this.childrenFunc = function(objFromServer){
                    
                    if(objFromServer.data !== null){
                        this.id = objFromServer.data.id;
                        if(objFromServer.dataType === typeOfBranchOfTree){
                            this.name = objFromServer.data.name;
                            this.dataType = objFromServer.dataType;                            
                            
                            var i = 0;
                            
                            if(objFromServer.children.length !== 0){                   
                                // the children is department object
                                this.open = true;
                                for(; i<objFromServer.children.length; i++){

                                    this.children[i] = new TreeNodeConverter(objFromServer.children[i]);
                                    this.children[i].childrenFunc(objFromServer.children[i]);

                                }
                            } 
                            
                            var ifKeyEmployeesExist = ShallowSearchKeysInJson(objFromServer, keyOfLeafOfBranchOfTree,2);

                            if(ifKeyEmployeesExist === true){
                                this.open = true;
                                //the children is employee object, note the leaf here still tightly bonded with certain type. Here is "employee".
                                //this shall be improved with general type 
                                for(var j = 0; j < objFromServer.data.employees.length; j++){
                                    this.children[j+i] = new TreeNodeConverter(objFromServer.data.employees[j]);
                                    this.children[j+i].id = objFromServer.data.employees[j].id;
                                    this.children[j+i].name = objFromServer.data.employees[j].firstName + " " + objFromServer.data.employees[j].lastName;
                                    //note: employee does not have type due to field members of Department
                                    this.children[j+i].dataType = typeOfLeafOfTree;
                                }
                            }                                                          
                            
                        } 
                        
                    }else{
                        //for the root "null" object:                        
                        if(objFromServer.children.length !== 0){                   
                            this.open = true;
                            
                            for(var i=0; i<objFromServer.children.length; i++){

                                this.children[i] = new TreeNodeConverter(objFromServer.children[i]);
                                this.children[i].childrenFunc(objFromServer.children[i]);

                            }
                        }   
                    }           
                    
                };    
            };*/
            
            
            
            /*The following function successfully shows how the tree can be created by using recursive method.
             * The generated data can be used for zTree data.
            };*/
            
            
            $("#departmentDiv").html("Welcome to using Maple_Tiger_HR System");
            //the upper portion is for testing purpose.
            
            //var zTreeObj;
            // zTree configuration information, refer to API documentation (setting details)
            //var setting = {};   
           
            //jQuery function
            $(document).ready(function(){
                //The required data can be customerized object which includes name, children.
                //zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, tree_test);
                
                //click of deparment menu
                /*$("#department_menu_display").click(function(e){
                    e.preventDefault(); //e.preventDefault is to prevent link to the href address
                    $("#departmentDiv").html("Please wait, the data is loading...");
                    
                    //The follwing section shows how to load data from server
                    var request = "department/" + "all";
                    var data_sent = null;
                    // Use Ajax to submit form data
                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: request,
                        data: data_sent,
                        dataType: "json", 
                                                
                        success: function(res){
                            //alert("success");
                            var tree_nodes = new TreeNodeConverter(res);
                            tree_nodes.childrenFunc(res);                            
                            
                            $("#departmentDiv").html(JSON.stringify(res));
                            //reset zTree with data from server
                            $.fn.zTree.init($("#xmTreeView"), setting, tree_nodes);
                        }
                    });
                });*/
                
                //
                $("#editButton").click(function(){
                    //The follwing section shows how to load data from server
                    var request = "department/" + "all";
                    
                    
                    
                    
                });
               
                $("#addButton").click(function(){
                   
                    //$(this).prop("disabled", true);  // this also works well for the current button 
                   
                    //The following works fine for buttons in group with same class type
                    //$(".btn-primary").prop('disabled', true);

                    $("#departmentDiv").html("the page is loading, please wait...");

                    var id = 2;
                    var request = "department/" + "id/" + id;

                    //The following load function successfully shows how the load function works
                    /*$("#departmentDiv").load(request, function(res, status, xhr){
                        if(status === "success"){
                            $("#departmentDiv").html(res);
                        }
                    });*/

                    /*The following get function successfully shows similar effects as the upper load function.
                     * but the get function requires JSON.stringify function to convert object to string*/
                    /*$.get(request, function(res, status){
                        if(status === "success"){
                            $("#departmentDiv").html(JSON.stringify(res));
                        }
                    });*/

                    //The following load function shows how to request loading a page
                    $("#departmentDiv").load("department/new");
                   
                   
                });
               
            });          
            
        </script>
        
        <jsp:include page="./fragments/footer.jsp"/> 
        
    </body>
</html>
