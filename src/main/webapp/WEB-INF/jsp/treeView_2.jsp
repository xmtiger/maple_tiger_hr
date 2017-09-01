<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" >    
    
    <head>        
        
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <c:set var="context" value="${pageContext.request.contextPath}"/>
        <title>mapletiger_HR_System</title>
        
        <!--jsp:include page="./fragments/header.jsp"/-->        
        
        <!--link rel="stylesheet" href="/resources/vendors/angularJS/css/angular-material.min.css"/--> 
        
        <link rel="stylesheet" href="${context}/resources/vendors/bootstrap3.3.7/css/bootstrap.min.css" type="text/css"/>
          
        <link rel="stylesheet" href="${context}/resources/vendors/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
        
        <!-- angularjs ui.grid css -->             
        <link rel="stylesheet" href="${context}/resources/vendors/ui-grid/css/ui-grid.min.css"/> 
            
        <!-- css for d3, nv.d3 and c3 shall be chosen one of them -->
        <link rel="stylesheet" href="${context}/resources/vendors/D3/css/nv.d3.min.css"/>
        
        <link rel="stylesheet" href="${context}/resources/vendors/D3/css/c3.min.css"/>
        
        <style type="text/css">
            .xm-grid {
                width: 500px;
                height: 300px;
                overflow: auto;
            }
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

                    <li class="dropdown" ng-controller="departmentNavMenuController">
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
    
    
         
        <div id="maincontainer" class="container-fluid" >
            <div class="row">
                <!-- 3 setup a container element -->
                <div id = "leftcolumn" class="col-md-2 col-lg2" >


                    <div style="height:300px; min-height:0px; max-height: 75%; border: 1px solid black; overflow: auto;">
                        <ul ztree id="xmTreeView" class="ztree" ng-model ="selectNode"></ul>  
                    </div>  

                    <br>
                    <div class="btn-group">
                        <button id="addButton" type="button" class="btn btn-primary" >Add</button>
                        <button id="editButton" type="button" class="btn btn-primary">Edit</button>
                        <button id="removeButton" type="button" class="btn btn-primary">Remove</button>
                    </div>

                    <form >
                        <br>
                        Search <input id="search_tree" type="text" /> 
                    </form>

                    <br>
                    <div flex uib-alert ng-class="'alert-' + (alert.type || 'warning')" >{{alert.msg}}</div>

                    <jsp:include page="./fragments/footer.jsp"/> 
                </div>   
            
                <div id ="contentwrapper" class="col-md-10 col-lg-10">

                    <div class="row">     
                        
                        <div bind-page ng-bind-html="bindPage" class="col-md-6 col-lg-6" ></div>         
                    

                        <div  ng-controller="MainGridController" class="col-md-10 col-lg-10">
                            <div class="row">
                                <div class="col-md-5 col-lg-5">
                                    <div ui-grid="mainGridOne" class="xm-grid" ng-show="showMainGridOne" ></div>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <div ui-grid="mainGridTwo" class="xm-grid" ng-show="showMainGridTwo" ></div>
                                </div>
                            </div>
                        </div>

                        <!-- D3 graph --> 
                        <div>
                        <br><br>
                        </div>
                        
                        <div class="col-md-9 col-lg-9">

                                <!--div class="col" ng-controller="D3PieChartController" ng-show="false">
                                    <nvd3 options="options" data="data" ></nvd3>
                                </div--> 

                                <div class="row">
                                    <div id="C3PieChart" class="col-md-4 col-lg-4" ng-controller="C3PieChartController" ng-init="showGraph()" ng-show="showPieChat" ></div>


                                    <div id="C3BarChart" class="col-md-4 col-lg-4" ng-controller="C3BarChartController" ng-init="showGraph()" ng-show="showBarChat" ></div>
                                </div>


                        </div>
                        
                    </div>
                </div>
                
            </div>
        </div>
        <!--div class="clear"></div-->       
        
        <br>       
        <!-- jQuery and related plug-in components-->
        <script type="text/javascript" src="${context}/resources/vendors/jquery/js/jquery.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/bootstrap3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/zTree/js/jquery.ztree.all.min.js"></script>
        <!-- angular js -->
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular.min.js"></script>        
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular-route.min.js"></script>       
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular-sanitize.min.js"></script>  
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/angular-animate.min.js"></script>
        <!--script type="text/javascript" src="/resources/vendors/angularJS/js/angular-material.min.js"></script-->
        <!-- angular ui bootstrap -->
        <script type="text/javascript" src="${context}/resources/vendors/angularJS/js/ui-bootstrap-tpls-2.5.0.min.js"></script>
        <!-- angularjs ui.grid -->
        <script type="text/javascript" src="${context}/resources/vendors/cvs/js/csv.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/pdfmake/js/pdfmake.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/pdfmake/js/vfs_fonts.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/ui-grid/js/ui-grid.min.js"></script>
        <!-- D3 series -->
        <script type="text/javascript" src="${context}/resources/vendors/D3/js/d3.min.js" charset="utf-8"></script>
        <!-- nv.d3-->
        <script type="text/javascript" src="${context}/resources/vendors/D3/js/nv.d3.min.js"></script>
        <script type="text/javascript" src="${context}/resources/vendors/D3/js/angular-nvd3.min.js"></script>
        <!-- c3 -->
        <script type="text/javascript" src="${context}/resources/vendors/D3/js/c3.min.js"></script>
        <!-- application js by using angularjs framework -->        
        <script type="text/javascript" src="${context}/resources/core/js/app.js"></script>        
        <script type="text/javascript" src="${context}/resources/core/js/service/app_utils.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/service/department_service.js"></script>        
        <script type="text/javascript" src="${context}/resources/core/js/controller/departmentNavMenuController.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/controller/rootController.js"></script>                
        
        
    </body>
</html>