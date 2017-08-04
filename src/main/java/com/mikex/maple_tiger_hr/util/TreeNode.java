/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.util;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MikeX
 */
public class TreeNode<T extends Comparable<T>> {
    
    /**
   * This node's parent node.  If this is the root of the tree then
   * the parent will be <code>null</code>.
   */
    private TreeNode<T> parent;
    
    private T data;
    
    private List<TreeNode<T>> children = new ArrayList<>();
    
    public TreeNode(){
        
    }
    
    public TreeNode(T node){
        data = node;
    }
    
    public boolean add(TreeNode<T> child){
        
        boolean ifChildExist = search(child);
        if(ifChildExist == true)
            return false;
        
        return this.children.add(child);        
    }
    
    //remove children nodes; if the node has children nodes, the children nodes will be removed also.
    public boolean remove(TreeNode<T> t){
        for(TreeNode<T> node : children){
            
            node.remove(t); //if no children, return directly
            
            if(node.data.compareTo(t.data) == 0){
                return children.remove(node);
            }
        }
        return false;
    }
    
    public boolean search(TreeNode<T> t){
        for(TreeNode<T> node : children){        
            
            boolean found = node.search(t);//if no children, return directly
            if(found == true)   //if found in the children, return true directly.
                return true;
            
            //if not found, search its peer 
            if(node.data.compareTo(t.data) == 0){
                return true;
            }            
        }
        return false;
    }
    
    public boolean isRoot(){
        return (this.parent == null);
    }
    
    public List<TreeNode<T>> getChildren(){
        return this.children;
    }
    
    public boolean hasChildren(){
        return (this.children.size() > 0);
    }
    
    public void setData(T data){
        this.data = data;
    }
    
    public T getData(){
        return this.data;
    }
    
    @Override
    public String toString(){
        return this.printTree(0);
    }
    
    private static final int INDENT = 2;

    private String printTree(int increment) {
        String s = "";
        String inc = "";
        for (int i = 0; i < increment; ++i) {
          inc = inc + " ";
        }
        s = inc + data.toString();
        for (TreeNode<T> child : this.children) {
          s += "\n" + child.printTree(increment + INDENT);
        }
        return s;
    }
}
