/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package maple_tiger_hr.service;

import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.service.HRService;
import java.util.Collection;

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
        
        Employee employee = new Employee();
        employee.setFirstName("Sam");
        employee.setLastName("Schultz");
        employee.setHome_address("1989 Springland street");
        employee.setPhone_mobile("5879998888");
        this.hrService.saveEmployee(employee);
        assertThat(employee.getId().longValue()).isNotEqualTo(0);
        
        Collection<Employee> employees = this.hrService.findEmployeeByLastName("Schultz");
        int found = employees.size();
        assertThat(employees.size()).isEqualTo(found + 1);
    }
}
