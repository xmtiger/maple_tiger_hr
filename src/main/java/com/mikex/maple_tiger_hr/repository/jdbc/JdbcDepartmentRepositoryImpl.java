/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.jdbc;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.repository.DepartmentRepository;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.orm.ObjectRetrievalFailureException;
import org.springframework.stereotype.Repository;

/**
 *
 * @author MikeX
 */
@Repository
public class JdbcDepartmentRepositoryImpl implements DepartmentRepository{

    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    
    private SimpleJdbcInsert insertDepartment;
 
    @Autowired
    public JdbcDepartmentRepositoryImpl(DataSource dataSource) {
        
        this.insertDepartment = new SimpleJdbcInsert(dataSource).withTableName("departments").usingGeneratedKeyColumns("id");
        
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }
    
    @Override
    public Department findDepartmentById(int id) throws DataAccessException {
        
        Department department;
        try{
            Map<String, Object> params = new HashMap<>();
            params.put("id", id);
            department = this.namedParameterJdbcTemplate.queryForObject(
                    "SELECT id, dept_name, begin_time, end_time, address FROM departments WHERE id = :id", 
                    params, 
                    BeanPropertyRowMapper.newInstance(Department.class));
            
        } catch (EmptyResultDataAccessException ex){
            throw new ObjectRetrievalFailureException(Department.class, id);
        }
        
        return department;
    }    

    @Override
    public void save(Department department) throws DataAccessException {
        
        BeanPropertySqlParameterSource parameterSource = new BeanPropertySqlParameterSource(department);
        if(department.isNew()){
            Number newKey = this.insertDepartment.executeAndReturnKey(parameterSource);
            department.setId(newKey.intValue());
        }else {
            this.namedParameterJdbcTemplate.update(
                    "UPDATE departments SET dept_name=:name, begin_time=:begin_time, end_time=:end_time, address=:address "
                            + "WHERE id=:id", 
                    parameterSource);
        }
    }
    
}
