/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.service;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.util.TreeNode;
import org.springframework.dao.DataAccessException;

import java.util.Collection;
import java.util.Date;

/**
 *
 * @author xmtig
 */
public interface HRService {
    
    Employee findEmployeeById(int id) throws DataAccessException;
    
    void saveEmployee(Employee employee) throws DataAccessException;
    
    Collection<Employee> findEmployeeByLastName(String lastName) throws DataAccessException;
    
    Department findDepartmentById(int id) throws DataAccessException;
    
    void deleteDepartment(Department department) throws DataAccessException;
    
    Collection<Department> findDepartmentByName(String name) throws DataAccessException;
    
    Collection<Department> findDepartmentByName_Address_BeginTime(String name, String address, Date beginTime) throws DataAccessException;
        
    void saveDepartment(Department department) throws DataAccessException;
    
    Collection<Department> findAllDepartments() throws DataAccessException;
    
    TreeNode<Department> getTreeFromDepartments();
}
