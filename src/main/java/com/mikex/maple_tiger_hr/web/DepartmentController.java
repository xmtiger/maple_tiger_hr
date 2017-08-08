/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.web;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.validator.DepartmentFormValidator;
import java.util.Map;
import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author xmtig
 */
@Controller

public class DepartmentController {
    
    private final Logger logger = LoggerFactory.getLogger(DepartmentController.class);
    
    @Autowired
    DepartmentFormValidator departmentFormValidator;
    
    private static final String VIEWS_DEPT_CREATE_OR_UPDATE_FORM = "department/departmentForm";
    
    @InitBinder
    protected void initBinder(WebDataBinder binder){
        logger.debug("initBinder");
        binder.addValidators(departmentFormValidator);
    }
    
    @RequestMapping(value = "department/new", method = RequestMethod.GET)
    public String initCreationForm(Map<String, Object> model){
        
        logger.debug("initCreationForm");
        
        Department dept = new Department();
        model.put("department", dept);
        return VIEWS_DEPT_CREATE_OR_UPDATE_FORM;
    }
        
    @RequestMapping(value = "department/new", method = RequestMethod.POST)
    public String processCreationForm(@Valid Department dept, BindingResult result){
        
        logger.debug("processCreationForm");
        
        if(result.hasErrors()){
            return VIEWS_DEPT_CREATE_OR_UPDATE_FORM;
        }else{
            return VIEWS_DEPT_CREATE_OR_UPDATE_FORM;
        }
    }
}
