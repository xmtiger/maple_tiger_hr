/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  xmtig
 * Created: 24-Jul-2017
 */

DROP TABLE employees IF EXISTS;
DROP TABLE departments IF EXISTS;


CREATE TABLE employees (
    id              INTEGER IDENTITY PRIMARY KEY,
    first_name      VARCHAR(30),
    last_name       VARCHAR_IGNORECASE(30),
    birth_date      DATE,
    home_address    VARCHAR(100),
    phone_mobile    VARCHAR(20),
    dept_id         INTEGER NOT NULL
);

CREATE TABLE departments (
    id              INTEGER IDENTITY PRIMARY KEY,
    name            VARCHAR(30),
    begin_time      DATE,
    end_time        DATE,
    address         VARCHAR(100)
);

ALTER TABLE employees ADD CONSTRAINT fk_dept_employee FOREIGN KEY (dept_id) REFERENCES departments (id); 
