<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    
    
    <head> 
        <c:set var="context" value="${pageContext.request.contextPath}"/>
        
        <title>mapletiger_HR_System</title>
        
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <!--jsp:include page="./fragments/header.jsp"/-->
        
        <link rel="stylesheet" href="${context}/resources/core/css/zTreeStyle/demo.css" type="text/css">
        <link rel="stylesheet" href="${context}/resources/core/css/zTreeStyle/zTreeStyle.css" type="text/css">
        
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
        
        <spring:url value="/" var="urlHome" />
        <nav class="navbar navbar-inverse ">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="${urlHome}">Home Page</a>
		</div>
		
	</div>
        </nav>
    
    </head>
    <body>
         
        <div id="maincontainer">
            <!-- 3 setup a container element -->
            <div id = "leftcolumn">
                <ul id="treeDemo" class="ztree"></ul>  
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
                
                <ul id ="departmentDiv"></ul>
            </div>
            
        </div>
        <div class="clear"></div>       
        
        <br>       
        
        <script type="text/javascript" src="${context}/resources/core/js/jquery.min.js"></script>
        <script type="text/javascript" src="${context}/resources/core/js/jquery.ztree.core.js"></script>
        
        <script>
            var zTreeObj;
            // zTree configuration information, refer to API documentation (setting details)
            var setting = {};
            // zTree data attributes, refer to the API documentation (treeNode data details)
            var zNodes = [
            {name:"test1", open:true, children:[
               {name:"test1_1"}, {name:"test1_2"}]},
            {name:"test2", open:false, children:[
               {name:"test2_1"}, {name:"test2_2"}]}
            ];
            $(document).ready(function(){
               zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
               
               $("#addButton").click(function(){
                   //alert("request departmentForm.jsp");
                   $("#departmentDiv").load("department/new");
                   //document.location.href="department/new";
               });
               
            });          
            
        </script>
        
        <jsp:include page="./fragments/footer.jsp"/> 
        
    </body>
</html>
