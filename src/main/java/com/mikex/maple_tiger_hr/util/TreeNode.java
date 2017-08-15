/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.util;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.mikex.maple_tiger_hr.model.BaseEntity;
import com.mikex.maple_tiger_hr.model.Copyable;
import com.mikex.maple_tiger_hr.model.Familyable;
import com.mikex.maple_tiger_hr.model.NamedEntity;
import com.mikex.maple_tiger_hr.model.Person;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MikeX
 */
public class TreeNode<T extends Comparable<T> & Familyable<T>> {
    
    /**
   * This node's parent node.  If this is the root of the tree then
   * the parent will be <code>null</code>.
   */         
    @JsonIgnore
    private TreeNode<T> parent;
    
    private T data;
    
    private List<TreeNode<T>> children = new ArrayList<>();
    
    private String dataType;
    
    //Another way is to use interface "Nameable & IdAble", but I decided to use instanceof to do the type conversion...
    @JsonIgnore
    private Integer id;     //To have an id, the T must be child class of BaseEntity 
    
    private String name;    //To have an name, the T must be child class of NamedEntity or Person.

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    
    public TreeNode<T> getParent() {
        return parent;
    }

    public void setParent(TreeNode<T> parent) {
        this.parent = parent;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }
    
    public TreeNode(){
        
    }
    
    public TreeNode(T node){
        data = node;
        dataType = node.getClass().getSimpleName();
        if(node instanceof BaseEntity){
            id = ((BaseEntity)node).getId();
        }
        
        if(node instanceof NamedEntity){
            name = ((NamedEntity)node).getName();
        }else if(node instanceof Person){
            name = ((Person)node).getFirstName() + " " + ((Person)node).getLastName();
        }
    }
    
    public boolean addNode1(TreeNode<T> nodeToBeAdded){
        boolean ifAdded = false;
        
        if(this.data != null && this.dataType != null){
            //compare the current node
            if(this.data.isTheFather(nodeToBeAdded.data)){
                nodeToBeAdded.parent = this;
                return this.children.add(nodeToBeAdded);
                
            }
            
            if(nodeToBeAdded.data.isTheFather(this.data)){
                this.parent.children.add(nodeToBeAdded);
                this.parent.children.remove(this);
                
                this.parent = nodeToBeAdded;
                return nodeToBeAdded.children.add(this);
                              
            }
            
            List<TreeNode<T>> list_children = new ArrayList<>();
            
            for(TreeNode<T> curNode : this.children){
                if(curNode.data.isTheFather(nodeToBeAdded.data)){
                    nodeToBeAdded.parent = curNode;
                    return curNode.children.add(nodeToBeAdded);
                }
                
                if(nodeToBeAdded.data.isTheFather(curNode.data)){
                    //list_children.add(curNode);
                    curNode.parent = nodeToBeAdded;
                    nodeToBeAdded.children.add(curNode);
                    list_children.add(curNode);
                    continue;
                }
                
                //recursive 
                ifAdded = curNode.addNode1(nodeToBeAdded); 
                //if(ifAdded == true)
                //    return true;
            }
            
            if(!list_children.isEmpty()){
                this.children.removeAll(list_children);
                return this.children.add(nodeToBeAdded);
            }
            
        } else{
            //empty, go to next level. 
            // search its children
            List<TreeNode<T>> list_children = new ArrayList<>();
            
            for(TreeNode<T> curNode : this.children){
                if(curNode.data.isTheFather(nodeToBeAdded.data)){
                    nodeToBeAdded.parent = curNode;
                    return curNode.children.add(nodeToBeAdded);
                }
                
                if(nodeToBeAdded.data.isTheFather(curNode.data)){
                    curNode.parent = nodeToBeAdded;
                    nodeToBeAdded.children.add(curNode);
                    list_children.add(curNode);
                    continue;
                }
                
                //recursive 
                ifAdded = curNode.addNode1(nodeToBeAdded);    
                //if(ifAdded == true)
                //    return true;
            }
            
            if(!list_children.isEmpty()){
                this.children.removeAll(list_children);
                return this.children.add(nodeToBeAdded);
            }else{
                return this.children.add(nodeToBeAdded);
            }
        }
        
        return false;
    }
    
    //add the node into the tree, the tree shall have automatically funciton to adjust the branch, leaf, etc..
    public boolean addNode(TreeNode<T> nodeToBeAdded){
        
        boolean ifAdded = false;
                
        //firstly, compare with the current node
        if(this.data != null){
            boolean isFather = this.data.isTheFather(nodeToBeAdded.data);
            if(isFather){
                nodeToBeAdded.parent = this;
                return this.children.add(nodeToBeAdded);
            }  

            boolean isChild = this.data.isTheChildren(nodeToBeAdded.data);
            if(isChild){
                this.parent.children.add(nodeToBeAdded);
                this.parent.children.remove(this);
                
                this.parent = nodeToBeAdded;
                nodeToBeAdded.children.add(this);
                
                return true;
            }
        }       
                
        //then, compare with the children of the current node
        for(TreeNode<T> t: this.children){
            ifAdded = t.addNode(nodeToBeAdded);
            
            if(ifAdded)
                return true;            
        }

        if(!ifAdded && isRoot()){
            if(this.parent != null){
                ifAdded = this.parent.children.add(nodeToBeAdded);
                nodeToBeAdded.parent = this.parent;
            }else{
                ifAdded = this.children.add(nodeToBeAdded);
                nodeToBeAdded.parent = this;
            }            
        }
                
        return ifAdded;
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
            
            // no need for copy
            if(node.data.compareTo(t.data) == 0){                
                node.setData(t.data);
                return true;
                //return node.data.copyFrom(t.data);                
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
