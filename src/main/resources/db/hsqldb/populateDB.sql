/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  xmtig
 * Created: 24-Jul-2017
 */
INSERT INTO departments VALUES (1, 'management', '1990-03-01', '1900-01-01', '233 willibrord St.');
INSERT INTO departments VALUES (2, 'accounting', '1990-05-01', '1900-01-01', '233 willibrord St.');
INSERT INTO departments VALUES (3, 'engineering', '1990-03-01', '1900-01-01', '233 willibrord St.');
INSERT INTO departments VALUES (4, 'civil', '1990-03-01', '1900-01-01', '223 willibrord, St.');
INSERT INTO departments VALUES (5, 'mechanical', '1990-03-01', '1900-01-01', '233 willibrord St.');
INSERT INTO departments VALUES (6, 'Yamax Group', '1990-03-01', '1900-01-01', '233 willibrord St.');
INSERT INTO departments VALUES (7, 'construction', '1990-03-01', '1900-01-01', '233 willibrord St.');

INSERT INTO department_relationship VALUES(3, 4);
INSERT INTO department_relationship VALUES(3, 5);
INSERT INTO department_relationship VALUES(6, 1);
INSERT INTO department_relationship VALUES(6, 2);
INSERT INTO department_relationship VALUES(6, 3);
INSERT INTO department_relationship VALUES(6, 7);

INSERT INTO employees VALUES (1, 1, 'George','', 'Franklin', '1977-09-07', 'MALE',
                                '110 W. Liberty St.','Montreal', 'Quebec', 'Canada', 'H8N 3H5','test01@yamax.com', 'test01@gmail.com' ,'6085551023','','');

INSERT INTO employees VALUES (2,2, 'Betty','', 'Davis', '1987-06-15', 'MALE' ,
                                '638 Cardinal Ave.','Montreal', 'Quebec', 'Canada', 'H8N 3H5','test01@yamax.com', 'test01@gmail.com', '6085551749', '', '');

INSERT INTO employees VALUES (3,3, 'Eduardo','', 'Rodriquez', '1982-03-12','FEMALE', '2693 Commerce St.','Montreal', 'Quebec', 'Canada', 'H8N 3H5', 'test01@yamax.com', 'test01@gmail.com','6085558763', '', '');
INSERT INTO employees VALUES (4,4, 'Tom','' ,'Hanks', '1986-03-12','MALE', '2698 Commerce St.','Montreal', 'Quebec', 'Canada', 'H8N 3H5', 'test01@yamax.com', 'test01@gmail.com','6085558767', '', '');
INSERT INTO employees VALUES (5,5, 'Alix','' ,'Jackson', '1988-03-12', 'MALE','2698 Commerce St.', 'Montreal', 'Quebec', 'Canada', 'H8N 3H5','test01@yamax.com', 'test01@gmail.com','6085558753', '', '');
INSERT INTO employees VALUES (6,4, 'James','' ,'Lee', '1988-11-16','MALE', '2690 Commerce St.','Montreal', 'Quebec', 'Canada', 'H8N 3H5', 'test01@yamax.com', 'test01@gmail.com','6085558783', '', '');
INSERT INTO employees VALUES (7,5, 'Alex','' ,'Zoe', '1988-12-09', 'MALE','2098 Commerce St.', 'Montreal', 'Quebec', 'Canada', 'H8N 3H5','test01@yamax.com', 'test01@gmail.com','6087558753', '', '');
INSERT INTO employees VALUES (8,6, 'Anne','' ,'Urta', '1988-06-17', 'FEMALE', '2198 Commerce St.', 'Montreal', 'Quebec', 'Canada', 'H8N 3H5','test01@yamax.com', 'test01@gmail.com','6087558753', '', '');

INSERT INTO employee_job_history VALUES(1,1,'Manager','Take charge of the managemet of the whole organization' ,'2001-01-01', '1900-01-01');
INSERT INTO employee_job_history VALUES(2,2,'Manager','Take charge of the managemet of the engineering' ,'2001-01-01', '1900-01-01');
INSERT INTO employee_job_history VALUES(3,3,'Accountant','Accounting' ,'2001-01-01', '1900-01-01');
INSERT INTO employee_job_history VALUES(4,4,'Inspector','Inspection' ,'2001-01-01', '1900-01-01');
INSERT INTO employee_job_history VALUES(5,5,'Designer','Drafting' ,'2001-01-01', '1900-01-01');
INSERT INTO employee_job_history VALUES(6,6,'Designer','Drafting' ,'2001-01-01', '1900-01-01');
INSERT INTO employee_job_history VALUES(7,7,'Engineer','Design' ,'2001-01-01', '1900-01-01');
INSERT INTO employee_job_history VALUES(8,8,'Engineer','Design' ,'2001-01-01', '1900-01-01');

INSERT INTO employee_salary_history VALUES(1,1, '2001-01-01', '1992-01-01','DIRECT_DEPOSIT_BIWEEKLY','CAD', 25.6, -1); 


INSERT INTO projects VALUES (1, 1, 'P2017-09-01', 'Renovation Project', 
                            '1832 Springland', 'Verdun', 'Quebec',  'Canada', 'H8N 3H6',
                            '2017-07-28 6:00:00' , '1900-01-01 00:00:00', '2017-07-28 09:33:36', '2017-09-28 12:30:00');

INSERT INTO timecodes VALUES (1, 'P2017-07-01', 1, 'charge code for project AAA', 'TRUE', 1, 'TRUE', 
                                '2017-07-28 09:33:36', 1,
                                '2017-05-03 10:35:22', 1, 
                                '2017-07-28 09:33:12', 3);


INSERT INTO timesheets VALUES (1, 1, 1, '2017-07-17', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (2, 1, 1, '2017-07-18', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (3, 1, 1, '2017-07-19', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (4, 1, 1, '2017-07-20', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (5, 1, 1, '2017-07-21', 8, '2017-07-21 03:20:22');