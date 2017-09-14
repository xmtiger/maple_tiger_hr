/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package maple_tiger_hr.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.model.DepartmentJsonResponse;
import com.mikex.maple_tiger_hr.model.Employee;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import static org.assertj.core.api.Assertions.assertThat;
import org.junit.Test;

/**
 *
 * @author xmtig
 */
public class JasonTests {
    
    @Test
    public void testObj2Jason() throws ParseException, JsonProcessingException{
        
        ObjectMapper mapper = new ObjectMapper();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        mapper.setDateFormat(df);
        
        int id = 0;       
        Employee employee01 = new Employee();
        
        Department dept01 = new Department();
        dept01.setId(id++);
        dept01.setName("Management");
        dept01.setAddress("121 willibrord, verdun, Q.C");        
        dept01.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        dept01.addEmployee(employee01);
        
        String jasonInString = mapper.writeValueAsString(dept01);
        System.out.println(jasonInString);
        
        jasonInString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(dept01);
        System.out.println("\n" + jasonInString);
        
        assertThat(jasonInString.isEmpty()).isFalse();
        
        //test Employee to jason
        
        employee01.setId(0);
        employee01.setFirstName("Tom");
        employee01.setLastName("Jaskson");
        employee01.setMobile_phone("1233213236");
        employee01.setBirth_date((new SimpleDateFormat("YYYY-MM-dd").parse("1987-08-01")));
        employee01.setHome_address("565 Springland, Montreal, Q.C");
        employee01.setDepartment(dept01);
        
        jasonInString = mapper.writeValueAsString(employee01);
        System.out.println(jasonInString);
        
        jasonInString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(employee01);
        System.out.println("\n" + jasonInString);
        
        assertThat(jasonInString.isEmpty()).isFalse();
    }
    
    @Test
    public void testJason2Obj() throws IOException{
        ObjectMapper mapper = new ObjectMapper();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        mapper.setDateFormat(df);
        
        String jasonInString = "{\"id\":0,\"name\":\"Management\",\"begin_time\":\"2017-01-01\",\"end_time\":null,\"address\":\"121 willibrord, verdun, Q.C\"}";
        
        Department dept01 = mapper.readValue(jasonInString, Department.class);
        
        assertThat(dept01.getName()).isNotEmpty();
        System.out.println("dept01:" + dept01.toString());
        
        jasonInString = "{\n" +
                        "  \"id\" : 0,\n" +
                        "  \"firstName\" : \"Tom\",\n" +
                        "  \"lastName\" : \"Jaskson\",\n" +
                        "  \"birth_date\" : \"1986-12-28\",\n" +
                        "  \"home_address\" : \"565 Springland, Montreal, Q.C\",\n" +
                        "  \"mobile_phone\" : \"1233213236\",\n" +
                        "  \"department\" : {\n" +
                        "    \"id\" : 0,\n" +
                        "    \"name\" : \"Management\",\n" +
                        "    \"begin_time\" : \"2017-01-01\",\n" +
                        "    \"end_time\" : null,\n" +
                        "    \"address\" : \"121 willibrord, verdun, Q.C\"\n" +
                        "  }\n" +
                        "}";
        
        Employee employee01 = mapper.readValue(jasonInString, Employee.class);
        assertThat(employee01.getLastName()).isNotNull();
        System.out.println("employee name: " + employee01.getFirstName() + " " + employee01.getLastName());
    }
    
    @Test
    public void testJson2Obj2() throws IOException{
        ObjectMapper mapper = new ObjectMapper();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        mapper.setDateFormat(df);
        
        String jasonInString = "{\"name\":\"joe\", \"address\": \"123 springland\", \"begin_time\": \"2015-06-01\"}";
        
        Department dept01 = mapper.readValue(jasonInString, Department.class);
        
        assertThat(dept01.getName()).isNotNull();
        System.out.println("dept01:" + dept01.toString());
    }
}
