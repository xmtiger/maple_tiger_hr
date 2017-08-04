<%-- 
    Document   : treeView
    Created on : Aug 4, 2017, 3:12:45 PM
    Author     : MikeX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Tree View Page</title>
        
        
        <link rel="stylesheet" href="resources/core/css/zTreeStyle/demo.css" type="text/css">
        <link rel="stylesheet" href="resources/core/css/zTreeStyle/zTreeStyle.css" type="text/css">
    </head>
    <body>
        <h1>Tree View</h1>
        
        <!-- 3 setup a container element -->
        <div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
        
        <button>demo button</button>
        <br>
        <form>
            <br>
            Search <input id="search_tree" type="text" /> 
        </form>
        <br>
        
        <div id="jstree"></div>        
        
        <script type="text/javascript" src="resources/core/js/jquery-3.2.1.js"></script>
        <script type="text/javascript" src="resources/core/js/jquery.ztree.core.js"></script>
        
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
            });
        </script>
        
    </body>
</html>
