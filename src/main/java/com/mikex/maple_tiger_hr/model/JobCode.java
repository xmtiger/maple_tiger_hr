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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author MikeX
 */
@Entity
@Table(name = "job_codes")
public class JobCode extends BaseEntity{
    
    @Column(name = "project_id")
    private String project_id;
    
    @Column(name = "job_code")
    private String job_code;
    
    @Column(name = "description")
    private String description;
    
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "job_codes_assignments", joinColumns = @JoinColumn(name = "assignment_id"), 
            inverseJoinColumns = @JoinColumn(name = "job_code_id"))
    @JsonIgnore
    private Set<EmployeeAssignments> assignments;
}
