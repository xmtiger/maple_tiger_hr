/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var Maple_tiger_hr_app = Maple_tiger_hr_app || {};

Maple_tiger_hr_app.backup = (function(){
    


//the following is for testing purpose.
    Department : function(id, name, address, begin_time) {
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

    root = new Department("", "", "", "");
    
    dept01 = new Department("1","Management01", "123 Springland", "2010-09-08");
    
    dept02 = new Department("2","Engineering01", "123 Springland", "2010-09-08");
    dept021 = new Department("3","Civil01", "123 Springland", "2010-09-08");
    dept022 = new Department("4","Structural01", "123 Springland", "2010-09-08");
    
    dept02.children[dept02.children.length] = dept021;
    dept02.children[dept02.children.length] = dept022;

    dept03 = new Department("5","Accounting01", "123 Springland", "2010-09-08");

    root.children[root.children.length] = dept01;
    root.children[root.children.length] = dept02;
    root.children[root.children.length] = dept03;

    root.IfOpenFunc();
    
    ZTree_Node = function(node){
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

    };
    tree_test = new ZTree_Node(root);
    tree_test.childrenFunc(root);

    tree_json = JSON.stringify(tree_test);
    
})();
