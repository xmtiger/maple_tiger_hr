/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.jpa;

import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.repository.EmployeeRepository;
import java.util.Collection;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

/**
 *
 * @author MikeX
 */
@Repository
public class JpaEmployeeRepositoryImpl implements EmployeeRepository{
    
    @PersistenceContext
    private EntityManager em;

    @Override
    public Collection<Employee> findByLastName(String lastName) throws DataAccessException {
        
        Query query = this.em.createQuery("SELECT employee FROM Employee employee WHERE employee.lastName LIKE :lastName");
        query.setParameter("lastName", lastName + "%");
        return query.getResultList();
    }

    @Override
    public Employee findById(int id) throws DataAccessException {
        
        //Query query = this.em.createQuery("SELECT employee FROM Employee employee left join fetch employee.department employee.id = :id", Employee.class);
        //query.setParameter("id", id);
        //return (Employee)query.getSingleResult();
        return this.em.find(Employee.class, id);
    }

    @Override
    public void save(Employee employee) throws DataAccessException {
        
        if(employee.getId() == null){
            this.em.persist(employee);
        }else{
            this.em.merge(employee);
        }
    }

    @Override
    public Collection<Employee> findEmployeeByName_Address_BirthDate(Employee employee_toBeFound) throws DataAccessException {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        String firstName = employee_toBeFound.getFirstName();
        String middleName = employee_toBeFound.getMiddleName();
        String lastName = employee_toBeFound.getLastName();
        
        Date birth_date = employee_toBeFound.getBirth_date();
        
        String home_address = employee_toBeFound.getHome_address();
        String city = employee_toBeFound.getCity();
        String province = employee_toBeFound.getProvince();
        String country = employee_toBeFound.getCountry();
        String postcode = employee_toBeFound.getPostcode();
          
        String str_query = "SELECT employee FROM Employee employee WHERE employee.lastName = :lastName";
        if(!firstName.isEmpty()){
            str_query = str_query + " AND employee.firstName = :firstName";
        }
        
        if(!middleName.isEmpty()){
            str_query = str_query + " AND employee.middleName = :middleName";
        }
        
        if(birth_date != null){
            str_query = str_query + " AND employee.birth_date = :birth_date";
        }
        
        if(!home_address.isEmpty()){
            str_query = str_query + " AND employee.home_address = :home_address";
        }
        
        if(!city.isEmpty()){
            str_query = str_query + " AND employee.city = :city";
        }
        
        if(!province.isEmpty()){
            str_query = str_query + " AND employee.province = :province";
        }
        
        if(!country.isEmpty()){
            str_query = str_query + " AND employee.country = :country";
        }
        
        if(!postcode.isEmpty()){
            str_query = str_query + " AND employee.postcode = :postcode";
        }
        
        Query query = this.em.createQuery(str_query);
        
        if(!firstName.isEmpty()){            
            query.setParameter("firstName", firstName);
        }
        if(!middleName.isEmpty()){
            query.setParameter("middleName", middleName);
        }
        if(birth_date != null){
            query.setParameter("birth_date", birth_date);
        }        
        
        if(!home_address.isEmpty()){
            query.setParameter("home_address", home_address);
        }
        
        if(!city.isEmpty()){
            query.setParameter("city", city);
        }
        
        if(!province.isEmpty()){
            query.setParameter("province", province);
        }
        
        if(!country.isEmpty()){
            query.setParameter("country", country);
        }
        
        if(!postcode.isEmpty()){
            query.setParameter("postcode", postcode);
        }
        
        return query.getResultList();
    }
}
