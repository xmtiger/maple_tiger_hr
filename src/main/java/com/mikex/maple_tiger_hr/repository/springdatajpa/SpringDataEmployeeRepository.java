/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.springdatajpa;

import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.repository.EmployeeRepository;
import java.util.Collection;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;


/**
 *
 * @author MikeX
 */
public interface SpringDataEmployeeRepository extends EmployeeRepository, Repository<Employee, Integer> {
    
    @Override
    @Query("SELECT DISTINCT employee FROM Employee employee WHERE employee.lastName LIKE :lastName%")
    public Collection<Employee> findByLastName(@Param("lastName") String lastName);
    
    @Override
    @Query("SELECT employee FROM Employee employee WHERE employee.id =:id")
    public Employee findById(@Param("id") int id);
}
