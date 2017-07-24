/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository;

import com.mikex.maple_tiger_hr.model.Employee;

import java.util.Collection;

import org.springframework.dao.DataAccessException;

/**
 *
 * @author xmtig
 */
public interface EmployeeRepository {
    
    Collection<Employee> findByLastName(String lastName) throws DataAccessException;
    
    Employee findById(int id) throws DataAccessException;
    
    void save(Employee employee) throws DataAccessException;
}
