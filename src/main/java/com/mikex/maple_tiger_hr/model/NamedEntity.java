/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author xmtig
 */
@MappedSuperclass
public class NamedEntity extends BaseEntity{
    
    @Column(name = "name")
    @NotEmpty(message="Enter a name.")
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    @Override
    public String toString(){
        return this.getName();
    }
}
