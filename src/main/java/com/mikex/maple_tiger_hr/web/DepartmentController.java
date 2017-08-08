/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.web;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.DepartmentJsonResponse;
import com.mikex.maple_tiger_hr.validator.DepartmentFormValidator;
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
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author xmtig
 */
@Controller
public class DepartmentController {
    
    private final Logger logger = LoggerFactory.getLogger(DepartmentController.class);
    
    //@Autowired
    //DepartmentFormValidator departmentFormValidator;
    
    private static final String VIEWS_DEPT_CREATE_OR_UPDATE_FORM = "department/departmentForm01";
    
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
        
    @RequestMapping(value = "department/new", method=RequestMethod.POST)    
    public @ResponseBody DepartmentJsonResponse processCreationForm(@RequestBody Department dept, BindingResult result){
        
        DepartmentJsonResponse response = new DepartmentJsonResponse();
        
        logger.debug("processCreationForm");
                
        if(result.hasErrors()){
            
            Map<String, String> errors = result.getFieldErrors().stream()
                                    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));
            
            response.setValidated(false);
            response.setErrorMessages(errors);
            
        }else{
            //save department into database
            
            response.setValidated(true);
            response.setDepartment(dept);
            
        }
        return response;
    }
}
