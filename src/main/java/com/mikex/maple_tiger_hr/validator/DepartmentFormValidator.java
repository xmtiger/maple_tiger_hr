/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.validator;

import com.mikex.maple_tiger_hr.model.Department;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author xmtig
 */
@Component
public class DepartmentFormValidator implements Validator{
    
    @Autowired
    @Qualifier("emailValidator")
    EmailValidator emailValidator;
    
    @Override
    public boolean supports(Class<?> type) {
        return Department.class.equals(type);
    }

    @Override
    public void validate(Object target, Errors errors) {
        
        Department dept = (Department) target;
        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.form.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address", "NotEmpty.form.address");
    }
    
}
