/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.jdbc;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.repository.DepartmentRepository;
import com.mikex.maple_tiger_hr.repository.EmployeeRepository;
import com.mikex.maple_tiger_hr.util.EntityUtils;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
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
    private DepartmentRepository departmentRepository;
    
    @Autowired
    public JdbcEmployeeRepositoryImpl(DataSource dataSource){
        
        this.insertEmployee = new SimpleJdbcInsert(dataSource)
                .withTableName("employees")
                .usingGeneratedKeyColumns("id");
        
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
        
        this.departmentRepository = departmentRepository;
    }
    
    @Override
    public Collection<Employee> findByLastName(String lastName) throws DataAccessException {
        Map<String, Object> params = new HashMap<>();
        params.put("lastName", lastName + "%");
        List<Employee> employees = this.namedParameterJdbcTemplate.query(
                "SELECT id, first_name, last_name, birth_date, home_address, phone_mobile, dept_id FROM employees WHERE last_name like :lastName",
                params,
                new JdbcEmployeeRowMapper()
        );
        
        return employees;
    }

    @Override
    public Employee findById(int id) throws DataAccessException {
        
        Employee employee;
        
        Integer dept_id;
        try{
            Map<String, Object> params = new HashMap<>();
            params.put("id", id);
            dept_id = this.namedParameterJdbcTemplate.queryForObject("SELECT dept_id FROM employees WHERE id= :id", params,Integer.class);
            
            Department department = this.departmentRepository.findDepartmentById(dept_id);
            
            employee = this.namedParameterJdbcTemplate.queryForObject(
                    "SELECT id, first_name, last_name, birth_date, home_address, phone_mobile, dept_id FROM employees WHERE id = :id", 
                    params, 
                    new JdbcEmployeeRowMapper());
        
            employee.setDepartment(department);
            
            return employee;
        
        } catch(EmptyResultDataAccessException ex) {
            throw new ObjectRetrievalFailureException(Employee.class, id);
        }        
    }

    @Override
    public void save(Employee employee) throws DataAccessException {
        
        if(employee.isNew()){
            Number newKey = this.insertEmployee.executeAndReturnKey(createEmployeeParameterSource(employee));
            employee.setId(newKey.intValue());
        }else {
            this.namedParameterJdbcTemplate.update(
                    "UPDATE employees SET first_name=:firstName, last_name=:lastName, "
                            + "birth_date=:birth_date, home_address=:home_address, "
                            + "phone_mobile=:phone_mobile, dept_id=:dept_id WHERE id=:id", 
                    createEmployeeParameterSource(employee));
        }
    }
    
    private MapSqlParameterSource createEmployeeParameterSource(Employee employee){
        return new MapSqlParameterSource()
                .addValue("id", employee.getId())
                .addValue("firstName", employee.getFirstName())
                .addValue("lastName", employee.getLastName())
                .addValue("birth_date", employee.getBirth_date())
                .addValue("home_address", employee.getHome_address())
                .addValue("phone_mobile", employee.getMobile_phone())
                .addValue("dept_id", employee.getDepartment().getId());
    }
    
    class JdbcEmployeeRowMapper implements RowMapper<Employee>{

        @Override
        public Employee mapRow(ResultSet rs, int i) throws SQLException {
            
            Employee employee = new Employee();
            employee.setId(rs.getInt("id"));
            employee.setFirstName(rs.getString("first_name"));
            employee.setLastName(rs.getString("last_name"));
            Date birthDate = rs.getDate("birth_date");
            employee.setBirth_date(new Date(birthDate.getTime()));
            employee.setHome_address(rs.getString("home_address"));
            employee.setMobile_phone(rs.getString("phone_mobile"));
            return employee;
            //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }
        
    }
}
