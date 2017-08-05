/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.FetchType;

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
public class Department extends NamedEntity implements Comparable<Department>, Copyable<Department> {
    
    @Column(name = "begin_time")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Date begin_time;
    
    @Column(name = "end_time")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Date end_time;
    
    @Column(name = "address")
    @NotEmpty
    private String address;

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<Employee> employees;
    
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

    @Override
    public boolean copyFrom(Department t){       
        
        this.setName(t.getName());
        this.setAddress(t.getAddress());
        this.setBegin_time(t.getBegin_time());
        this.setEnd_time(t.getEnd_time());
        this.setEmployees(t.getEmployees());
        
        return true;
    }
    
}
