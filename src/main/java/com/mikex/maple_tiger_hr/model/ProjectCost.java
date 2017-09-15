/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author MikeX
 */
@Entity
@Table(name = "project_costs")
public class ProjectCost extends BaseEntity{
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id")
    @JsonIgnore
    private Project project;
    
    @Column(name = "description")
    private String description;
    
    @Column(name = "direct_cost")
    private BigDecimal directCost;
    
    @Column(name = "indirect_cost")
    private BigDecimal indirectCost;
}
