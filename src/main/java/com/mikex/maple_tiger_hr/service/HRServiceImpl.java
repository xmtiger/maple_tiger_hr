/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.service;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.repository.DepartmentRepository;
import com.mikex.maple_tiger_hr.repository.EmployeeRepository;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author xmtig
 */
@Service
public class HRServiceImpl implements HRService {
    
    // injection directly to the field
    // for mutiple alternative beans, use @Qualifier to match the injected bean 
    @Autowired
    private EmployeeRepository employeeRepository;
    
    @Autowired
    private DepartmentRepository departmentRepository;
    
    
    /*
    //the first injection method -- inject from constructor
    @Autowired
    public HRServiceImpl(EmployeeRepository employeeRepository, DepartmentRepository departmentRepository){
        this.employeeRepository = employeeRepository;
        this.departmentRepository = departmentRepository;
    }*/
    
    /*
    // the second injection method -- inject from setter method
    @Autowired
    public void setEmployeeRepository(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }
    
    @Autowired
    public void setDepartmentRepository(DepartmentRepository departmentRepository) {
        this.departmentRepository = departmentRepository;
    }*/
    
    

    @Override
    @Transactional(readOnly = true)
    public Employee findEmployeeById(int id) throws DataAccessException {
        return employeeRepository.findById(id);        
    }
    
    @Override
    @Transactional
    public void saveEmployee(Employee employee) throws DataAccessException {
        employeeRepository.save(employee);
    }

    @Override
    @Transactional
    public Collection<Employee> findEmployeeByLastName(String lastName) throws DataAccessException {
        return employeeRepository.findByLastName(lastName);        
    }   

    @Override
    @Transactional(readOnly = true)
    public Department findDepartmentById(int id) throws DataAccessException {
        return departmentRepository.findDepartmentById(id);
    }
    
    @Override
    @Transactional(readOnly = true)
    public Collection<Department> findDeaprtmentByName(String name) throws DataAccessException{
        return departmentRepository.findDepartmentByName(name);
    }
    
    @Override
    @Transactional
    public void saveDepartment(Department department) throws DataAccessException{
        departmentRepository.save(department);
    }
}
