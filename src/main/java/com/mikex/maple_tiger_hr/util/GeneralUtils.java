/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import java.util.logging.Level;

/**
 *
 * @author xmtig
 */
public class GeneralUtils {
    
    public static Date getTime_UTC(Date date_in){                
        //convert the date to UTC date  
        SimpleDateFormat dateFormatUTC = new SimpleDateFormat("yyyy-MMM-dd");
        dateFormatUTC.setTimeZone(TimeZone.getTimeZone("UTC"));
        //Local time zone   
        SimpleDateFormat dateFormatLocal = new SimpleDateFormat("yyyy-MMM-dd");
        //Time in UTC
        Date date_out = null;
        try {
            date_out = dateFormatLocal.parse( dateFormatUTC.format(date_in) );
            
        } catch (ParseException ex) {
            java.util.logging.Logger.getLogger(GeneralUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return date_out;
    }
}
