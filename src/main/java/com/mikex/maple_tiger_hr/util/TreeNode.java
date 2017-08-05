/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.util;

import com.mikex.maple_tiger_hr.model.Copyable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MikeX
 */
public class TreeNode<T extends Comparable<T> & Copyable<T>> {
    
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
        
        if(isRoot()){
            child.parent = this;
            return this.children.add(child);
        }
        
        boolean ifChildExist = search(child);
        if(ifChildExist == true)
            return false;
        
        child.parent = this;
        return this.children.add(child);    
        
    }
    
    //remove children nodes; if the node has children nodes, the children nodes will be removed also.
    public boolean removeBranch(TreeNode<T> t){
        for(TreeNode<T> node : children){           
            
            //only remove leaf 
            if(node.data.compareTo(t.data) == 0){                
                node.parent = null; //remove relationship between this node and its parent to prevent memory leak
                return children.remove(node);
                
            }
            
            if(node.removeBranch(t))
                return true;    //if no children, return directly
        }
        return false;
    }
    
    public boolean removeLeaf(TreeNode<T> t){
        
        for(TreeNode<T> node : children){           
            
            //only remove leaf 
            if(node.data.compareTo(t.data) == 0 && node.children.isEmpty()){                
                node.parent = null; //remove relationship between this node and its parent to prevent memory leak
                return children.remove(node);
                
            }
            
            if(node.removeLeaf(t))
                return true;    //if no children, return directly
        }
        return false;
    }
    
    public boolean remove(TreeNode<T> t, boolean ifOnlyRemoveLeaf){
        if(ifOnlyRemoveLeaf)
            return removeLeaf(t);
        else
            return removeBranch(t);
    }
    
    public boolean update(TreeNode<T> t){
        for(TreeNode<T> node : children){           
            
            //only remove leaf 
            if(node.data.compareTo(t.data) == 0){                
                
                return node.data.copyFrom(t.data);                
            }
            
            if(node.update(t))
                return true;    //if no children, return directly
        }
        return false;
    }
    
    
    public boolean search(TreeNode<T> t){
        for(TreeNode<T> node : children){          
            
            //if not found, search its peer 
            if(node.data.compareTo(t.data) == 0){
                return true;
            }           
            
            boolean found = node.search(t);//if no children, return directly
            if(found == true)   //if found in the children, return true directly.
                return true;
        }
        return false;
    }
    
    public boolean isRoot(){
        return (this.parent == null);
    }
    
    public boolean isLeaf(){
        return (this.children.isEmpty());
    }
    
    public boolean isBranch(){
        return (!isRoot() && !isLeaf());
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
        
        if(this.data != null)
            s = inc + data.toString();
        
        for (TreeNode<T> child : this.children) {
            
          //s += "\n" + child.data.toString();
          //child.printTree(increment + INDENT);
          s += "\n" + child.printTree(increment + INDENT);
          
        }
        return s;
    }
}
