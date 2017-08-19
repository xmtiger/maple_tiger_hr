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
        ShallowSearchKeysInJson: ShallowSearchKeysInJson,
        DeepSearchKeysInJson: DeepSearchKeysInJson,
        ContainsKeyValue:ContainsKeyValue,
        FindKeyValue:FindKeyValue
    };

    return factory;

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

}]);