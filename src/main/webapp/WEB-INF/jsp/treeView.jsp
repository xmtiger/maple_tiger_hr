<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">    
    
    <head>        
        
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <c:set var="context" value="${pageContext.request.contextPath}"/>
        <title>mapletiger_HR_System</title>
        
        <link rel="stylesheet" href="${context}/resources/bootstrap3.3.7/css/bootstrap.min.css" type="text/css"/>
        <!--jsp:include page="./fragments/header.jsp"/-->        
        
        <link rel="stylesheet" href="${context}/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
        
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
    
    <body>

        <c:set var="urlHome" value="${context}" />
        <nav class="navbar navbar-inverse ">
            <div class="container-fluid">
                
                <div class="navbar-header">
                    <a class="navbar-brand" href="${urlHome}">Home Page</a>
                </div>
                
                <ul class="nav navbar-nav">

                    <li class="dropdown">
                        <a id="department_menu" class="dropdown-toggle" data-toggle="dropdown" href="#" >DEPARTMENT<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Page 1-1</a></li>
                            <li><a href="#">Page 1-2</a></li>
                            <li><a href="#">Page 1-3</a></li>
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
                        <ul id="treeDemo" class="ztree"></ul>  
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
        
        <script type="text/javascript" src="${context}/resources/core/js/jquery.min.js"></script>
        <script type="text/javascript" src="${context}/resources/bootstrap3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${context}/resources/zTree/js/jquery.ztree.all.min.js"></script>
        
        <script>
            /*Search if the key exists in the indicated object. 
             * Use maxSerchLeves to define how deep the search shall go. 1 means search current level*/
            function ShallowSearchKeysInJson(obj, keyToBeSearched, maxSearchLevels){
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
                
                /*In this function, the TreeNodeConveter objects are made with matching properties from objFromServer
                * It is very important function for showing nodes in ZTree  */
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
            };
            
            //the following is for testing purpose.
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
            
            var root = new Department("", "", "", "");
            var dept01 = new Department("1","Management01", "123 Springland", "2010-09-08");
            var dept02 = new Department("2","Engineering01", "123 Springland", "2010-09-08");
            var dept021 = new Department("3","Civil01", "123 Springland", "2010-09-08");
            var dept022 = new Department("4","Structural01", "123 Springland", "2010-09-08");
            dept02.children[dept02.children.length] = dept021;
            dept02.children[dept02.children.length] = dept022;
            
            var dept03 = new Department("5","Accounting01", "123 Springland", "2010-09-08");
            
            root.children[root.children.length] = dept01;
            root.children[root.children.length] = dept02;
            root.children[root.children.length] = dept03;
            
            root.IfOpenFunc();
            
            /*The following function successfully shows how the tree can be created by using recursive method.
             * The generated data can be used for zTree data.
            };*/
            
            function ZTree_Node(node){
                this.id = node.id;
                this.name = node.name;
                
                this.children = [];
                
                this.IfOpenFunc = function IfHasChildren(node){
                    if(node.children.length > 0)
                        return true;
                    else
                        return false;
                };
                
                this.open = this.IfOpenFunc(node);
                
                this.childrenFunc = function(node){
                    if(node.children.length === 0)
                        return null;
                    else{
                        for(var i=0; i<node.children.length; i++){
                            this.children[i] = new ZTree_Node(node.children[i]);
                            this.children[i].childrenFunc(node.children[i]);
                        }
                    }
                };    
                
            }
            var tree_test = new ZTree_Node(root);
            tree_test.childrenFunc(root);
            
            var tree_json = JSON.stringify(tree_test);
            $("#departmentDiv").html(tree_json);
            //the upper portion is for testing purpose.
            
            var zTreeObj;
            // zTree configuration information, refer to API documentation (setting details)
            var setting = {};
            // zTree data attributes, refer to the API documentation (treeNode data details)
            /*var zNodes = [
            {name:"test1", open:true, children:[
               {name:"test1_1"}, {name:"test1_2"}]},
            {name:"test2", open:false, children:[
               {name:"test2_1"}, {name:"test2_2"}]}
            ];*/         
            
            // The following node definition successfully shows the standard zTree node definition
            /*var zNodes_Dept = [
                {name:dept01.name, open:false},
            {name:dept02.name, open:true, children:[
               {name:dept021.name}, {name:dept022.name}]},
            {name:dept03.name, open:false}
            ];*/
           
            //jQuery function
            $(document).ready(function(){
                //The required data can be customerized object which includes name, children.
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, tree_test);
                
                //click of deparment menu
                $("#department_menu").click(function(e){
                    //e.preventDefault();
                    $("#departmentDiv").html("click department menu");
                });
                
                //
                $("#editButton").click(function(){
                    //The follwing section shows how to load data from server
                    var request = "department/" + "all";
                    
                    //The following load function successfully shows how the load function works
                    /*$("#departmentDiv").load(request, function(res, status, xhr){
                        if(status === "success"){
                            $("#departmentDiv").html(res);
                        }
                    });*/
                    
                    $.get(request, function(res, status){
                        if(status === "success"){
                            
                            //$("#departmentDiv").html(JSON.stringify(res));
                            
                            var tree_nodes = new TreeNodeConverter(res);
                            tree_nodes.childrenFunc(res);                            
                            
                            $("#departmentDiv").html(JSON.stringify(res));
                            /*reset zTree with data from server*/
                            $.fn.zTree.init($("#treeDemo"), setting, tree_nodes);
                        }
                    });
                });
               
                $("#addButton").click(function(){
                   
                    $(this).prop("disabled", true);  // this also works well for the current button 
                   
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
