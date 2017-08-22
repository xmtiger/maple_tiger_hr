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

                    <li class="dropdown" ng-controller="departmentController">
                        <a id="department_menu" class="dropdown-toggle" data-toggle="dropdown" href="#" >DEPARTMENT<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" id="department_menu_display" ng-click="displayAll()">Dispaly All</a></li>
                            <li class="divider"></li>
                            <li><a href="#" id="department_menu_add" ng-click="addDepartment()">Add</a></li>
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
            
            <div id ="contentwrapper" >
                <br>
                <div bind-page ng-bind-html="bindPage" ></div>
                
                
                <!--ul id="bindPage" ng-bind-html="bindPage"></ul-->
                <!--ul id="bindView" ng-view="bindView"></ul-->
            </div>
            
        </div>
        <div class="clear"></div>       
        
        <br>       
        
        <script type="text/javascript" src="${context}/resources/vendors/jquery/js/jquery.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/bootstrap3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/zTree/js/jquery.ztree.all.min.js"></script>
        <!-- angular js -->
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular-route.min.js"></script>       
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular-sanitize.min.js"></script>  
                
        <script type="text/javascript" src="${context}/resources/core/js/app.js"></script>        
        <script type="text/javascript" src="${context}/resources/core/js/service/app_utils.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/service/department_service.js"></script>        
        <script type="text/javascript" src="${context}/resources/core/js/controller/department_controller.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/controller/rootController.js"></script>
        
        <script>            
            
            /*The following function successfully shows how the tree can be created by using recursive method.
             * The generated data can be used for zTree data.
            };*/
            
            
            
            //the upper portion is for testing purpose.
            
            //var zTreeObj;
            // zTree configuration information, refer to API documentation (setting details)
            //var setting = {};   
           
            //jQuery function
            $(document).ready(function(){
                
                //$("#departmentDiv").html("Welcome to using Maple_Tiger_HR System");
                //The required data can be customerized object which includes name, children.
                               
                //
                               
                $("#addButton").click(function(){
                   
                    //$(this).prop("disabled", true);  // this also works well for the current button 
                   
                    //The following works fine for buttons in group with same class type
                    //$(".btn-primary").prop('disabled', true);

                    $("#bindPage").html("the page is loading, please wait...");

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
                    $("#bindPage").load("department/new");
                   
                   
                });
               
            });          
            
        </script>
        
        <jsp:include page="./fragments/footer.jsp"/> 
        
    </body>
</html>
