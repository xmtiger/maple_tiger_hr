/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


//var Maple_tiger_hr_app = Maple_tiger_hr_app || {};

/* Generic Services */                                                                                                                                                                                                    
 'use strict';

angular.module('app_utils').factory('UtilService', [ function(){
            
    var factory = {
        ShallowSearchKeyInJson: ShallowSearchKeyInJson,
        DeepSearchKeyInJson: DeepSearchKeyInJson,
        ContainsKeyValue : ContainsKeyValue,
        FindKeyValue : FindKeyValue,
        TreeNodeConverter : TreeNodeConverter,
        TreeNodesGenerator : TreeNodesGenerator,
        //data filter
        defineGridColumns : defineGridColumns,
        gridDataFilter : gridDataFilter,
        gridDataFilter_ForEmployee: gridDataFilter_ForEmployee
    };

    return factory;
    
    //data filter 
     function defineGridColumns(keysFilter, grid){
        if(typeof grid !== 'object')
            return;
        
        if(Array.isArray(keysFilter) !== true)
            return;
        
        grid.enableSorting = true;
        grid.columnDefs = [];
        for(var i=0; i < keysFilter.length; i++){
            //$scope.gridOption.columnDefs
            var tmpColumnDef = { field : keysFilter[i] };
            grid.columnDefs.push(tmpColumnDef);
        }      
    }
    
    // The input object must have the object "data" which contains the information 
    // this function is to get information from "data" property of the object   
    function gridDataFilter(keysFilter, obj, values){
        
        if(typeof obj !== 'object')
            return;
                
        //only search infomation in the object.data
        if(obj.hasOwnProperty('data') && typeof obj.data === 'object'){
            if(!Array.isArray(keysFilter))
                return;
                        
            if(typeof values !== 'object' && Array.isArray(values) !== true)
                return;

            var tmpVar = {};
            var find = false;

            for(var key in obj.data) {      

                for(var i =0; i < keysFilter.length; i++){
                    if(key === keysFilter[i]){               
                        //dynamically add both property and value to the object, tmpVar.
                        
                        //note: the department date type is @Temporal(TemporalType.DATE), and no need for conversion
                        tmpVar[key] = obj.data[key];                     
                        find = true;
                        //break;
                    }
                }              
            }

            if(find){
                values.push(tmpVar);
            }
        }        
                        
        if(obj.hasOwnProperty('children')){
            for(var j=0; j < obj.children.length; j++){
                gridDataFilter(keysFilter, obj.children[j], values);
            }
        }
    };
    
    // The input object must have the object "data" which contains the information 
    // this function is to get information from "data" property of the object   
    function gridDataFilter_ForEmployee(keysFilter, obj, values){
        
        if(typeof obj !== 'object')
            return;
                
        //only search infomation in the object.data
        if(obj.hasOwnProperty('data') && typeof obj.data === 'object'){
            if(!Array.isArray(keysFilter))
                return;
                        
            if(typeof values !== 'object' && Array.isArray(values) !== true)
                return;

            var tmpVar = {};
            var find = false;
            
            var department = obj.data;
            if(department.hasOwnProperty('employees')){
                for(var i = 0; i < department.employees.length; i++){
                    var employee = department.employees[i];
                                
                    for(var key in employee){
                        
                        for(var j=0; j < keysFilter.length; j++){
                            if(key === keysFilter[j]){
                                //note: the employee birthday is @Temporal(TemporalType.TIMESTAMP)
                                if(key === 'birth_date'){
                                    // The conversion of the date
                                    var date = new Date(parseInt(employee[key]));
                                    var month = date.getUTCMonth();
                                    var day = date.getUTCDate();
                                    if(month < 10)
                                        month = '0' + month;
                                    if(day < 10)
                                        day = '0' + day;
                                    
                                    var date_str = date.getUTCFullYear() + "-" + month + "-" + day;
                                    
                                    tmpVar[key] = date_str;
                                }else{
                                    tmpVar[key] = employee[key]; 
                                }                                                                                
                                
                            }
                        }
                    }
                    
                    tmpVar['department'] = department.name;
                    find = true;
                }
            }

            if(find){
                values.push(tmpVar);
            }
        }        
                        
        if(obj.hasOwnProperty('children')){
            for(var j=0; j < obj.children.length; j++){
                gridDataFilter_ForEmployee(keysFilter, obj.children[j], values);
            }
        }
    }; 
    
    /*Search if the key exists in the indicated object. 
             * Use maxSerchLeves to define how deep the search shall go. 1 means search current level*/
    
    function ShallowSearchKeyInJson(obj, keyToBeSearched, maxSearchLevels){
                
        maxSearchLevels--;
        if(maxSearchLevels < 0 )
            return false;
        
        var find = false;
        
        //note: In javascript, by using angular.forEach function, every "return" is to return higher level of angular.forEach function.
        angular.forEach(obj, function(value, key){
            
            if(find === true)
                return true;
            
            if(key === keyToBeSearched){  
                find = true;
                return true;        //note: this return only jump out forEach function, not the ouside function ShallowSearchKeysInJson(...)
            } 
            
            if((find === false) && (angular.isObject(value) === true)){
                                
                find = ShallowSearchKeyInJson(value, keyToBeSearched, maxSearchLevels);
                
                if(find === true)
                    return true;                
            }
        });          
        
        return find;
    }; 
            

    function DeepSearchKeyInJson(obj, keyToBeSearched){
                
        var find = false;
        
        //note: In javascript, by using angular.forEach function, every "return" is to return higher level of angular.forEach function.
        angular.forEach(obj, function(value, key){
            
            if(find === true)
                return true;
            
            if(key === keyToBeSearched){  
                find = true;
                return true;        //note: this return only jump out forEach function, not the ouside function ShallowSearchKeysInJson(...)
            } 
            
            if((find === false) && (angular.isObject(value) === true)){
                                
                find = DeepSearchKeyInJson(value, keyToBeSearched);
                
                if(find === true)
                    return true;                
            }
        });          
        
        return find;
    };

    //it is required to be tested(2017-08-19)
    function ContainsKeyValue( obj, keyToBeMatched, valueToBeMatched ){
        var find = false;
        
        //note: In javascript, by using angular.forEach function, every "return" is to return higher level of angular.forEach function.
        angular.forEach(obj, function(value, key){
            
            if(find === true)
                return true;
            
            if(key === keyToBeMatched && obj === valueToBeMatched){
                find = true;
                return true;
            }
                                    
            if((find === false) && (angular.isObject(value) === true)){
                
                find = ContainsKeyValue(value, keyToBeMatched, valueToBeMatched);
                
                if(find === true)
                    return true;                
            }
        });          
        
        return find;        
    };
    
    //it is required to be tested(2017-08-19)
    function FindKeyValue( obj, keyToBeMatched, valueToBeFound ){
        //note: In javascript, by using angular.forEach function, every "return" is to return higher level of angular.forEach function.
        var find = {};
        
        angular.forEach(obj, function(value, key){
            
            if(find !== null)
                return find;
            
            
            if (typeof value !== undefined && value !== null) {
                if(key === keyToBeMatched ){
                    find = value;
                    return value;
                }else{
                    return null;
                }
            }
            
            if((find === null) && (angular.isObject(value) === true)){
                
                find = FindKeyValue(value, keyToBeMatched, valueToBeFound);
                
                if(find !== null)
                    return find;                
            }
            
            return find;
        });  
    };  
        
    
    function TreeNodeConverter(objFromServer){
                        
        this.id = -1;       //matching the id in the database table
        this.name = "";     //name property is used by ZTree
        //the objFromServer shall have dataType field, since it is warpped with TreeNode Class
        this.dataType = "";
        //this children array includes both departments and employees
        this.children = [];
        
        this.open = false;  //open property is used by ZTree  
        
        this.UID = "";  //unique id for get node in the tree, and the formate is "dataType/id"
        
        this.setUID = function(type, name, id){
            this.UID = type + "/" + name + "/" + id;
        };
        
        this.getUID = function(){
            //get unique id, the format is dataType/id
            return this.dataType + "/" + this.name + "/" +  this.id;
        };
        
        this.setDataType = function(dataType){
            this.dataType = dataType;
        };
        
        this.getDataType = function(){
            return this.dataType;
        };
        
        this.setName = function(name){
            this.name = name;
        };
        
        this.getName = function(){
            return this.name;
        };
        
        this.setId = function(id){
            this.id = id;
        };
        
        this.getId = function(){
            return this.id;
        };
                
        this.addChild = function(obj){
            if(typeof obj !== TreeNodeConverter)
                return;
                     
            this.children.push(obj);
                        
        };
        
        this.removeChild = function(obj){
            if(typeof obj !== TreeNodeConverter)
                return;
            
            for(var i = 0; i < this.children.length; i++){
                if(this.children[i].id === obj.id && this.children[i].name === obj.name)
                    this.children.splice(i,1);
            }        
            
        };

        /*In this function, the TreeNodeConveter objects are made with matching properties from objFromServer
        * It is very important function for showing nodes in ZTree  */
        this.childrenFunc = function(objFromServer, typeOfBranchOfTree, typeOfLeafOfTree, keyOfLeafOfBranchOfTree){

            if(objFromServer.data !== null){
                this.id = objFromServer.data.id;
                if(objFromServer.dataType === typeOfBranchOfTree){
                    this.name = objFromServer.data.name;
                    this.dataType = objFromServer.dataType;                            
                    
                    this.setUID(this.datType, this.name, this.id);
                    
                    var i = 0;

                    if(objFromServer.children.length !== 0){                   
                        // the children is department object
                        this.open = true;
                        for(; i<objFromServer.children.length; i++){

                            this.children[i] = new TreeNodeConverter(objFromServer.children[i]);                            
                            this.children[i].childrenFunc(objFromServer.children[i], typeOfBranchOfTree, typeOfLeafOfTree, keyOfLeafOfBranchOfTree);

                        }
                    } 

                    var ifKeyEmployeesExist = ShallowSearchKeyInJson(objFromServer, keyOfLeafOfBranchOfTree,2);
                    
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
                            this.children[j+i].setUID(this.children[j+i].dataType, this.children[j+i].name, this.children[j+i].id);
                        }
                    }                                                          

                } 

            }else{
                //for the root "null" object:                        
                if(objFromServer.children.length !== 0){                   
                    this.open = true;

                    for(var i=0; i<objFromServer.children.length; i++){

                        this.children[i] = new TreeNodeConverter(objFromServer.children[i]);
                        this.children[i].parent = this;
                        this.children[i].childrenFunc(objFromServer.children[i], typeOfBranchOfTree, typeOfLeafOfTree, keyOfLeafOfBranchOfTree);

                    }
                }   
            }           

        };    
    };
    
    function TreeNodesGenerator(objFromServer, branchType,leafType, leafKey){
                
        var tree_nodes = new TreeNodeConverter(objFromServer);
        tree_nodes.childrenFunc(objFromServer, branchType, leafType, leafKey);
        return tree_nodes;
    }

}]);