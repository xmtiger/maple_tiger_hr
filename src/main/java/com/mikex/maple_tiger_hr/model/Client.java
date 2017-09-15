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
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author MikeX
 */
@Entity
@Table(name = "clients")
public class Client extends NamedEntity{
    
    @Column(name = "address")
    private String address;
    
    @Column(name = "city")
    private String city;
    
    @Column(name = "province")
    private String province;
    
    @Column(name = "country")
    private String country;
    
    @Column(name = "postcode")
    private String postcode;
    
    @Column(name = "description")
    private String description;
    
    @Column(name = "office_phone")
    private String office_phone;
    
    @Column(name = "fax")
    private String fax;
     
    @Column(name = "website")
    private String website;
    
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "clients_contacts", joinColumns = @JoinColumn(name = "contact_id"), 
            inverseJoinColumns = @JoinColumn(name = "client_id"))
    @JsonIgnore
    private Set<PersonContact> contacts;
    
    //mappedBy means the class field name of the class 'Project'
    @OneToMany(mappedBy = "client", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<Project> projects;

    

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public Set<PersonContact> getContacts() {
        return contacts;
    }

    public void setContacts(Set<PersonContact> contacts) {
        this.contacts = contacts;
    }
    
    
}
