/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.repository.jpa;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.repository.DepartmentRepository;
import java.util.Collection;
import java.util.Date;

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
    
    /*Note: The Selection sentence shows "Department" (rather than "Departments"), 
    * which I think is the Class name of the Class "Department" rather than the table name "departments" */
    @Override
    public Department findDepartmentById(int id) throws DataAccessException {
        Query query = this.em.createQuery("SELECT DISTINCT dept FROM Department dept left join fetch dept.employees WHERE dept.id = :id");
        query.setParameter("id", id);
        return (Department) query.getSingleResult();
    }
    
    @Override
    public Collection<Department> findDepartmentByName(String name) throws DataAccessException{
        Query query = this.em.createQuery("SELECT dept FROM Department dept left join fetch dept.employees WHERE dept.name = :name");
        query.setParameter("name", name);
        return query.getResultList();
    }
    
    @Override
    public Collection<Department> findDepartmentByName_Address_BeginTime(String name, String address, Date beginTime) throws DataAccessException{
        //Note: the following sql sentene does not inlcude 'left join fetch dept.employees', but the employee still was extracted
        String str_query = "SELECT dept FROM Department dept WHERE dept.name = :name";
        
        //Query query = this.em.createQuery("SELECT dept FROM Department dept WHERE dept.name = :name "
          //      + "AND dept.address = :address AND dept.begin_time = :beginTime");
        
        //query.setParameter("name", name).setParameter("address", address).setParameter("beginTime", beginTime);
        
        if(!address.isEmpty()){
            str_query = str_query + " AND dept.address = :address";
        }
        
        if(beginTime != null){
            str_query = str_query + " AND dept.begin_time = :beginTime";
        }
        
        Query query = this.em.createQuery(str_query);
        
        if(!name.isEmpty()){            
            query.setParameter("name", name);
        }
        if(!address.isEmpty()){
            query.setParameter("address", address);
        }
        if(beginTime != null){
            query.setParameter("beginTime", beginTime);
        }        
        
        return query.getResultList();
    }

    @Override
    public void save(Department department) throws DataAccessException {
        if(department.getId() == null){
            this.em.persist(department);
        } else{
            this.em.merge(department);
        }
        
    }
    
    @Override
    public Collection<Department> findAllDepartments() throws DataAccessException {
        Query query = this.em.createQuery("SELECT dept FROM Department dept");
        return query.getResultList();
    }
}
