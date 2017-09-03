/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.beans.support.MutableSortDefinition;
import org.springframework.beans.support.PropertyComparator;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author MikeX
 */
@Entity
@Table(name = "departments")
public class Department extends NamedEntity implements Comparable<Department>, Familyable<Department> {
    
    @Column(name = "begin_time")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date begin_time;
    
    @Column(name = "end_time")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    @JsonIgnore         //to avoid json version error from ajax to controller, when coversion with json data type.
    private Date end_time;
    
    @Column(name = "address")
    @NotEmpty(message="Enter an address.")
    private String address;
    
    //mappedBy means the class field name 
    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    //@JsonIgnore 
    private Set<Employee> employees;
    
    //The following fields are for department relationship
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinTable(name = "department_relationship", joinColumns = @JoinColumn(name = "id_child"),
            inverseJoinColumns = @JoinColumn(name = "id_father"))
    @JsonIgnore //to avoid infinite recursive definition actions.
    private Department father;
    
    @OneToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "department_relationship", joinColumns = @JoinColumn(name = "id_father"),
            inverseJoinColumns = @JoinColumn(name = "id_child"))
    @JsonIgnore //to avoid infinite recursive definition actions.
    private Set<Department> children;

    /*public boolean addChild(Department child){
        if(this.children == null){
            children = new TreeSet<Department>();
        }
        
        return children.add(child);
    }*/
    
    public Department getFather() {
        return father;
    }

    public void setFather(Department father) {
        this.father = father;
    }

    public Set<Department> getChildren() {
        return children;
    }

    public void setChildren(Set<Department> children) {
        this.children = children;
    }   
    
    protected Set<Employee> getEmployeesInternal(){
        if(this.employees == null){
            this.employees = new HashSet<>();
        }
        return this.employees;
    }
    
    protected void setEmployeesInternal(Set<Employee> employees){
        this.employees = employees;
    }    
    
    public void setEmployees(Set<Employee> employees){
        this.employees = employees;
    }
    
    public Set<Employee> getEmployees(){
        //List<Employee> sortedEmployees = new ArrayList<>(getEmployeesInternal());
        //PropertyComparator.sort(sortedEmployees, new MutableSortDefinition("lastName", true, true));
        //return Collections.unmodifiableList(sortedEmployees);
        return employees;
    }
    
    public void addEmployee(Employee employee){
        getEmployeesInternal().add(employee);
        employee.setDepartment(this);
    }
    
    public Employee getEmployee(String lastName){
        return getEmployee(lastName, false);
    }
    
    public Employee getEmployee(String lastName, boolean ignoreNew){
        lastName = lastName.toLowerCase();
        for (Employee employee : getEmployeesInternal()){
            if(!ignoreNew || !employee.isNew()){
                String compName = employee.getLastName();
                compName = compName.toLowerCase();
                if(compName.equals(lastName))
                    return employee;
            }
        }   
        return null;
    }
    
    public Date getBegin_time() {
        return begin_time;
    }

    public void setBegin_time(Date begin_time) {
        this.begin_time = begin_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public int compareTo(Department t) {
        
        if(this.id.equals(t.id) || this.getName().equals(t.getName()))
            return 0;
        else
            return -1;
    }
    
    public boolean copyFrom(Department t){       
        
        this.setName(t.getName());
        this.setAddress(t.getAddress());
        this.setBegin_time(t.getBegin_time());
        this.setEnd_time(t.getEnd_time());
        this.setEmployees(t.getEmployees());
        
        return true;
    }
    
    @Override
    public String toString(){
        return "id: " + getId() + "; name: " + getName() 
                + "; address: " + this.getAddress() 
                + "; begin time: " +  this.getBegin_time();
                
    }

    @Override
    public boolean isTheFather(Department t) {
        if(t == null)
            return false;
        
        if(t.father == null)
            return false;
        
        if( t.father.getId().equals(this.getId()))
            return true;        
        
        /* the same can not be treated as unique name
        if(t.father.getName().equals(this.getName()))
            return true;
        */
        
        return false;
    }

    @Override
    public boolean isTheChildren(Department t) {
        if(t == null)
            return false;
        
        if(this.father == null)
            return false;
        
        
        if(this.father.getId().equals(t.getId()))
                return true;
                
        return false;
    }
}
