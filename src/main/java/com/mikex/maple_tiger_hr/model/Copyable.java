/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.model;

/**
 *
 * @author xmtig
 * @param <T>
 */
public interface Copyable<T> {
    public boolean copyFrom(T t);
}
