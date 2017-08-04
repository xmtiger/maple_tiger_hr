/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.jpa;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.repository.DepartmentRepository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

/**
 *
 * @author xmtig
 */
@Repository
public class JpaDepartmentRepositoryImpl implements DepartmentRepository{

    @PersistenceContext
    private EntityManager em;
    
    @Override
    public Department findDepartmentById(int id) throws DataAccessException {
        Query query = this.em.createQuery("SELECT DISTINCT dept FROM Department dept left join fetch dept.employees WHERE dept.id = :id");
        query.setParameter("id", id);
        return (Department) query.getSingleResult();
    }

    @Override
    public void save(Department department) throws DataAccessException {
        if(department.getId() == null){
            this.em.persist(department);
        } else{
            this.em.merge(department);
        }
        
    }
    
}
