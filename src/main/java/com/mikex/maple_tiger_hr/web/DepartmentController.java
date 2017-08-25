/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.web;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.DepartmentJsonResponse;
import com.mikex.maple_tiger_hr.service.HRService;
import com.mikex.maple_tiger_hr.util.TreeNode;
import com.mikex.maple_tiger_hr.validator.DepartmentFormValidator;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.stream.Collectors;
import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author xmtig
 */
@Controller
public class DepartmentController {
    
    @Autowired
    protected HRService hrService;
    
    private final Logger logger = LoggerFactory.getLogger(DepartmentController.class);
    
    //In this program, the ajax and Hiberate validiation are used instead of jstl data binder validation
    //@Autowired
    //DepartmentFormValidator departmentFormValidator;
    
    private static final String VIEWS_DEPT_CREATE_OR_UPDATE_FORM = "department/departmentForm01_1";
    
    /*@InitBinder
    protected void initBinder(WebDataBinder binder){
        logger.debug("initBinder");
        binder.addValidators(departmentFormValidator);
    }*/
    
    @RequestMapping(value = "department/new", method = RequestMethod.GET)
    public String initCreationForm(Map<String, Object> model){
        
        logger.debug("initCreationForm");
        
        Department dept = new Department();
        model.put("department", dept);
        return VIEWS_DEPT_CREATE_OR_UPDATE_FORM;
    }   
        
    @RequestMapping(value = "department/create/Department/{curId}/Department/{fatherId}", method=RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE})    
    public @ResponseBody DepartmentJsonResponse processCreationForm(@PathVariable("curId") int curId,
            @PathVariable("fatherId") int fatherId, @RequestBody @Valid Department dept, BindingResult bindingResult){
        
        DepartmentJsonResponse response = new DepartmentJsonResponse();     
                
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
        
        //If vadaltion is passed, firstly, search father department with given fatherDeptId
        //If the fatherDeptId > 0, then find fatherDept
        if(fatherId > 0){
            Department fatherDept = this.hrService.findDepartmentById(fatherId);
            
            dept.setFather(fatherDept);
            
            if(curId > 0){
                //doing update action
                dept.setId(curId);
                
                this.hrService.saveDepartment(dept);
                
            }else{
                //doing insertion action
                //check if the name alreay exists
                
                this.hrService.saveDepartment(dept);
                
            }
            
            int deptId = dept.getId();

            logger.debug("deptId = " + deptId + "===============================================");

            response.setValidated(true);
            response.setDepartment(dept);
            
        } 
        
        return response;              
    }
    
    @RequestMapping(value = "department/id/{id}", method = RequestMethod.GET)
    public @ResponseBody Department departmentCreateOrUpdate(@PathVariable String id){
        
        Department dept = new Department();
        int dep_id = Integer.parseInt(id);
        if(dep_id > 0){
            dept = this.hrService.findDepartmentById(dep_id);
            //return dept;
        }
        return dept;
    }
    
    @RequestMapping(value = "department/all", method = RequestMethod.POST)
    public @ResponseBody TreeNode<Department> showAllDepartments() throws ParseException{
        
        TreeNode<Department> departments = this.hrService.getTreeFromDepartments();
        return departments;
    }
}
