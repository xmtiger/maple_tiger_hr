/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  xmtig
 * Created: 24-Jul-2017
 */
INSERT INTO departments VALUES (1, 'management', '1990-03-01', '1990-03-01', '233 willibrord St.');
INSERT INTO departments VALUES (2, 'accounting', '1990-05-01', '1990-05-01', '233 willibrord St.');
INSERT INTO departments VALUES (3, 'engineering', '1990-03-01', '1990-03-01', '233 willibrord St.');
INSERT INTO departments VALUES (4, 'civil', '1990-03-01', '1990-03-01', '223 willibrord, St.');
INSERT INTO departments VALUES (5, 'mechanical', '1990-03-01', '1990-03-01', '233 willibrord St.');
INSERT INTO departments VALUES (6, 'Yamax Group', '1990-03-01', '1990-03-01', '233 willibrord St.');

INSERT INTO department_relationship VALUES(3, 4);
INSERT INTO department_relationship VALUES(3, 5);
INSERT INTO department_relationship VALUES(6, 1);
INSERT INTO department_relationship VALUES(6, 2);
INSERT INTO department_relationship VALUES(6, 3);

INSERT INTO employees VALUES (1, 'George', 'Franklin', '1977-09-07', '110 W. Liberty St.', '6085551023', 1);
INSERT INTO employees VALUES (2, 'Betty', 'Davis', '1987-06-15', '638 Cardinal Ave.', '6085551749', 2);
INSERT INTO employees VALUES (3, 'Eduardo', 'Rodriquez', '1982-03-12', '2693 Commerce St.', '6085558763', 3);
INSERT INTO employees VALUES (4, 'Tom', 'Hanks', '1986-03-12', '2698 Commerce St.', '6085558767', 4);
INSERT INTO employees VALUES (5, 'Alix', 'Jackson', '1988-03-12', '2698 Commerce St.', '6085558753', 5);

INSERT INTO timecodes VALUES (1, 'P2017-07-01', 1, 'charge code for project AAA', 'TRUE', 1, 'TRUE', 
                                '2017-07-28 09:33:36', 1,
                                '2017-05-03 10:35:22', 1, 
                                '2017-07-28 09:33:12', 3);


INSERT INTO timesheets VALUES (1, 1, 1, '2017-07-17', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (2, 1, 1, '2017-07-18', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (3, 1, 1, '2017-07-19', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (4, 1, 1, '2017-07-20', 8, '2017-07-21 03:20:22');
INSERT INTO timesheets VALUES (5, 1, 1, '2017-07-21', 8, '2017-07-21 03:20:22');