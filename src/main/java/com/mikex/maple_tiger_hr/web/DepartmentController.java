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
import com.mikex.maple_tiger_hr.validator.DepartmentFormValidator;
import java.io.IOException;
import java.text.DateFormat;
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
    
    private final Logger logger = LoggerFactory.getLogger(DepartmentController.class);
    
    //In this program, the ajax and Hiberate validiation are used instead of jstl data binder validation
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
        
    @RequestMapping(value = "department/create", method=RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE})    
    public @ResponseBody DepartmentJsonResponse processCreationForm(@RequestBody @Valid Department dept, BindingResult bindingResult){
        
        DepartmentJsonResponse response = new DepartmentJsonResponse();
        
        if(bindingResult.hasErrors()){
            
            //Get error message
            Map<String, String> errors = bindingResult.getFieldErrors().stream()
               .collect(
                     Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage)
                 );
         
            response.setValidated(false);
            response.setErrorMessages(errors);
        } else{
            // implementing business logic to save data into database
            response.setValidated(true);
            response.setDepartment(dept);
        }     
        
        return response;
        //try {
            /*JsonNode jNodes = mapper.readTree(deptStr);
            Iterator<JsonNode> elements = jNodes.elements();
            while(elements.hasNext()){
                
                JsonNode jNode = elements.next();
                
                JsonNode nameNode = jNode.get("name");
                JsonNode valueNode = jNode.get("value");
                
                String nodeName = nameNode.textValue();
                String nodeValue  = valueNode.textValue();
                System.out.println(nameNode + "; " + nodeValue);
            }              
        } catch (IOException ex) {
             java.util.logging.Logger.getLogger(DepartmentController.class.getName()).log(Level.SEVERE, null, ex);
        }*/       
        
    }
}
