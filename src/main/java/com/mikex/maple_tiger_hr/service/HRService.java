/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.service;

import com.mikex.maple_tiger_hr.model.Employee;
import org.springframework.dao.DataAccessException;

import java.util.Collection;

/**
 *
 * @author xmtig
 */
public interface HRService {
    
    Employee findEmployeeById(int id) throws DataAccessException;
    
    void saveEmployee(Employee employee) throws DataAccessException;
    
    Collection<Employee> findEmployeeByLastName(String lastName) throws DataAccessException;
}
