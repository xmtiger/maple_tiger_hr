/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package maple_tiger_hr.service;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.service.HRService;
import com.mikex.maple_tiger_hr.util.TreeNode;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.Collection;
import java.util.Date;
import java.util.List;
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
    public void shouldFindDepartmentByName(){
        Collection<Department> departments = this.hrService.findDepartmentByName("engineering");
        assertThat(departments.size()).isEqualTo(1);
    }
    
    
    @Test 
    public void shouldDeleteDepartmentById(){
        
    }
    
    @Test
    public void shouldFindDepartmentByName_Address_BeginTime(){
        String name = "engineering";
        //String address = "233 willibrord St.";
        String address = "";
        Date beginTime = null;
        
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            beginTime = dateFormat.parse("1990-03-01");
            Date tmpTime = null;
            Collection<Department> departments = this.hrService.findDepartmentByName_Address_BeginTime(name, address, tmpTime);
                 
            assertThat(departments.size()).isEqualTo(1);
            
        } catch (ParseException ex) {
            Logger.getLogger(AbstractHRServiceTests.class.getName()).log(Level.SEVERE, null, ex);
        }       
    }
    
    @Test
    public void shouldFindAllDepartments(){
        Collection<Department> departments = this.hrService.findAllDepartments();
        assertThat(departments.size()).isGreaterThan(2);
    }    
    
    @Test
    @Transactional
    public void shouldInsertMultipleDepartments2(){
        
        List<Integer> newIdList = new ArrayList<>();
        
        for(int i=0; i < 2; i++){
            Department fatherDept = this.hrService.findDepartmentById(6);
                
            Department dept = new Department();
            dept.setName("Civil" + i);
            dept.setAddress("123 Springland, Verdun, Q.C");
            dept.setFather(fatherDept);

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date date = dateFormat.parse("1971-07-06");
                dept.setBegin_time(date);
            } catch (ParseException ex) {
                Logger.getLogger(AbstractHRServiceTests.class.getName()).log(Level.SEVERE, null, ex);
            }

            this.hrService.saveDepartment(dept);
            assertThat(dept.getId().intValue()).isNotEqualTo(0);   
            newIdList.add(dept.getId());
        } 
         
        Department fatherDept = this.hrService.findDepartmentById(newIdList.get(0));
                
        Department dept = new Department();
        dept.setName("Civil_11");
        dept.setAddress("123 Springland, Verdun, Q.C");
        dept.setFather(fatherDept);

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = dateFormat.parse("1971-07-06");
            dept.setBegin_time(date);
        } catch (ParseException ex) {
            Logger.getLogger(AbstractHRServiceTests.class.getName()).log(Level.SEVERE, null, ex);
        }

        this.hrService.saveDepartment(dept);
        assertThat(dept.getId().intValue()).isNotEqualTo(0); 
        
        Department fatherDept11 = this.hrService.findDepartmentById(dept.getId());
                
        Department dept11 = new Department();
        dept11.setName("Civil_11_1");
        dept11.setAddress("123 Springland, Verdun, Q.C");
        dept11.setFather(fatherDept11);

        DateFormat dateFormat11 = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = dateFormat11.parse("1971-07-06");
            dept11.setBegin_time(date);
        } catch (ParseException ex) {
            Logger.getLogger(AbstractHRServiceTests.class.getName()).log(Level.SEVERE, null, ex);
        }

        this.hrService.saveDepartment(dept11);
        assertThat(dept11.getId().intValue()).isNotEqualTo(0);
        
        TreeNode<Department> tree = this.hrService.getTreeFromDepartments();
        System.out.println("tree: --------------------------------------------");
        System.out.println(tree);
        System.out.println("tree: --------------------------------------------");
    }
    
    /*
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
        employee.setDepartment(dept);
        
        this.hrService.saveEmployee(employee);
        assertThat(employee.getId().longValue()).isNotEqualTo(0);
        
        Collection<Employee> employees = this.hrService.findEmployeeByLastName("Schultz");
        int found = employees.size();
        assertThat(employees.size()).isEqualTo(1);
    }
    
    @Test
    @Transactional
    public void shouldInsertDepartment(){
        
        Department fatherDept = this.hrService.findDepartmentById(6);
                
        Department dept = new Department();
        dept.setName("Civil Structural");
        dept.setAddress("123 Springland, Verdun, Q.C");
        dept.setFather(fatherDept);
        
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = dateFormat.parse("1971-07-06");
            dept.setBegin_time(date);
        } catch (ParseException ex) {
            Logger.getLogger(AbstractHRServiceTests.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        this.hrService.saveDepartment(dept);
        assertThat(dept.getId().intValue()).isNotEqualTo(0);
        
        Collection<Department> departments = this.hrService.findDepartmentByName("Civil Structural");
        int found = departments.size();
        assertThat(departments.size()).isEqualTo(1);
    } 
    
    @Test
    @Transactional
    public void shouldInsertMultipleDepartments(){
        
        for(int i=0; i < 10; i++){
            Department fatherDept = this.hrService.findDepartmentById(6);
                
            Department dept = new Department();
            dept.setName("Civil Structural" + i);
            dept.setAddress("123 Springland, Verdun, Q.C");
            dept.setFather(fatherDept);

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date date = dateFormat.parse("1971-07-06");
                dept.setBegin_time(date);
            } catch (ParseException ex) {
                Logger.getLogger(AbstractHRServiceTests.class.getName()).log(Level.SEVERE, null, ex);
            }

            this.hrService.saveDepartment(dept);
            assertThat(dept.getId().intValue()).isNotEqualTo(0);

           
        }       
        
        for(int j=0; j < 10; j++){
            Collection<Department> departments = this.hrService.findDepartmentByName("Civil Structural" + j);
            int found = departments.size();
            assertThat(departments.size()).isEqualTo(1);
        }
        
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
    
    @Test
    @Transactional
    public void shouldUpdateDepartment(){
        Department department = this.hrService.findDepartmentById(1);
        String oldName = department.getName();
        String newName = oldName + "X";
        
        department.setName(newName);
        this.hrService.saveDepartment(department);
        
        department = this.hrService.findDepartmentById(1);
        assertThat(department.getName()).isEqualTo(newName);
    }*/
}
