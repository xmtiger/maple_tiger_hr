/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Digits;

import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author xmtig
 */
@Entity
@Table(name = "employee")
public class Employee extends Person {
         
    @Column(name = "home_address")
    private String home_address;
    
    @Column(name = "phone_mobile")
    @Digits(fraction = 0, integer = 10)
    private String phone_mobile;

    
    public String getHome_address() {
        return home_address;
    }

    public void setHome_address(String home_address) {
        this.home_address = home_address;
    }

    public String getPhone_mobile() {
        return phone_mobile;
    }

    public void setPhone_mobile(String phone_mobile) {
        this.phone_mobile = phone_mobile;
    }
    
}
