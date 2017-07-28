/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package maple_tiger_hr.service;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.service.HRService;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Collection;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.assertj.core.api.Assertions.assertThat;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author xmtig
 */
public class AbstractHRServiceTests {
    
    @Autowired
    protected HRService hrService;
    
    @Test
    public void shouldFindEmployeeByLastName() {
        Collection<Employee> employees = this.hrService.findEmployeeByLastName("Davis");
        assertThat(employees.size()).isEqualTo(1);            
    }
    
    @Test
    @Transactional
    public void shouldInsertEmployee(){
        
        Department dept = this.hrService.findDepartmentById(2);
        
        
        Employee employee = new Employee();
        employee.setFirstName("Sam");
        employee.setLastName("Schultz");        
        
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = dateFormat.parse("1971-07-06");
            employee.setBirth_date(date);
        } catch (ParseException ex) {
            Logger.getLogger(AbstractHRServiceTests.class.getName()).log(Level.SEVERE, null, ex);
        }
                
        employee.setHome_address("1989 Springland street");
        employee.setPhone_mobile("5879998888");
        employee.setDept(dept);
        
        this.hrService.saveEmployee(employee);
        assertThat(employee.getId().longValue()).isNotEqualTo(0);
        
        Collection<Employee> employees = this.hrService.findEmployeeByLastName("Schultz");
        int found = employees.size();
        assertThat(employees.size()).isEqualTo(1);
    }
    
    @Test
    @Transactional
    public void shouldUpdateEmployee(){
        Employee employee = this.hrService.findEmployeeById(1);
        String oldLastName = employee.getLastName();
        String newLastName = oldLastName + "X";
        
        employee.setLastName(newLastName);
        this.hrService.saveEmployee(employee);
        
        // retrieving new name from database
        employee = this.hrService.findEmployeeById(1);
        assertThat(employee.getLastName()).isEqualTo(newLastName);
    }
}
