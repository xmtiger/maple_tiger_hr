/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.util;

import com.mikex.maple_tiger_hr.model.BaseEntity;
import java.util.Collection;
import org.springframework.orm.ObjectRetrievalFailureException;

/**
 *
 * @author xmtig
 */
public abstract class EntityUtils {
    
    public static <T extends BaseEntity> T getById(Collection<T> entities, Class<T> entityClass, int entityId)
    throws ObjectRetrievalFailureException{
        for(T entity : entities){
            if(entity.getId() == entityId && entityClass.isInstance(entity)){
                return entity;
            }
        }
        throw new ObjectRetrievalFailureException(entityClass, entityId);
    }
    
    public static <T extends BaseEntity> T getById(T entity, Class<T> entityClass, int entityId)
    throws ObjectRetrievalFailureException{
        
        if(entity.getId() == entityId && entityClass.isInstance(entity)){
            return entity;
        }
        
        throw new ObjectRetrievalFailureException(entityClass, entityId);
    }
}
