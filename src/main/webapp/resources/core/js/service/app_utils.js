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

}]);