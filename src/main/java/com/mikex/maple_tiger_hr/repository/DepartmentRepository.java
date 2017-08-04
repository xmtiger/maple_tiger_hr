/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository;

import com.mikex.maple_tiger_hr.model.Department;
import org.springframework.dao.DataAccessException;

/**
 *
 * @author MikeX
 */
public interface DepartmentRepository {
    
    Department findDepartmentById(int id) throws DataAccessException;
    
    void save(Department department) throws DataAccessException;
}