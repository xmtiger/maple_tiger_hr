/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.math.BigDecimal;
import java.util.Currency;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author MikeX
 */
@Entity
@Table(name = "employee_salary_history")
public class EmployeeSalaryHistory extends BaseEntity{
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "employee_id")
    @JsonIgnore
    private Employee employee;
    
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
    
    @Column(name = "pay_type")
    @Enumerated(EnumType.STRING)
    private SalaryPayType pay_type;
    
    @Column(name = "currency_type")
    private String currency;
    
    public void setCurrency(Currency currency){
        this.currency = currency.getCurrencyCode();
    }
    
    public Currency getCurrency(){
        return Currency.getInstance(currency);
    }
    
    @Column(name = "base_rate")
    private BigDecimal base_rate;
    
    @Column(name = "overtime_rate")
    private BigDecimal overtime_rate;

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
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

    public SalaryPayType getPay_type() {
        return pay_type;
    }

    public void setPay_type(SalaryPayType pay_type) {
        this.pay_type = pay_type;
    }

    public BigDecimal getBase_rate() {
        return base_rate;
    }

    public void setBase_rate(BigDecimal base_rate) {
        this.base_rate = base_rate;
    }

    public BigDecimal getOvertime_rate() {
        return overtime_rate;
    }

    public void setOvertime_rate(BigDecimal overtime_rate) {
        this.overtime_rate = overtime_rate;
    }
    
    
}
