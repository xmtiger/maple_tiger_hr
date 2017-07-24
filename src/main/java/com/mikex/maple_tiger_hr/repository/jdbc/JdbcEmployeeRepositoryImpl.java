/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.jdbc;

import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.repository.EmployeeRepository;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
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
 * @author xmtig
 */
@Repository
public class JdbcEmployeeRepositoryImpl implements EmployeeRepository {
    
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    
    private SimpleJdbcInsert insertEmployee;
    
    @Autowired
    public JdbcEmployeeRepositoryImpl(DataSource dataSource){
        
        this.insertEmployee = new SimpleJdbcInsert(dataSource)
                .withTableName("employee")
                .usingGeneratedKeyColumns("id");
        
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }
    
    @Override
    public Collection<Employee> findByLastName(String lastName) throws DataAccessException {
        Map<String, Object> params = new HashMap<>();
        params.put("lastName", lastName + "%");
        List<Employee> employees = this.namedParameterJdbcTemplate.query(
                "SELECT id, first_name, last_name, birth_date, home_address, phone_mobile FROM employee WHERE last_name like :lastName",
                params,
                BeanPropertyRowMapper.newInstance(Employee.class)
        );
        
        return employees;
    }

    @Override
    public Employee findById(int id) throws DataAccessException {
        
        Employee employee;
        try{
            Map<String, Object> params = new HashMap<>();
            params.put("id", id);
            employee = this.namedParameterJdbcTemplate.queryForObject(
                    "SELECT id, first_name, last_name, birth_date, home_address, phone_mobile FROM employee WHERE id= :id", 
                    params, 
                    BeanPropertyRowMapper.newInstance(Employee.class)
            );
        } catch(EmptyResultDataAccessException ex) {
            throw new ObjectRetrievalFailureException(Employee.class, id);
        }
        
        return employee;        
    }

    @Override
    public void save(Employee employee) throws DataAccessException {
        BeanPropertySqlParameterSource parameterSource = new BeanPropertySqlParameterSource(employee);
        if(employee.isNew()){
            Number newKey = this.insertEmployee.executeAndReturnKey(parameterSource);
            employee.setId(newKey.intValue());
        }else {
            this.namedParameterJdbcTemplate.update(
                    "UPDATE employee SET first_name=:firstName, last_name=:lastName, "
                            + "birth_date=:birth_date, home_address=:home_address, "
                            + "phone_mobile=:phone_mobile WHERE id=:id", 
                    parameterSource);
        }
    }
    
}
