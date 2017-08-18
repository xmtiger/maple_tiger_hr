/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
'use strict';

var app_utils = angular.module("app_utils", []);
var app_department = angular.module("app_department", ["app_utils"]);
var app = angular.module("app",["app_department"]);

// Two-way bound treeView
//树形结构 
app.directive('tree',function(){ 
    return{ 
        require:'?ngModel', 
        restrict:'A', 
        link:function($scope,element,attrs,ngModel){ 
            var setting = { 

                callback:{ 
                    beforeClick:function(treeId, treeNode) {//点击菜单时进行的处理 
                        var zTree = $.fn.zTree.getZTreeObj("tree"); 

                    } 
                } 
            }; 
            //向控制器发送消息，进行菜单数据的获取 
            $scope.$emit("menu",attrs["value"]);//此处attrs["value"]为ul中的value值，此处作为标记使用 
            //接受控制器返回的菜单的消息 
            $scope.$on("menuData",function(event,data){ 
                $.fn.zTree.init(element, setting, data);//进行初始化树形菜单 
                var zTree = $.fn.zTree.getZTreeObj("tree"); 
                var selectName = $("#selectName").val(); 
                if(typeof selectName == "undefined" || selectName == ""){ 
                    zTree.selectNode(zTree.getNodeByParam("id","1"));//默认第一个选中 
                    $("#selectName").val(zTree.getSelectedNodes()[0].code);//赋值 
                }else{ 
                    for(var i =0; i<data.length;i++){ 
                        if(data[i]["code"] == selectName ){ 
                            zTree.selectNode(zTree.getNodeByParam("code", data[i]["code"])); 
                        } 
                    } 
                } 
            }); 

        } 
    } 
}); 