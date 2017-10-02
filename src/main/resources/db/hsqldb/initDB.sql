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


DROP TABLE employee_job_history IF EXISTS;
DROP TABLE employee_salary_history IF EXISTS;
DROP TABLE employee_assignments IF EXISTS;

DROP TABLE job_codes_assignments IF EXISTS;
DROP TABLE job_codes IF EXISTS;

DROP TABLE employees IF EXISTS;

DROP TABLE department_relationship IF EXISTS;
DROP TABLE departments IF EXISTS;

DROP TABLE timecodes IF EXISTS;
DROP TABLE timesheets IF EXISTS;

DROP TABLE project_incomes IF EXISTS;
DROP TABLE project_costs IF EXISTS;
DROP TABLE projects IF EXISTS;

DROP TABLE clients_contacts IF EXISTS;
DROP TABLE clients IF EXISTS;
DROP TABLE person_contacts IF EXISTS;

/* if the end_date is '1990-01-01', it means this is the current record*/
CREATE TABLE person_contacts(
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
    id              INTEGER IDENTITY PRIMARY KEY,
    name            VARCHAR(255) NOT NULL UNIQUE,
    
    description     VARCHAR(255),
    
    address         VARCHAR(255),
    city            VARCHAR(60),
    province        VARCHAR(60),
    country         VARCHAR(60),
    postcode        VARCHAR(20),
    
    office_phone    VARCHAR(30),
    fax             VARCHAR(30),

    website         VARCHAR(255)    
);

CREATE TABLE clients_contacts(
    client_id       INTEGER NOT NULL,
    contact_id      INTEGER NOT NULL
);

ALTER TABLE clients_contacts ADD CONSTRAINT fk_clients_contacts_clients FOREIGN KEY (client_id) REFERENCES clients (id);
ALTER TABLE clients_contacts ADD CONSTRAINT fk_clients_contacts_contacts FOREIGN KEY (contact_id) REFERENCES person_contacts (id);

/*CREATE TABLE project_finances(
    id                  INTEGER IDENTITY PRIMARY KEY, 
    project_id          INTEGER NOT NULL,
    
    income_description  VARCHAR(255),
    direct_income       DECIMAL(12,2),
    indirect_income     DECIMAL(12,2),
    
    cost_description    VARCHAR(255),
    direct_cost         DECIMAL(12,2),
    indirect_cost       DECIMAL(12,2)
);*/

CREATE TABLE project_incomes(
    id                  INTEGER IDENTITY PRIMARY KEY, 
    project_id          INTEGER NOT NULL,
    
    description         VARCHAR(255),
    direct_income       DECIMAL(12,2),
    indirect_income     DECIMAL(12,2)      
);

CREATE TABLE project_costs(
    id                  INTEGER IDENTITY PRIMARY KEY, 
    project_id          INTEGER NOT NULL,

    description         VARCHAR(255),
    direct_cost         DECIMAL(12,2),
    indirect_cost       DECIMAL(12,2)
);

CREATE TABLE projects (
    id                  INTEGER IDENTITY PRIMARY KEY, 
    
    client_id           INTEGER,
    
    project_name        VARCHAR(255),
    project_descriptin  VARCHAR(1023),

    address             VARCHAR(255),   
    city                VARCHAR(255),
    province            VARCHAR(255),
    country             VARCHAR(255),
    postcode            VARCHAR(30),
    
    begin_time          TIMESTAMP,
    end_time            TIMESTAMP,
    
    estimated_start_time    TIMESTAMP,
    estimated_end_time      TIMESTAMP
);

CREATE TABLE job_codes (
    id                  INTEGER IDENTITY PRIMARY KEY,
    
    project_id          INTEGER NOT NULL,

    job_code            VARCHAR(255) NOT NULL UNIQUE,
    description         VARCHAR(255)
);

ALTER TABLE projects ADD CONSTRAINT fk_projects_client_id FOREIGN KEY (client_id) REFERENCES clients (id);

ALTER TABLE project_incomes ADD CONSTRAINT fk_project_incomes_projects FOREIGN KEY (project_id) REFERENCES projects (id);
ALTER TABLE project_costs ADD CONSTRAINT fk_project_costs_projects FOREIGN KEY (project_id) REFERENCES projects (id);

ALTER TABLE job_codes ADD CONSTRAINT fk_project_job_code FOREIGN KEY (project_id) REFERENCES projects (id);

CREATE TABLE employee_job_history (
    id              INTEGER IDENTITY PRIMARY KEY,
    employee_id     INTEGER NOT NULL,

    title           VARCHAR(255),
    job_description VARCHAR(255),

    begin_time      DATE,
    end_time        DATE    
    
);

CREATE TABLE employee_salary_history (
    id              INTEGER IDENTITY PRIMARY KEY,
    employee_id     INTEGER NOT NULL,

    begin_time      DATE,
    end_time        DATE,
    
    pay_type        VARCHAR(100),

    currency_type   VARCHAR(30),

    base_rate       DECIMAL(10,2),
    overtime_rate   DECIMAL(10,2)
    
);

CREATE TABLE employee_assignments (
    id              INTEGER IDENTITY PRIMARY KEY,
    /*job_code        INTEGER NOT NULL,           */     /*this job code shall be FK referred from 'job codes' */
    employee_id     INTEGER NOT NULL,

    begin_time      TIMESTAMP,
    end_time        TIMESTAMP,
    
);

CREATE TABLE job_codes_assignments (
    job_code_id INTEGER NOT NULL,
    assignment_id   INTEGER NOT NULL,
);

ALTER TABLE job_codes_assignments ADD CONSTRAINT fk_project_code_assignments_job_code FOREIGN KEY (job_code_id) REFERENCES job_codes (id);
ALTER TABLE job_codes_assignments ADD CONSTRAINT fk_project_code_assignments_assignment FOREIGN KEY (assignment_id) REFERENCES employee_assignments (id);

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