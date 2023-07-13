drop database ucq_chido;
create database ucq_chido;
use ucq_chido;
select * from users;
DELETE FROM users WHERE id_user=7;
DELETE FROM students_exam WHERE id_student_exam=3;
select * from view_user;
#-----------------------tablas users---------------------
drop table Users;
create table Users(
	id_user int(254) not null auto_increment,
	name varchar(254) not null,
    lastname varchar(254)not null,
    surname varchar(254) not null,
    curp varchar (18) not null,
    status varchar(7) not null,
    type_user int(1) not null,
    mail varchar(254),
    enrollment varchar (10),
    password varchar(254),
    primary key (id_user)
);
select * from users;
insert into users values (0,'Emilio','alpizar','Garcia','AIGE041218HMSLRMA3','ACTIVO',1,'20223tn084@utez.edu.mx','20223tn084','Admin');
insert into users values (0,'Axel','Ocampo','Galvez','OCGA040719HMSLRMA3','ACTIVO',2,'20223tn086@utez.edu.mx','20223tn086','12345678');
insert into users values (0,'Cristian','Castañeda','Lopez','CTCB040719HMSLRMA3','ACTIVO',3,'20223tn089@utez.edu.mx','20223tn089','12345678');

#-----------------------tablas exams---------------------
drop table exams;
CREATE TABLE exams (
    id_exam INT NOT NULL auto_increment,
    name_exam VARCHAR(254) NOT NULL,
    code VARCHAR(5) NOT NULL,
    start_time datetime NULL,
    end_time datetime null,
    fk_user INT(254) NOT NULL,
    PRIMARY KEY (id_exam),
    FOREIGN KEY (fk_user) REFERENCES Users (id_user)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
insert into exams values(1,'POO','XL306','2020-07-08','2020-07-09',2);
insert into exams values(2,'BD','XQC210','2020-07-04','2020-07-05',2);
select * from exams;
select * from view_exams;
#-----------------------tablas students_exam---------------------
drop table students_exam;
CREATE TABLE Students_exam (
  id_Student_exam INT NOT NULL auto_increment,
  score INT(3) NULL,
  start_date datetime not NULL,
  end_date datetime null,
  fk_user INT(1) NOT NULL,
  fk_exam INT(254) NOT NULL,
  PRIMARY KEY (id_Student_exam),
    FOREIGN KEY (fk_user)
    REFERENCES Users (id_User)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (fk_exam)
	REFERENCES Exams (id_Exam)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
insert into students_exam (start_date,end_date,fk_user,fk_exam)values(sysdate(),'',3,1);
select * from view_Students_exam;
#-----------------------tablas questions---------------------
drop table questions;
CREATE TABLE Questions (
  id_Question INT(5) NOT NULL auto_increment,
  url_image VARCHAR(254) NULL,
  type_question INT(1) NOT NULL,
  description VARCHAR(254) NOT NULL,
  points INT(2) NOT NULL,
  PRIMARY KEY (id_Question)
);
insert into questions values(1,'http/sf',1,'¿que es java?',20);
insert into questions values(2,'http/sfg',2,'¿que es deadlock?',40);
insert into questions values(3,'http/sfq',1,'¿que es SQL?',40);
select * from questions;
select * from view_exam_questions;
  #-----------------------tablas questions_answer---------------------
  drop table questions_answer;
CREATE TABLE Questions_answer (
  id_Question_answer INT NOT NULL auto_increment,
  answer VARCHAR(254) NOT NULL,
  if_answer TINYINT NOT NULL,
  fk_question INT(5) NOT NULL,
  PRIMARY KEY (id_Question_answer),
    FOREIGN KEY (fk_question)
    REFERENCES Questions (id_Question)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
insert into questions_answer values(1,'tili',1,1);
select * from questions_answer;
#-----------------------tablas Students_exam_answer---------------------
drop table Students_exam_answer;
CREATE TABLE Students_exam_answer (
  id_Student_exam_answer INT NOT NULL auto_increment,
  fk_student_exam INT NOT NULL,
  answer VARCHAR(254) NOT NULL,
  fk_answer INT(5) NOT NULL,
  fk_question INT(5) NOT NULL,
  PRIMARY KEY (id_Student_exam_answer),
    FOREIGN KEY (fk_student_exam)
    REFERENCES Students_exam (id_Student_exam)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (fk_question)
    REFERENCES Questions (id_Question)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (fk_answer)
    REFERENCES Questions_answer (id_Question_answer)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
INSERT INTO Students_exam_answer values(1,1,'no c we un AU NO?',1,1);
select * from Students_exam_answer;
#-----------------------tablas exam_questions---------------------
drop table exam_questions;
CREATE TABLE Exam_questions (
  id_Exam_questions INT NOT NULL auto_increment,
  fk_question INT(5) NOT NULL,
  fk_exam INT(254) NOT NULL,
  PRIMARY KEY (id_Exam_questions),
    FOREIGN KEY (fk_exam)
    REFERENCES Exams (id_Exam)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (fk_question)
    REFERENCES Questions (id_Question)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
insert into exam_questions values(0,1,1);
insert into exam_questions values(0,2,1);
insert into exam_questions values(0,3,1);
select * from exam_questions;

/*------------------vistas de users---------------*/
create view view_user as 
select * from users
group by type_user, enrollment 
order by type_user asc, enrollment asc;
select * from view_user;

#-----------------------------vista de examenes--------------------------------
create view view_exams as 
select * from exams
group by id_exam
order by  start_time asc;
select * from view_exams;
use ucq_chido;
/*----------------vista de estudiantes tienen examen--------------------*/
create view view_Students_exam as select Students_exam.id_Student_exam , Users.type_user ,Users.name , Users.lastname, 
Users.surname, Users.enrollment , Users.mail , exams.id_exam , exams.name_exam , Students_exam.score , 
Students_exam.start_date, Students_exam.end_date , exams.start_time , exams.end_time 
from Students_exam
join Users on Students_exam.fk_user = Users.id_user
join exams on Students_exam.fk_exam = exams.id_exam
group by exams.id_exam
order by users.name asc;
select * from view_Students_exam;

/*----------------vista preguntas respuesta-----------------------------------*/
drop view view_questions_answer;
CREATE VIEW view_questions_answer AS
SELECT questions_answer.id_Question_answer,students_exam_answer.fk_student_exam,
  questions.type_question, questions.description, questions.points, 
  questions_answer.answer,questions_answer.if_answer
FROM questions_answer
  JOIN students_exam_answer ON questions_answer.id_Question_answer = students_exam_answer.fk_answer
  JOIN questions ON questions_answer.fk_question = questions.id_Question
GROUP BY questions.type_question
ORDER BY questions.points ASC;

/*---------------vista estudiantes con sus respuestas-------------------------*/
drop view view_students_exam_answer;
create view view_students_exam_answer as 
select students_exam.id_student_exam , students_exam_answer.fk_question, 
questions.type_question , questions.points , questions.description,
students_exam_answer.answer from students_exam_answer 
join students_exam on students_exam_answer.fk_student_exam = students_exam.id_Student_exam
join questions on students_exam_answer.fk_question = questions.id_Question
group by questions.type_question
order by questions.points asc;
select * from view_students_exam_answer;

/*----------------------vista de examne preguntas--------------------------------*/
create view view_exam_questions as select exams.id_exam, exams.name_exam,
questions.id_Question, questions.type_question,
questions.points, questions.description from exam_questions
join exams on exam_questions.fk_exam=exams.id_exam
join questions on exam_questions.fk_question=questions.id_Question
group by questions.type_question
order by questions.points asc;
select * from view_exam_questions;

#----------------------INDICES Users-----------------------------------
ALTER TABLE users
DROP INDEX idx_users_enrollment;
select*from view_user;
/*indice unico*/
create unique index idx_users_enrollment on Users(enrollment);
/*indice simple*/
create index idx_users_name_type_user on Users (type_user);
/* indice compuesto*/
create index idx_users_name_surname on Users (name,surname);

#---------------------------INDICES EXAMS------------------------------------
create index idx_exams_code on exams (code);
/* indice compuesto*/
create index idx_exams_start_time_end_time on exams (start_time,end_time);

#--------------------------INDICES STUDENTS_EXAM----------------------------
/* indice simple*/
create index idx_students_exam_id_Student_exam on Students_exam (id_Student_exam);
/* indice compuesto*/
create index idx_students_exam_start_date_end_date on Students_exam (start_date,end_date);

#------------------------INDICES QUESTIONS----------------------------
/* indice simple*/
create index idx_questions_url_image on questions (url_image);
/* indice compuesto*/
create index idx_questions_id_question_type_question_ on questions (id_Question,type_question);
    
#------------------INDICES QUESTIONS_ANSWER-------------------------
/* indice simple*/
create index idx_questions_answer_id_Question_answer on Questions_answer (id_Question_answer);
/* indice compuesto */
create index idx_questions_answer_answer_if_answer on Questions_answer (answer,if_answer);

#--------------INDICES STUDENTS_EXAM_ANSWER-------------------
        /* indice simple*/
create index idx_Student_exam_answer_id_Student_exam_answer on Students_exam_answer (id_Student_exam_answer);
    /* indice compuesto */
create index idx_Student_exam_answer_fk_question_fk_answer on Students_exam_answer (fk_question,fk_answer);

#-----------------------INDICES EXAM_QUESTIONS-------------------------------
 /* indice simple*/
 create index idx_exam_questions_id_Exam_questions on Exam_questions (id_Exam_questions);
 /* indice compuesto */
create index idx_Exam_questions_fk_exam_fk_question on Exam_questions (fk_exam,fk_question);	

#------------------disparador before update User-----------------------
/*Este disparador funciona para que cuando actualice la contraseña sea mayor a 8 caracteres.
En que en caso de que sea menor a 8 caracteres, le mandara un mensaje de error.*/
drop trigger update_password;
delimiter $$
CREATE TRIGGER update_password
before UPDATE ON users
FOR EACH ROW
BEGIN																		#ya quedo
    if length(new.password) < 8 then
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'La contraseña debe tener más de 8 caracteres.';
    end if;
END;$$
update users set password='hola2' where enrollment = '20223tn089';
select * from view_user;
#----------------------disparador before update User------------------------------
/*La función de este trigger es de que cuando actualice un usuario y en status ponga
cualquier otra palabra, se ponga automaticamente "Inactivo".*/
drop trigger user_status;
delimiter $$
CREATE TRIGGER user_Status
before UPDATE ON users
FOR EACH ROW											
BEGIN
	IF NEW.status <> 'ACTIVO' or new.status <> 'Activo' THEN		#ya quedo
        SET NEW.status = 'INACTIVO';
    END IF;
END; $$
update users set status='ACTIVO' where id_user = 3;
select * from users;
delete from users where id_user =16;
#------------------------Disparador before delete user-------------------------------
drop trigger validate_user_exists;
DELIMITER $$
CREATE TRIGGER validate_user_exists
BEFORE DELETE ON Users
FOR EACH ROW
BEGIN
    DECLARE type_u INT(1);
    SELECT type_user INTO type_u FROM users WHERE id_user = old.id_user;                #Ya quedo
    IF type_u > 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuario no existe';
    END IF;
END;$$
select * from users;
delete from users where id_user =12;
insert into users values (4,'Jose','Castañeda','Lopez','CTCB04071MSLRMA3','ACTIVO',3,'20223tn089@utez.edu.mx','20223tn124','12345678');

#-----------------Disparador after delete user---------------------------------------
/*La función de este trigger es para cuando se elimine un usuario que sea estudiante, 
se elimine la relacion que tenga en la tabla students_exam.*/
drop trigger user_deleted_stu;
DELIMITER $$
CREATE TRIGGER User_deleted_stu
after DELETE ON Users 														
FOR EACH ROW
BEGIN
	DECLARE type_u INT(1);
    SELECT type_user INTO type_u FROM users WHERE id_user = old.id_user;			#ya quedo
    IF type_u = 3 THEN
        delete from students_exam where fk_user=id_user;
    END IF;
END;$$
delete from users where id_user =4;
select * from exams;
select * from users;
select * from students_exam;
insert into students_exam values(1,0,sysdate(),'',4,2);
use ucq_chido;
#--------------------disparador before insert user----------------------
/*El funcionamiento de este trigger es de que valide si el tipo de usuario que se 
esta insertando no supere el valor 3, ya que el tipo de usuario con valor = 4 no existe 
en nuestra base de datos. Otra validación que debe pasar es el correo, porque en caso de que el correo 
no sea de la Universidad, no lo dejara insertar y le mandara un mensaje de error.*/
drop trigger validate_mail;
DELIMITER $$
CREATE TRIGGER validate_mail
before INSERT
ON Users FOR EACH ROW
BEGIN
    if new.type_user>3 then												#ya quedo
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ERROR en el tipo de usuario.';
      elseIF NEW.mail NOT LIKE '%@utez.edu.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El campo mail debe contener la dirección de correo de "@utez.edu.mx".';
	END IF;
END;$$
insert into users values (0,'Cristian','Castañeda','Lopez','CTCB04071MSLRMA3','ACTIVO',3,'20223tn089@utez.edu.mx','20223tn739','12345678');
select * from users;
delete from users where id_user=9;

#--------------------------disparador after insert user--------------------------------
/*Este trigger se encarga de verificar si el nombre del usuario insertado en la tabla "users" contiene caracteres especiales. 
Si se encuentra algún carácter especial, se generará un error controlado para indicar que se han detectado caracteres especiales.
REGEXP es una función que se utiliza en SQL para realizar coincidencias de patrones mediante expresiones regulares. 
 Permite buscar y comparar cadenas de texto utilizando patrones más complejos que una simple comparación de igualdad.*/

drop trigger user_created;
DELIMITER $$
CREATE TRIGGER user_created
AFTER INSERT
ON Users FOR EACH ROW
BEGIN

	DECLARE diferent_name VARCHAR(100);
    DECLARE diferent_lastname VARCHAR(100);				#ya quedo 
    DECLARE diferent_surname VARCHAR(100);
		SET diferent_name = NEW.name;
        set diferent_lastname = new.lastname;
        set diferent_surname = new.surname;
	IF ( diferent_name REGEXP '[^a-zA-Z0-9 ]') or (diferent_lastname REGEXP '[^a-zA-Z0-9 ]') 
    or (diferent_surname REGEXP '[^a-zA-Z0-9 ]') THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se detectaron caracteres especiales';
END IF; 
 END$$
select * from users;
delete from users where id_user=4;
insert into users values (0,'Cristin','Casteda','Lopez','CTCB04071MSLRMA3','ACTIVO',3,'20223tn089@utez.edu.mx','20223tn19','12345678');

#-----------------------disparador before insert exams----------------------
/*Este trigger funciona para cuando inserte un examen, el código debe ser de 5 caracteres.
Si el código es menor a 5 caracteres, no dejara insertar el examen y ocurrira un mensaje de error.*/
drop trigger validate_code;
delimiter $$
CREATE TRIGGER validate_code
BEFORE INSERT ON exams
FOR EACH ROW
BEGIN
	IF length(new.code ) < 5 OR length(new.code) > 5 THEN
		SIGNAL SQLSTATE '45000'															#Ya quedo
		SET MESSAGE_TEXT = 'El código debe ser de 5 digitos.';
	END IF;
END;$$
select * from exams;
insert into exams values(2,'BD','XQ','2020-07-04','2020-07-05',2);
delete from exams where id_exam =2;
#------------------------disparador after insert exams-----------------------
/**/
drop trigger insert_inter;
delimiter $$
CREATE TRIGGER insert_inter
AFTER INSERT ON exams
FOR EACH ROW
BEGIN
DECLARE exams_count INT;
    SELECT COUNT(*) INTO exams_count                                               #ya quedo
    FROM exams
    WHERE id_exam = NEW.id_exam;
    IF exams_count > 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro del examen fracasó.';
    END IF;
END;$$
insert into exams values(1,'BD','XQC210','2020-07-04','2020-07-05',2);
select * from exams;
delete from exams where id_exam=6;

#---------------------------disparador before update exams---------------------------
/*La funcion de este trigger es para que cuando se actualize el código del examen y le mande un aviso de que
 de que es el mismo codigo que ya estaba antes.*/
drop trigger code_exam;
delimiter $$
CREATE TRIGGER code_exam
AFTER UPDATE ON exams
FOR EACH ROW
BEGIN
	IF NEW.code = OLD.code THEN																						#YA QUEDO
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo ingresado ya esta siendo ocupado. en este mismo examen';
	END IF;
END;$$
select*from exams;
update exams set code='XQdfd' where id_exam=2;

#--------------------------disparador BEFORE delete exams--------------------------
drop trigger validate_id_exam;
DELIMITER $$
CREATE TRIGGER validate_id_exam
BEFORE DELETE ON exams
FOR EACH ROW
BEGIN
																							#Ya quedo
    DECLARE exam_count INT;
    SELECT COUNT(*) INTO exam_count FROM exams WHERE id_exam = OLD.id_exam;
    IF exam_count > 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El ID del examen no existe.';
    END IF;
END$$
insert into exams values(2,'BD','XQg210','2020-07-04','2020-07-05',2);
select * from exams;
delete from exams where id_exam=3;
user 
#--------------------disparador AFTER delete exams-------------------------
/*En este trigger funciona para que despues de eliminar el examen, también elimine la relacion que 
tenga en la tabla de intersección llamada exam_questions.*/
delimiter $$
CREATE TRIGGER delete_exam_question
AFTER DELETE ON exams
FOR EACH ROW										
BEGIN
    declare id_ex int;
    set id_ex = old.id_exam;										#ya quedo perro
		delete from exam_questions where fk_exam=id_ex;
END;$$
select * from exams;
delete from exams where id_exam=2;
select * from exam_questions;
insert into exam_questions values(3,3,2);
select * from questions;
insert into questions values(3,'http',1,'QUE ES UN insert?',20);
/*delimiter $$
CREATE TRIGGER delete_question
AFTER DELETE ON exam_questions
FOR EACH ROW
BEGIN																#no hagas caso a esto.
    #DELETE FROM exam_questions WHERE fk_exam = OLD.id_Exam;
    declare id_ques int;
    set id_ques = old.fk_question;									#PUEDES PONERLO EN LA TABLA QUESTIONS EN AFTER DELETE
		delete from questions where id_Questions=id_ques;
END;$$*/
#------------------------disparador before insert Students_exam----------------------------
#La función de este trigger es para que solo permita insertar a los estudiantes en esta tabla.
drop trigger validate_student;
DELIMITER $$
CREATE TRIGGER validate_student
BEFORE INSERT
ON Students_exam FOR EACH ROW
BEGIN
    DECLARE type_u INT(1);
    SELECT type_user INTO type_u FROM users WHERE id_user = NEW.fk_user;				#ya quedo
    IF type_u != 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No es un estudiante.';
    END IF;
END$$
insert into students_exam (id_student_exam,start_date,end_date,fk_user,fk_exam)values(1,sysdate(),'',3,1);
select * from students_exam;
select * from exams;
use ucq_chido;
#--------------------------disparador after insert Students_exam------------------------
drop trigger trigger_inserted_student_exam;
DELIMITER $$
CREATE TRIGGER trigger_inserted_student_exam
AFTER INSERT
ON Students_exam FOR EACH ROW
BEGIN
																							#ya quedo
    DECLARE type_u INT(1);
    SELECT type_user INTO type_u FROM users WHERE id_user = NEW.fk_user;
    IF type_u != 3 AND type_u >3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es un estudiante el tipo de usuario.';
    END IF;
END$$
insert into students_exam (id_student_exam,start_date,end_date,fk_user,fk_exam)values(3,sysdate(),'',3,1);
select * from students_exam;
select * from users;
delete from students_exam where id_student_exam=2;
#-----------------------disparador before delete Students_exam--------------------
/*La función de este trigger es de que antes de eliminar a algun id del estudiante, verifica 
si esta haciendo un examen. En caso de que aún no termine su examen, no podra eliminarlo y 
mandara un mensaje de error.*/
drop trigger validate_time_exam;
delimiter $$
CREATE TRIGGER validated_time_exam
before delete
ON Students_exam FOR EACH ROW
BEGIN
	IF old.end_date = '0000-00-00 00:00:00' THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'el estudiante aun tiene un examen en progreso';
    END IF;
END;$$
insert into students_exam (start_date,end_date,fk_user,fk_exam)values(sysdate(),'',3,1);					#YA QUEDO
insert into students_exam (start_date,end_date,fk_user,fk_exam)values(sysdate(),'',3,1);
select * from Students_exam;
DELETE FROM students_exam WHERE id_student_exam = 5;
use ucq_chido;
#-------------------disparador after delete Students_exam----------------------
/*El trigger se encarga de eliminar la relación existente entre un estudiante y un examen, así 
como las respuestas proporcionadas por el estudiante a una pregunta particular.*/
delimiter $$
CREATE TRIGGER delete_students_exam
after delete
ON Students_exam FOR EACH ROW                   						
BEGIN
	declare id_studen int;
    set id_studen = old.id_student_exam;										#ya quedo perro
		delete from students_exam_answer where fk_student_exam=id_studen;
END;$$
select * from students_exam;
delete from students_exam where id_student_exam=1;
select * from students_exam_answer;

#--------------Disparador before update students_exam---------------
/*Este trigger sirve para cuando se actualize la calificacion, ponga la fecha y hora en la que termino el examen el estudiante*/
drop trigger calification_exam;
DELIMITER $$
CREATE TRIGGER calification_exam
before UPDATE ON Students_exam											#YA QUEDO
FOR EACH ROW
BEGIN
  SET NEW.end_date = NOW();
END $$
update Students_exam set score=100 where id_student_exam=5;
select * from students_exam;
#--------------disparador before insert questions----------------
drop trigger count_points;
delimiter $$
CREATE TRIGGER count_points
BEFORE INSERT ON questions
FOR EACH ROW
BEGIN
	DECLARE total_points INT;
	-- Calcular la suma de los puntos de todas las preguntas			#ya quedo
	SELECT SUM(points) INTO total_points FROM questions;
	-- Verificar si la suma total excede los 100 puntos
	IF total_points > 100 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La suma de puntos excede los 100';
	END IF;
END;$$
delete from questions where id_question=3;
insert into questions values(5,'http',2,'QUIEN ES el pepe?',1);
select * from questions;
use ucq_chido;
#--------------------disparador after insert questions---------------------------
delimiter $$
CREATE TRIGGER validate_type_question_trigger
AFTER INSERT ON questions
FOR EACH ROW
BEGIN
    -- Validar el atributo type_question
    IF NEW.type_question <> 1 AND NEW.type_question <> 2 THEN						#creo ya
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El valor del atributo type_question no es válido.';
    END IF;
END;$$

#-----------------disparador before update questions---------------------
/*La funcion de este trigger es para los tipos de preguntas que hay (1 = opcional y 2 = abierta),
si actualiza y esta con el mismo numero que contenia anteriormente, le mande un mensaje de error diciendo
que es el mismo valor que estaba anteriormente.*/
drop trigger validate_type_question;
delimiter $$
CREATE TRIGGER validate_type_question
BEFORE UPDATE ON questions
FOR EACH ROW
BEGIN
    -- Verificar si el nuevo valor de type_question es igual al valor existente						#ya quedo 
    IF NEW.type_question = OLD.type_question THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se permite actualizar con el mismo valor de type_question';
    END IF;
END;$$
update questions set type_question =2 where id_question=2;
select * from questions;
#------------------disparador after update questions-------------------------

DELIMITER $$
CREATE TRIGGER after_update_questions
AFTER UPDATE ON Questions
FOR EACH ROW
BEGIN
IF NEW.id_Question <> OLD.id_Question THEN
        -- Actualizar la clave foránea en la tabla Questions_answer
        UPDATE Questions_answer SET fk_question = NEW.id_Question WHERE fk_question = OLD.id_Question;		#ya quedo
        
        -- Actualizar la clave foránea en la tabla Students_exam_answer
        UPDATE Students_exam_answer SET fk_question = NEW.id_Question WHERE fk_question = OLD.id_Question;
        
        -- Actualizar la clave foránea en la tabla Exam_questions
        UPDATE Exam_questions SET fk_question = NEW.id_Question WHERE fk_question = OLD.id_Question;
    END IF;
END;$$

#--------------------disparador before delete questions--------------------------
/*La funcion de este trigger es para cuando se quiera eliminar una pregunta, 
no lo deje ya que estara relacionado a un examen*/
drop trigger check_questions_correct;
DELIMITER $$
CREATE TRIGGER check_questions_correct
BEFORE DELETE ON Questions
FOR EACH ROW
BEGIN
  DECLARE questions_count INT;
  SELECT COUNT(*) INTO questions_count												#ya quedo
  FROM exam_Questions
  WHERE fk_Question = OLD.id_Question;
  IF questions_count > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La pregunta ya esta asignada con un id en un examen no puede borrarse.';
  END IF;
END; $$
use ucq_chido;
#--------------------disparador after delete questions---------------------
drop trigger after_delete_trigger;
DELIMITER $$
CREATE TRIGGER after_delete_trigger
AFTER DELETE ON Questions
FOR EACH ROW
BEGIN
    DECLARE questions_count INT;
  SELECT COUNT(*) INTO questions_count
  FROM exam_Questions														#si jala
  WHERE fk_Question = OLD.id_Question;
  IF questions_count >0 THEN
      delete from Questions where id_Question;
  END IF;
END;$$
select*from Questions;
delete from Questions where id_question=1;
select * from exam_questions;
use ucq_chido;

-- Triggers Students_Exam_answer--------------------------
-- BEFORE insert
drop trigger before_insert_answer;
DELIMITER $$
CREATE TRIGGER before_insert_answer
BEFORE INSERT ON students_exam_answer
FOR EACH ROW
BEGIN
 DECLARE answer_name VARCHAR(254);
 SET answer_name = NEW.answer;
 /*
 REGEXP es una función que se utiliza en SQL para realizar coincidencias de patrones mediante expresiones regulares. 
 Permite buscar y comparar cadenas de texto utilizando patrones más complejos que una simple comparación de igualdad.
 */
 IF (answer_name REGEXP '[^a-zA-Z0-9 ]') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se detectaron caracteres especiales en la respuesta';					#ya quedo
 END IF;
END;$$
select * from students_exam;
select * from students_exam_answer;
insert into students_exam_answer values(1,5,'no c',1,2);
select *from Questions;
select * from questions_answer;
insert into questions_answer values(1,'si',1,2);

# ------------------after insert Students_exam_answer
DELIMITER $$
CREATE TRIGGER after_insert_students_exam_answer
AFTER INSERT ON students_exam_answer
FOR EACH ROW
BEGIN
    DECLARE answer_count INT;
    SELECT COUNT(*) INTO answer_count																								#este we
    FROM students_exam_answer
    WHERE id_student_exam_answer = NEW.id_student_exam_answer;
    IF answer_count > 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro de la respuesta ha fallado.';
    END IF;
END$$
-- BEFORE DELETE Students_exam_answer
DELIMITER $$
CREATE TRIGGER trigger_after_delete_students_exam_answer
AFTER DELETE ON students_exam
FOR EACH ROW
BEGIN																
	DELETE FROM students_exam_answer WHERE fk_student_exam = OLD.id_Student_exam;		#ya quedo
END;$$


-- AFTER DELETE Students_exam_answer
drop trigger before_delete_students_exam_answer;
DELIMITER $$
CREATE TRIGGER before_delete_students_exam_answer
BEFORE DELETE ON Students_exam_answer
FOR EACH ROW
BEGIN																						#ya quedo
    IF OLD.fk_student_exam >0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se pudo eliminar.';
    END IF;
END;
$$
DELIMITER ;

#---------------------Procedimientos-----------------------
#Procedimientos
DELIMITER $$
CREATE PROCEDURE crear_usuarios(
    name_in VARCHAR(254),
    lastname_in VARCHAR(254),
    surname_in VARCHAR(254),
    curp_in VARCHAR(18),
    status_in VARCHAR(7),
    type_user_in INT(1),
    mail_in VARCHAR(254),
    enrollment_in VARCHAR(10),
    password_in VARCHAR(254)
)
BEGIN
    DECLARE conteo INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    -- Buscar si existe un cliente con el mismo nombre, enrollment, curp y email
    SELECT COUNT(*) INTO conteo FROM users WHERE mail = mail_in OR enrollment = enrollment_in OR curp = curp_in;
    IF conteo = 0 THEN
        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al intentar registrar el usuario en la base de datos';
                ROLLBACK;
            END;
            INSERT INTO users(name, lastname, surname, curp, status, type_user, mail, enrollment, password)
            VALUES (name_in, lastname_in, surname_in, curp_in, status_in, type_user_in, mail_in, enrollment_in, password_in);
            COMMIT;
        END;
    ELSE
        SELECT 'El usuario que se intenta registrar YA existe en la base de datos';
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;
    drop procedure crear_usuarios;
     call crear_usuarios('Ayala','punk','Acosra','246810','Activo',2,'ayala@outlook.com','20223tn087','xdxd');
    
    select * from users;
    
drop procedure actualizar_usuario;

DELIMITER $$
CREATE PROCEDURE actualizar_usuario(
    id_user_new INT,
    name_new VARCHAR(254),
    lastname_new VARCHAR(254),
    surname_new VARCHAR(254),
    curp_new VARCHAR(18),
    status_new VARCHAR(7),
    type_user_new INT(1),
    mail_new VARCHAR(254),
    enrollment_new VARCHAR(10),
    password_new VARCHAR(254)
)
BEGIN
    DECLARE usuario_existente INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO usuario_existente FROM users WHERE id_user = id_user_new FOR UPDATE;
    IF usuario_existente > 0 THEN
        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al intentar actualizar el usuario en la base de datos';
                ROLLBACK;
            END;
            UPDATE users
            SET name = name_new,
                lastname = lastname_new,
                surname = surname_new,
                curp = curp_new,
                status = status_new,
                type_user = type_user_new,
                mail = mail_new,
                enrollment = enrollment_new,
                password = password_new
            WHERE id_user = id_user_new;
            COMMIT;
        END;
    ELSE
        SELECT 'El usuario que intenta actualizar NO existe' AS mensaje;
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;
call actualizar_usuario(5,'Ayala','Ramirez','david','ADSA23243','Activo',2,'ayala@gmail.com','20223tn087','123ads');
select * from users;

drop procedure eliminar_usuario;
DELIMITER $$
CREATE PROCEDURE eliminar_usuario(id INT)
BEGIN
    DECLARE usuario_existente INT DEFAULT 0;
    SET autocommit = 0;
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO usuario_existente FROM users WHERE id_user = id FOR UPDATE;
    IF usuario_existente > 0 THEN
        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al eliminar el usuario: ';
                ROLLBACK;
            END;
            DELETE FROM users WHERE id_user = id;
            SELECT 'usuario eliminado' AS mensaje;
        END;
    ELSE
        SELECT 'El usuario a eliminar no existe' AS mensaje;
        ROLLBACK;
    END IF;
    COMMIT;
    SET autocommit = 1;
    SET SQL_SAFE_UPDATES = 0;
END$$
DELIMITER ;

 select * from users;
 call eliminar_usuario(6);


DELIMITER $$
CREATE PROCEDURE consultar_usuarios(
     id_buscar INT,
     name_buscar VARCHAR(254),
     curp_buscar VARCHAR(254),
     enrollment_buscar VARCHAR(254)
)
BEGIN
    SET autocommit = 0;
    START TRANSACTION;
    IF name_buscar = '' AND curp_buscar = '' AND enrollment_buscar = '' THEN
        SELECT * FROM Users;
    ELSE
        IF name_buscar != '' THEN
            SELECT * FROM Users WHERE name LIKE CONCAT(name_buscar, '%');
        END IF;
        IF curp_buscar != '' THEN
            SELECT * FROM Users WHERE curp = curp_buscar;
        END IF;
        IF enrollment_buscar != '' THEN
            SELECT * FROM Users WHERE enrollment = enrollment_buscar;
        END IF;
        IF name_buscar IS NULL OR curp_buscar IS NULL OR enrollment_buscar IS NULL THEN
            SELECT 'Error: Los parámetros de búsqueda contienen valores nulos.' AS mensaje;
        END IF;
    END IF;
    COMMIT;
    SET autocommit = 1;
END$$
DELIMITER ;


drop procedure consultar_usuarios;
  CALL consultar_usuarios(0,'p','','');
 select * from users;
DELIMITER $$
 select * from users;
 
 
 -- Examenes procedimientos almacenados
 drop procedure crear_examenes;
 DELIMITER $$
CREATE PROCEDURE crear_examenes(
	id_exam_in int,
    name_exam_in VARCHAR(254),
    code_in VARCHAR(5),
    start_time_in timestamp,
    end_time_in timestamp ,
    fk_user_in int
)
BEGIN
    DECLARE conteo INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    -- Buscar si existe un examen con el mismo codigo
    SELECT COUNT(*) INTO conteo FROM exams WHERE  code = code_in;
    IF conteo = 0 THEN
    BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al intentar registrar el examen en la base de datos';
                ROLLBACK;
            END;
        INSERT INTO exams(id_exam,name_exam, code, start_time, end_time, fk_user) VALUES 
        (id_exam_in,name_exam_in, code_in, start_time_in, end_time_in, fk_user_in);
        COMMIT;
        END;
    ELSE
        SELECT 'El examen que intenta registrar YA existe en la base de datos';
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;
 
 call crear_examenes (4,'Base de datos','1sass','2023-07-07 05:25','2023-07-09 07:30',3);
 
 select * from exams;
 
 
 DELIMITER $$
CREATE PROCEDURE actualizar_examen(
    id_exam_new INT,
    name_exam_new VARCHAR(254),
    code_new VARCHAR(5),
    start_time_new timestamp,
    end_time_new timestamp,
    fk_user_new INT)
BEGIN
    DECLARE examen_existente INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO examen_existente FROM exams WHERE id_exam = id_exam_new FOR UPDATE;
    IF examen_existente > 0 THEN
    BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al intentar actualizar el usuario en la base de datos';
                ROLLBACK;
            END;
        UPDATE exams
        SET name_exam = name_exam_new,code = code_new, 
        start_time = start_time_new,end_time = end_time_new,fk_user = fk_user_new
        WHERE id_exam = id_exam_new;
        commit;
        END;
    ELSE
        SELECT 'El examen que intenta actualizar NO existe' AS mensaje;
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;
drop procedure actualizar_examen;
 call actualizar_examen (2,'Geografia','axdse','2023-09-07 05:25','2023-09-12 07:30',3);
select * from exams;

DELIMITER $$
CREATE PROCEDURE eliminar_examen(id INT)
BEGIN
    DECLARE examen_existente INT DEFAULT 0;
    SET autocommit = 0;
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
    
    SELECT COUNT(*) INTO examen_existente FROM exams WHERE id_exam = id;
    
    IF examen_existente > 0 THEN
        BEGIN
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al eliminar el examen' AS mensaje;
                ROLLBACK;
            END;
            
            DELETE FROM exams WHERE id_exam = id;
            SELECT 'Examen eliminado' AS mensaje;
        END;
    ELSE
        SELECT 'El examen a eliminar no existe' AS mensaje;
        ROLLBACK;
    END IF;
    
    COMMIT;
    SET autocommit = 1;
    SET SQL_SAFE_UPDATES = 0;
END$$
DELIMITER ;



drop procedure eliminar_examen;
select * from exams;
 call eliminar_examen(4);
 use ucq_chido;
 
DELIMITER $$
CREATE PROCEDURE consultar_examenes(
    id_buscar INT,
    name_exam_buscar VARCHAR(254),
    code_buscar VARCHAR(5)
)
BEGIN
    SET autocommit = 0;
    START TRANSACTION;
    IF name_exam_buscar = '' AND code_buscar = '' THEN
        SELECT * FROM exams;
    ELSE
        IF name_exam_buscar != '' THEN
            SELECT * FROM exams WHERE name_exam=name_exam_buscar;
        END IF;
        IF code_buscar != '' THEN
            SELECT * FROM exams WHERE code = code_buscar;
        END IF;
        IF name_exam_buscar IS NULL OR code_buscar IS NULL THEN
            SELECT 'Error: Los parámetros de búsqueda contienen valores nulos.' AS mensaje;
        END IF;
        END IF;
    COMMIT;
    SET autocommit = 1;
END
$$
DELIMITER ;

drop procedure consultar_examenes;
 CALL consultar_examenes(0,'','abcd');
 select * from exams;