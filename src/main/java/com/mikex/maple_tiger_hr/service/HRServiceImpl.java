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
import com.mikex.maple_tiger_hr.util.TreeNode;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Iterator;

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
    public Collection<Department> findDepartmentByName(String name) throws DataAccessException{
        return departmentRepository.findDepartmentByName(name);
    }
    
    @Override
    @Transactional
    public void saveDepartment(Department department) throws DataAccessException{
        departmentRepository.save(department);
    }
    
    @Override
    @Transactional
    public Collection<Department> findAllDepartments() throws DataAccessException{
        return departmentRepository.findAllDepartments();
        
    }
    
    @Override
    public TreeNode<Department> getTreeFromDepartments(){
        TreeNode<Department> tree = new TreeNode<>();
        
        Collection<Department> departments = this.departmentRepository.findAllDepartments();
        Iterator<Department> iter_departments = departments.iterator();
        while(iter_departments.hasNext()){
            
            Department curDepartment = iter_departments.next();
            TreeNode<Department> curTreeNode = new TreeNode(curDepartment);
            //add the current node into the tree, and the adding procedure shall be implemented in the methods of the Class TreeNode 
            tree.addNode1(curTreeNode);
        }       
        
        if(tree.getChildren().size() == 1)
            return tree.getChildren().get(0);
        else
            return tree;
    }
    
    public TreeNode getTreeFromDepartmentsWithEmployees(){
        TreeNode<Department> tree = new TreeNode<>();
        
        Collection<Department> departments = this.departmentRepository.findAllDepartments();
        Iterator<Department> iter_departments = departments.iterator();
        while(iter_departments.hasNext()){
            
            Department curDepartment = iter_departments.next();
            TreeNode<Department> curTreeNode = new TreeNode(curDepartment);
            //add the current node into the tree, and the adding procedure shall be implemented in the methods of the Class TreeNode 
            tree.addNode1(curTreeNode);
            
            for(Employee employee : curDepartment.getEmployees()){
                //TreeNode<Employee> curTreeNode_Employee = new TreeNode(employee);
                //curTreeNode.add(curTreeNode_Employee);
            }
        } 
        
        return tree;
    }
}
