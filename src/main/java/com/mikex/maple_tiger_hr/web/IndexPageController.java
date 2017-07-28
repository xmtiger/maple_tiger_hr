/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mikex.maple_tiger_hr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author MikeX
 */
@Controller
@RequestMapping(value="index.htm")
public class IndexPageController {
    
    @RequestMapping("")
    public String indexPage(){
        return "index";
    }
}
