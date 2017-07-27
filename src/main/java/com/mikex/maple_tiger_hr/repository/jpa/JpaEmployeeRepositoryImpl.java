/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.jpa;

import com.mikex.maple_tiger_hr.model.Employee;
import com.mikex.maple_tiger_hr.repository.EmployeeRepository;
import java.util.Collection;

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
        
        Query query = this.em.createQuery("SELECT DISTINCT employee FROM Employee employee WHERE employee.lastName LIKE :lastName", Employee.class);
        query.setParameter("lastName", lastName + "%");
        return query.getResultList();
    }

    @Override
    public Employee findById(int id) throws DataAccessException {
        
        Query query = this.em.createQuery("SELECT employee FROM Employee employee WHERE employee.id = :id", Employee.class);
        query.setParameter("id", id);
        return (Employee)query.getSingleResult();
    }

    @Override
    public void save(Employee employee) throws DataAccessException {
        
        if(employee.getId() == null){
            this.em.persist(employee);
        }else{
            this.em.merge(employee);
        }
    }
}
