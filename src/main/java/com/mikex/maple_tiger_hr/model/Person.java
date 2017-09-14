/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.validator.constraints.NotEmpty;

import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author xmtig
 */
@MappedSuperclass
public class Person extends BaseEntity {
    
    @Column(name = "first_name")
    @NotEmpty(message="Enter first name.")
    protected String firstName;
    
    @Column(name="middle_name")
    protected String middleName;
    
    @Column(name = "last_name")
    @NotEmpty(message="Enter last name")
    protected String lastName;
    
    @Column(name = "birth_date")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    protected Date birth_date;
    
    @Column(name = "gender")
    @Enumerated(EnumType.STRING)
    protected Gender gender;  //0: female, 1: male
    
    @Column(name = "home_address")
    protected String home_address;
    
    @Column(name = "city")
    protected String city;
    
    @Column(name = "province")
    protected String province;
    
    @Column(name = "country")
    protected String country;
    
    @Column(name = "postcode")
    protected String postcode;
    
    @Column(name = "office_email")
    protected String office_email;
    
    @Column(name = "personal_email")
    protected String personal_email;
    
    @Column(name = "home_phone")
    protected String home_phone;
    
    @Column(name = "mobile_phone")
    protected String mobile_phone;
    
    @Column(name = "fax")
    protected String fax;

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getHome_address() {
        return home_address;
    }

    public void setHome_address(String home_address) {
        this.home_address = home_address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getOffice_email() {
        return office_email;
    }

    public void setOffice_email(String office_email) {
        this.office_email = office_email;
    }

    public String getPersonal_email() {
        return personal_email;
    }

    public void setPersonal_email(String personal_email) {
        this.personal_email = personal_email;
    }

    public String getHome_phone() {
        return home_phone;
    }

    public void setHome_phone(String home_phone) {
        this.home_phone = home_phone;
    }

    public String getMobile_phone() {
        return mobile_phone;
    }

    public void setMobile_phone(String mobile_phone) {
        this.mobile_phone = mobile_phone;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }
    
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }    

    public Date getBirth_date() {
        return birth_date;
    }

    public void setBirth_date(Date birth_date) {
        this.birth_date = birth_date;
    }

    @Override
    public String toString() {
        return "Person{" + "firstName=" + firstName + ", lastName=" + lastName + ", birth_date=" + birth_date + '}';
    }
    
}
