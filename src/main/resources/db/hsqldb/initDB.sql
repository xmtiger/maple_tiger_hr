/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  xmtig
 * Created: 24-Jul-2017
 */
/*table employee and department_relationship dependent on department must be dropped first, 
then the table department can be dropped */
DROP TABLE person IF EXISTS;

DROP TABLE clients IF EXISTS;

DROP TABLE employee_job_history IF EXISTS;
DROP TABLE employee_salary_history IF EXISTS;
DROP TABLE employee_assignments IF EXISTS;

DROP TABLE employees IF EXISTS;
DROP TABLE department_relationship IF EXISTS;
DROP TABLE departments IF EXISTS;

DROP TABLE timecodes IF EXISTS;
DROP TABLE timesheets IF EXISTS;

DROP TABLE project_finance IF EXISTS;
DROP TABLE projects IF EXISTS;

/* if the end_date is '1990-01-01', it means this is the current record*/
CREATE TABLE person(
    id          INTEGER IDENTITY PRIMARY KEY,
    first_name  VARCHAR(30),
    middle_name VARCHAR(30),
    last_name   VARCHAR(30),

    gender      VARCHAR(20),
    birth_date  DATE,
    
    address     VARCHAR(255),
    city        VARCHAR(60),
    province    VARCHAR(60),
    country     VARCHAR(60),
    postcode    VARCHAR(20),

    office_email    VARCHAR(255),
    personal_email  VARCHAR(255),

    home_phone      VARCHAR(30),
    mobile_phone    VARCHAR(30),
    fax             VARCHAR(30),

    hobbies         VARCHAR(255)
);

CREATE TABLE clients(
    id                  INTEGER IDENTITY PRIMARY KEY,
    client_name         VARCHAR(255) NOT NULL,
    location            VARCHAR(255),
    description         VARCHAR(255),
    
    /*person_contact shall be FK of the table 'person_contacts'*/
    person_contact_id      INTEGER,    
    person_contact_id_1    INTEGER,
    person_contact_id_2    INTEGER, 
                                
    phone               VARCHAR(30),
    phone_1             VARCHAR(30),
    phone_2             VARCHAR(30),
    
    fax                 VARCHAR(30),
    fax_1               VARCHAR(30),
    fax_2               VARCHAR(30),

    email               VARCHAR(255),
    email_1             VARCHAR(255),
    email_2             VARCHAR(255),
    
    webSite             VARCHAR(255),
    webSite_1           VARCHAR(255),
    webSite_2           VARCHAR(255)
);

ALTER TABLE clients ADD CONSTRAINT fk_clients_person FOREIGN KEY (person_contact_id) REFERENCES person (id);
ALTER TABLE clients ADD CONSTRAINT fk_clients_person_1 FOREIGN KEY (person_contact_id_1) REFERENCES person (id);
ALTER TABLE clients ADD CONSTRAINT fk_clients_person_2 FOREIGN KEY (person_contact_id_2) REFERENCES person (id);

CREATE TABLE project_finance(
    id                  INTEGER IDENTITY PRIMARY KEY, 
    project_id          INTEGER NOT NULL,
    
    income_description  VARCHAR(255),
    direct_income       DECIMAL(12,2),
    indirect_income     DECIMAL(12,2),
    
    cost_description    VARCHAR(255),
    direct_cost         DECIMAL(12,2),
    indirect_cost       DECIMAL(12,2)
);

CREATE TABLE projects (
    id                  INTEGER IDENTITY PRIMARY KEY, 
    
    client_id           INTEGER,
    job_code            VARCHAR(255),
    
    project_name        VARCHAR(255),
    project_descriptin  VARCHAR(1023),

    address             VARCHAR(255),   
    city                VARCHAR(255),
    province            VARCHAR(255),
    country             VARCHAR(255),
    postcode            VARCHAR(30),
    
    start_time          TIMESTAMP,
    end_time            TIMESTAMP,
    
    estimated_start_time    TIMESTAMP,
    estimated_end_time      TIMESTAMP
);

ALTER TABLE project_finance ADD CONSTRAINT fk_project_finance_projects FOREIGN KEY (project_id) REFERENCES projects (id);

CREATE TABLE employee_job_history (
    id              INTEGER IDENTITY PRIMARY KEY,
    employee_id     INTEGER NOT NULL,

    title           VARCHAR(255),
    job_description VARCHAR(255),

    start_date      DATE,
    end_date        DATE    
    
);

CREATE TABLE employee_salary_history (
    id              INTEGER IDENTITY PRIMARY KEY,
    employee_id     INTEGER NOT NULL,

    start_date      DATE,
    end_date        DATE,
    
    pay_type        VARCHAR(255),

    currency_type   VARCHAR(20),

    base_rate       DECIMAL(10,2),
    overtime_rate   DECIMAL(10,2)
    
);

CREATE TABLE employee_assignments (
    id              INTEGER IDENTITY PRIMARY KEY,
    job_code        VARCHAR(30),                /*this job code shall be FK referred from 'project table' which will be added*/
    start_date      TIMESTAMP,
    end_date        TIMESTAMP,
    employee_id     INTEGER NOT NULL
);

CREATE TABLE employees (
    id              INTEGER IDENTITY PRIMARY KEY,
    dept_id         INTEGER NOT NULL,

    first_name      VARCHAR(30),
    middle_name     VARCHAR(30),
    last_name       VARCHAR_IGNORECASE(30),

    birth_date      DATE,
    gender          VARCHAR(20),

    home_address    VARCHAR(255),
    city            VARCHAR(60),
    province        VARCHAR(60),
    country         VARCHAR(60),
    postcode        VARCHAR(20),

    office_email    VARCHAR(255),
    personal_email  VARCHAR(255),
    
    home_phone      VARCHAR(30),
    mobile_phone    VARCHAR(30),
    fax             VARCHAR(30)   
);

ALTER TABLE employee_job_history ADD CONSTRAINT fk_employee_employeeHistory FOREIGN KEY (employee_id) REFERENCES employees (id);

ALTER TABLE employee_salary_history ADD CONSTRAINT fk_employee_salaryHistory FOREIGN KEY (employee_id) REFERENCES employees (id);

ALTER TABLE employee_assignments ADD CONSTRAINT fk_employee_assignments FOREIGN KEY (employee_id) REFERENCES employees (id);

CREATE TABLE departments (
    id              INTEGER IDENTITY PRIMARY KEY,
    name            VARCHAR(30),
    begin_time      DATE,
    end_time        DATE,
    address         VARCHAR(255)
);

CREATE TABLE department_relationship(
    id_father       INTEGER NOT NULL,
    id_child        INTEGER NOT NULL
);

ALTER TABLE department_relationship ADD CONSTRAINT fk_dept_father FOREIGN KEY (id_father) REFERENCES departments (id);

ALTER TABLE department_relationship ADD CONSTRAINT fk_dept_child FOREIGN KEY (id_child) REFERENCES departments (id);

ALTER TABLE employees ADD CONSTRAINT fk_dept_employee FOREIGN KEY (dept_id) REFERENCES departments (id); 

CREATE TABLE timecodes(
    id                      INTEGER IDENTITY PRIMARY KEY,
    
    time_code               VARCHAR(30) NOT NULL UNIQUE,

    project_id              INTEGER,        /* this shall be FK referred from 'project table'*/
    
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

ALTER TABLE timecodes ADD CONSTRAINT fk_timecodes_projects FOREIGN KEY (project_id) REFERENCES projects (id); 

/*hour has different types such as regular hours, overtime, holiday, sick, vacation etc..
The hour type depends on the charge code type, the pay rate is also depends on the charge code.
*/
CREATE TABLE timesheets(
    id                  INTEGER IDENTITY PRIMARY KEY,
    employee_id         INTEGER NOT NULL,
    timecode_id         INTEGER NOT NULL,
    date_record         DATE,
    hours               SMALLINT,     
    last_updated_time   TIMESTAMP   
);

ALTER TABLE timesheets ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employees (id); 
ALTER TABLE timesheets ADD CONSTRAINT fk_timecode_id FOREIGN KEY (timecode_id) REFERENCES timecodes (id);