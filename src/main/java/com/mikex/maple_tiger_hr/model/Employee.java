/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.Digits;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;

import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author xmtig
 */
@Entity
@Table(name = "employees")
public class Employee extends Person implements Comparable<Employee>, Familyable<Employee> {
         
    //@Column(name = "home_address")
    //private String home_address;
    
    /*@Column(name = "phone_mobile")
    @Digits(fraction = 0, integer = 10)
    private String phone_mobile;*/
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dept_id")
    @JsonIgnore
    private Department department;
    
    //mappedBy means the class field name of the class 'EmployeeJobHistory'
    //FecthType.EAGER is to get associated beans right way, but FetchType.LAZY is to get beans when the beans are required by using explict sql by using fetch join ...
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<EmployeeJobHistory> jobHistory;
    
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<EmployeeSalaryHistory> salaryHistory;
    
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<EmployeeAssignments> assignments;
    
    /*public String getHome_address() {
        return home_address;
    }

    public void setHome_address(String home_address) {
        this.home_address = home_address;
    }*/

    /*public String getPhone_mobile() {
        return phone_mobile;
    }

    public void setPhone_mobile(String phone_mobile) {
        this.phone_mobile = phone_mobile;
    }*/

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    } 

    @Override
    public int compareTo(Employee t) {
        if(this.id.equals(t.id))
            return 0;
        
        return -1;
        
    }

    @Override
    public boolean isTheFather(Employee t) {
        return false;
        
    }

    @Override
    public boolean isTheChildren(Employee t) {
        return false;
    }
    
}
