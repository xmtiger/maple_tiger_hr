/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.web;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.EmployeeJsonResponse;
import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.service.HRService;
import com.mikex.maple_tiger_hr.util.GeneralUtils;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author xmtig
 */
@Controller
public class EmployeeController {
    
    @Autowired
    protected HRService hrService;
    
    private final Logger logger = LoggerFactory.getLogger(DepartmentController.class);
    
    private static final String VIEWS_EMPLOYEE_CREATE_OR_UPDATE_FORM = "employee/employeeForm_2A";
    
    @RequestMapping(value = "employee/getCreationOrUpdateFormPage", method = RequestMethod.GET)
    public String getEmployeeCreationOrUpdateFormPage(){
        
        return VIEWS_EMPLOYEE_CREATE_OR_UPDATE_FORM;
    }
    
    @RequestMapping(value = "employee/id/{id}", method = RequestMethod.POST)
    public @ResponseBody Employee findEmployeeById(@PathVariable String id){
        
        Employee employee = new Employee();
        int employee_id = Integer.parseInt(id);
        if(employee_id > 0){
            employee = this.hrService.findEmployeeById(employee_id);
            //return dept;
        }
        return employee;
    }
    
    @RequestMapping(value = "employee/create/Employee/{curId}/Department/{fatherId}", method=RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE})    
    public @ResponseBody EmployeeJsonResponse createOrUpdate_Department(@PathVariable("curId") int curId,
            @PathVariable("fatherId") int fatherId, @RequestBody @Valid Employee employee, BindingResult bindingResult){
        
        EmployeeJsonResponse response = new EmployeeJsonResponse();
        
        if(bindingResult.hasErrors()){
            
            //Get error message
            Map<String, String> errors = bindingResult.getFieldErrors().stream()
               .collect(
                     Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage)
                 );
         
            response.setValidated(false);
            response.setErrorMessages(errors);
            
            return response;
            
        } 
        
        //conversion of time to UTC
        Date birth_date_in = employee.getBirth_date();
        Date birth_date = GeneralUtils.getTime_UTC(birth_date_in);
        employee.setBirth_date(birth_date);
        
        if(curId < 0){
            //check if this new employee has name clash with other existing employees.
            Collection<Employee> employees = this.hrService.findEmployeeByName_Address_BirthDate(employee);
            if(employees.size() > 0){
                Map<String, String> errors = new HashMap<>();
                errors.put("firstName", "The Employee already exists");
                errors.put("lastName", "The Employee already exists");
                
                response.setValidated(false);
                response.setErrorMessages(errors);
            
                return response;
            }
        }
        
        //If vadaltion is passed, firstly, search father department with given fatherDeptId
        //If the fatherDeptId > 0, then find fatherDept
        if(fatherId > 0){
            Department dept = this.hrService.findDepartmentById(fatherId);
            
            employee.setDepartment(dept);
        } 
        
        if(curId > 0){
            //doing update action
            employee.setId(curId);
            this.hrService.saveEmployee(employee);
            
        }else{
            //doing insertion action            
            this.hrService.saveEmployee(employee);
        }
        
        int employeeId = employee.getId();

        logger.debug("employeeId = " + employeeId + "===============================================");

        response.setValidated(true);
        response.setEmployee(employee);
        
        return response;
    }
      
}
