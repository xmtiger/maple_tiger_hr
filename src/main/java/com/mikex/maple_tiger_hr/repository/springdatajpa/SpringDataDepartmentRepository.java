/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.springdatajpa;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.repository.DepartmentRepository;
import java.util.Collection;

import org.springframework.dao.DataAccessException;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;


/**
 *
 * @author xmtig
 */
public interface SpringDataDepartmentRepository extends DepartmentRepository, Repository<Department, Integer> {    

    @Override
    @Query("SELECT DISTINCT dept FROM Department dept left join fetch dept.employees WHERE dept.id = :id")
    public Department findDepartmentById(@Param("id") int id) throws DataAccessException;
    
    @Override
    @Query("SELECT dept FROM Department dept left join fetch dept.employees WHERE dept.name = :name")
    public Collection<Department> findDepartmentByName(@Param("name") String name) throws DataAccessException;
    
    @Override
    @Query("SELECT dept FROM Department dept")
    public Collection<Department> findAllDepartments() throws DataAccessException ;
}
