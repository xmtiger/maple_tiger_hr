/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.web;

import com.mikex.maple_tiger_hr.service.HRService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author xmtig
 */
@Controller
public class EmployeeController {
    
    @Autowired
    protected HRService hrService;
    
    private final Logger logger = LoggerFactory.getLogger(DepartmentController.class);
    
    private static final String VIEWS_EMPLOYEE_CREATE_OR_UPDATE_FORM = "employee/employeeForm_1A";
    
    @RequestMapping(value = "employee/getCreationOrUpdateFormPage", method = RequestMethod.GET)
    public String getEmployeeCreationOrUpdateFormPage(){
        
        return VIEWS_EMPLOYEE_CREATE_OR_UPDATE_FORM;
    }
}
