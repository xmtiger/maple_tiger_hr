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
DROP TABLE timecodes IF EXISTS;
DROP TABLE timesheets IF EXISTS;


CREATE TABLE employees (
    id              INTEGER IDENTITY PRIMARY KEY,
    first_name      VARCHAR(30),
    last_name       VARCHAR_IGNORECASE(30),
    birth_date      DATE,
    home_address    VARCHAR(255),
    phone_mobile    VARCHAR(20),
    dept_id         INTEGER NOT NULL
);

CREATE TABLE departments (
    id              INTEGER IDENTITY PRIMARY KEY,
    name            VARCHAR(30),
    begin_time      DATE,
    end_time        DATE,
    address         VARCHAR(255)
);

ALTER TABLE employees ADD CONSTRAINT fk_dept_employee FOREIGN KEY (dept_id) REFERENCES departments (id); 

CREATE TABLE timecodes(
    id                      INTEGER IDENTITY PRIMARY KEY,
    time_code               VARCHAR(30),
    project_id              INTEGER,
    decription              VARCHAR(255),
    active_status           BOOLEAN,
    code_type               SMALLINT,   /*0: holiday, 1: project regular hours, 2: project overtime hours, 3: sick, 4: vacation*/

    checked_out             BOOLEAN,

    checked_out_time        TIMESTAMP,
    checked_out_person_id   INTEGER,
    
    created_time            TIMESTAMP,
    created_person_id       INTEGER NOT NULL,

    modified_time           TIMESTAMP,
    modified_persion_id     INTEGER NOT NULL,
    
    /*language                VARCHAR(30)*/ /*In canada, both "english" and "french" are required */
);

/*hour has different types such as regular hours, overtime, holiday, sick, vacation etc..
The hour type depends on the charge code type, the pay rate is also depends on the charge code.
*/
CREATE TABLE timesheets(
    id                  INTEGER IDENTITY PRIMARY KEY,
    employee_id         INTEGER NOT NULL,
    timecode_id         INTEGER NOT NULL,
    date                DATE,
    hours               SMALLINT,     
    last_updated_time   TIMESTAMP   
);

ALTER TABLE timesheets ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employees (id); 
ALTER TABLE timesheets ADD CONSTRAINT fk_timecode_id FOREIGN KEY (timecode_id) REFERENCES timecodes (id);