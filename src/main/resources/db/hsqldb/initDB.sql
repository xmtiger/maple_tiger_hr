/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  xmtig
 * Created: 24-Jul-2017
 */

DROP TABLE employee IF EXISTS;



CREATE TABLE employee (
    id              INTEGER IDENTITY PRIMARY KEY,
    first_name      VARCHAR(30),
    last_name       VARCHAR_IGNORECASE(30)
    birth_date      DATE,
    home_address    VARCHAR(100),
    phone_mobile    VARCHAR(20)
)