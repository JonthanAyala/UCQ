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
insert into users values (0,'Emilio','alpizar','Garcia','AIGE041218HMSLRMA3','ACTIVO',1,'20223tn084@utez.edu.mx','20223tn084','Admin');
insert into users values (0,'Axel','Ocampo','Galvez','OCGA040719HMSLRMA3','ACTIVO',2,'20223tn086@utez.edu.mx','20223tn086','12345678');
insert into users values (0,'Cristian','Castañeda','Lopez','CTCB040719HMSLRMA3','ACTIVO',3,'20223tn089@utez.edu.mx','20223tn089','12345678');

#-----------------------tablas exams---------------------
drop table exams;
CREATE TABLE exams (
    id_exam INT NOT NULL,
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
insert into exams values(0,'BD','XQC210','2020-07-04','2020-07-05',2);
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
insert into students_exam (start_date,end_date,fk_user,fk_exam)values('','',3,1);
select * from view_Students_exam;
#-----------------------tablas questions---------------------
drop table questions;
CREATE TABLE Questions (
  id_Question INT(5) NOT NULL,
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
  id_Question_answer INT NOT NULL,
  answer VARCHAR(254) NOT NULL,
  if_answer TINYINT NOT NULL,
  fk_question INT(5) NOT NULL,
  PRIMARY KEY (id_Question_answer),
    FOREIGN KEY (fk_question)
    REFERENCES Questions (id_Question)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

#-----------------------tablas Students_exam_answer---------------------
drop table Students_exam_answer;
CREATE TABLE Students_exam_answer (
  id_Student_exam_answer INT NOT NULL,
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
drop table view_questions_answer;
create view view_questions_answer as 
select questions_answer.id_Question_answer, students_exam_answer.fk_student_exam,
questions.type_question, questions.description, questions.points,
students_exam_answer.answer, questions_answer.answer, questions_answer.if_answer from questions_answer 				#CHECAR
join students_exam_answer on questions_answer.id_Question_answer = students_exam_answer.fk_answer
join questions on questions_answer.fk_question= questions.id_Question
group by questions.type_question
order by questions.points asc;
select * from view_questions_answer;

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
create index idx_Exam_questions_fk_exam_fk_question on Exam_questions (fk_exam,fk_question);	#no ejecutadp

#------------------disparador before update User-----------------------
/*Este disparador funciona para que cuando actualice la contraseña sea mayor a 8
caracteres*/
drop trigger update_password;
delimiter $$
CREATE TRIGGER update_password
before UPDATE ON users
FOR EACH ROW
BEGIN													#ya quedo
    if length(new.password) < 8 then
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'La contraseña debe tener más de 8 caracteres.';
    end if;
END;$$
update users set password='hola2' where enrollment = '20223tn089';
select * from view_user;
#----------------------disparador after update User------------------------------
drop trigger user_status;
delimiter $$
CREATE TRIGGER user_Status
AFTER UPDATE ON users
FOR EACH ROW											
BEGIN
														#FALTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
END; $$
update users set password='hola2' where enrollment = '20223tn089';
select * from users;
#------------------------Disparador before delete user-------------------------------
drop trigger validate_user_exists;
DELIMITER $$
CREATE TRIGGER validate_user_exists
BEFORE DELETE ON Users
FOR EACH ROW
BEGIN
    if old.type_user >3 then
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Usuario no existe.';
    end if;
END;$$
select * from users;
delete from users where type_user =;
insert into users values (0,'Cristian','Castañeda','Lopez','CTCB040719HMSLRMA3','ACTIVO',3,'20223tn089@utez.edu.mx','20223tn089','12345678');
#-----------------Disparador after delete user---------------------------------------
DELIMITER $$
CREATE TRIGGER User_deleted
after DELETE ON Users 														
FOR EACH ROW
BEGIN
										#faltaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
END;$$

#--------------------disparador before insert user----------------------
DELIMITER $$
CREATE TRIGGER validate_mail
before INSERT
ON Users FOR EACH ROW
BEGIN
    if new.type_user >3 then										#ya quedo
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ERROR.';
      elseIF NEW.mail NOT LIKE '%@utez.edu.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El campo mail debe contener la dirección de correo de "@utez.edu.mx".';
	END IF;
END;$$

#--------------------------disparador  after insert user--------------------------------
DELIMITER $$
CREATE TRIGGER user_created
AFTER INSERT
ON Users FOR EACH ROW
BEGIN
														#faltaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
END;$$

#-----------------------disparador before insert exams----------------------
delimiter $$
CREATE TRIGGER validate_time
BEFORE INSERT ON exams
FOR EACH ROW
BEGIN
    if new.end_time < new.start_time then
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ERROR EN EL TIEMPO';
    end if;
END;$$
select * from exams;

#------------------------disparador after insert exams-----------------------
drop trigger insert_inter;
delimiter $$
CREATE TRIGGER insert_inter
AFTER INSERT ON exams
FOR EACH ROW
BEGIN
										#FALTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
END;$$

#---------------------------disparador after update exams---------------------------
delimiter $$
CREATE TRIGGER update_exam_trigger
AFTER UPDATE ON exams
FOR EACH ROW
BEGIN
	-- Validar si el valor de "end_time" es menor que el valor de "start_time"
    IF NEW.end_time < NEW.start_time THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tiempo final es anterior al tiempo de inicio';
    END IF;
END;$$

#---
#--------------------------disparador BEFORE delete exams--------------------------
delimiter $$
CREATE TRIGGER validar_id_exam
BEFORE DELETE
ON exams FOR EACH ROW
BEGIN
    -- Verificar si existe un ID de examen existente
    IF NOT EXISTS(SELECT * FROM exams WHERE id_exam = OLD.id_exam) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El ID del examen no existe.';
    END IF;
END;$$

#--------------------disparador AFTER delete exams-------------------------
delimiter $$
CREATE TRIGGER delete_exam
AFTER DELETE ON exams
FOR EACH ROW
BEGIN
    DELETE FROM exams WHERE id_exam = OLD.id_exam;
END;$$

#------------------------disparador before insert Students_exam----------------------------
#Sirve para validar que el tipo de usuario solo sea un estudiante.
drop trigger validate_student;
DELIMITER $$
CREATE TRIGGER validate_student
BEFORE INSERT
ON Students_exam FOR EACH ROW
BEGIN
    DECLARE type_u INT(1);
    SELECT type_user INTO type_u FROM users WHERE id_user = NEW.fk_user;		#ya quedo
    IF type_u != 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No es un estudiante.';
    END IF;
END$$
insert into students_exam (id_student_exam,start_date,end_date,fk_user,fk_exam)values(2,'','',3,1);
select * from students_exam;
#--------------------------disparador after insert Students_exam------------------------
drop trigger trigger_inserted_student_exam;
DELIMITER $$
CREATE TRIGGER trigger_inserted_student_exam
AFTER INSERT
ON Students_exam FOR EACH ROW
BEGIN
    SET old.start_date = NOW();
END$$
insert into students_exam (id_student_exam,start_date,end_date,fk_user,fk_exam)values(2,'','',3,1);
select * from students_exam;
delete from students_exam where id_student_exam=2;
#-----------------------disparador before delete Students_exam--------------------
delimiter $$
CREATE TRIGGER validate_student
before delete
ON Students_exam FOR EACH ROW
BEGIN
	IF (SELECT * FROM Students_exam WHERE fk_user != 3) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El ID del estudiante no existe.';
	end if;
END;$$

#-------------------disparador after delete Students_exam----------------------
delimiter $$
CREATE TRIGGER validate_student
after delete
ON Students_exam FOR EACH ROW                    
BEGIN
    delete from students_exam where id_Student_exam;
END;$$
#--------------Disparador before update students_exam---------------
/*Este trigger sirve para cuando se actualize la calificacion, ponga la fecha y hora en la que termino el examen*/
drop trigger end_exam;
DELIMITER $$
CREATE TRIGGER end_exam
before UPDATE ON Students_exam											#YA QUEDO
FOR EACH ROW
BEGIN
  SET NEW.end_date = NOW();
END $$
update Students_exam set score=100 where id_student_exam=1;
select * from students_exam;
#--------------disparador before insert questions----------------
delimiter $$
CREATE TRIGGER count_points_trigger
BEFORE INSERT ON questions
FOR EACH ROW
BEGIN
DECLARE total_points INT;
-- Calcular la suma de los puntos de todas las preguntas			#segun ya
SELECT SUM(points) INTO total_points FROM questions;
-- Verificar si la suma total excede los 100 puntos
IF total_points >= 100 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La suma de puntos excede los 100';
END IF;
END;$$

#--------------------disparador after insert questions---------------------------
delimiter $$
CREATE TRIGGER validate_type_question_trigger
AFTER INSERT ON questions
FOR EACH ROW
BEGIN
    -- Validar el atributo type_question
    IF NEW.type_question <> 1 AND NEW.type_question <> 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El valor del atributo type_question no es válido.';
    END IF;
END;$$

#-----------------disparador before update questions---------------------
delimiter $$
CREATE TRIGGER validate_type_question_trigger
BEFORE UPDATE ON questions
FOR EACH ROW
BEGIN
    -- Verificar si el nuevo valor de type_question es igual al valor existente
    IF NEW.type_question = OLD.type_question THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se permite actualizar con el mismo valor de type_question';
    END IF;
END;$$

#------------------disparador after update questions-------------------------

DELIMITER $$
CREATE TRIGGER after_update_trigger
AFTER UPDATE ON Questions
FOR EACH ROW
BEGIN
-- Validar si todos los datos están correctos
IF NEW.id_Question IS NOT NULL
AND NEW.url_image IS NOT NULL
AND NEW.type_question IS NOT NULL
AND NEW.description IS NOT NULL
AND NEW.points IS NOT NULL THEN
-- Mensaje de error
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Uno o más campos requeridos están incompletos.';
END IF;
END;$$

#--------------------disparador before delete questions--------------------------
DELIMITER $$
CREATE TRIGGER check_questions_correct
BEFORE DELETE ON Questions
FOR EACH ROW
BEGIN
  DECLARE questions_count INT;
  SELECT COUNT(*) INTO questions_count
  FROM exam_Questions
  WHERE fk_Question = OLD.id_Question;
  IF questions_count > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La pregunta ya esta asignada con un id en un examen.';
  END IF;
END; $$

#--------------------disparador after delete questions---------------------
DELIMITER $$
CREATE TRIGGER after_delete_trigger
AFTER DELETE ON Questions
FOR EACH ROW
BEGIN
    signal sqlstate '45000'
SET MESSAGE_TEXT = 'Se elimino la pregunta y su contenido';
delete from Questions where id_Question;
END;$$

#---------------------disparador before insert Questions_answer-----------------------
delimiter $$
CREATE TRIGGER tr_check_answer
BEFORE INSERT ON questions_answer
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);
    
    -- Validar si el campo answer está vacío
    IF NEW.answer IS NULL OR NEW.answer = '' THEN
        -- Generar mensaje de error
        SET error_message = 'El campo "answer" no puede estar vacío.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;$$

#---------------------disparador after insert Questions_answer---------------------
DELIMITER $$
-- Crear el trigger
CREATE TRIGGER check_if_answer
AFTER INSERT ON questions_answer
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);
    
    -- Validar el valor de if_answer
    IF NEW.if_answer <> 'verdadero' AND NEW.if_answer <> 'falso' THEN
        -- Generar mensaje de error
        SET error_message = 'El valor de if_answer debe ser "verdadero" o "falso".';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END; $$

#---------------------disparador before update Questions_answer-------------------------------------
delimiter $$
CREATE TRIGGER tr_check_answer_if_answer
BEFORE UPDATE ON Questions_answer
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);
    
    -- Validar si answer e if_answer son diferentes
    IF NEW.answer = NEW.if_answer THEN
        -- Generar mensaje de error
        SET error_message = 'Los campos "answer" e "if_answer" deben tener respuestas distintas.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;$$

#----------------------disparador after update Questions_answer-------------------------------
delimiter $$
CREATE TRIGGER after_update_trigger
AFTER UPDATE ON Questions_answer
FOR EACH ROW
BEGIN
    -- Validar si todos los datos están correctos
    IF NEW.id_Question_answer IS NOT NULL
        AND NEW.answer IS NOT NULL
        AND NEW.if_answer IS NOT NULL
        AND NEW.fk_Question IS NOT NULL THEN
        -- Mensaje de éxito
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Los datos se han actualizado correctamente.';
    ELSE
        -- Mensaje de error
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Uno o más campos requeridos están incompletos.';
    END IF;
END;$$

#---------------------disparador before delete Questions_answer------------------------------------
DELIMITER $$
CREATE TRIGGER check_questions_answer_correct
BEFORE DELETE ON Questions
FOR EACH ROW
BEGIN
  DECLARE questions_answer_count INT;
  SELECT COUNT(*) INTO questions_answer_count
  FROM Questions_answer
  WHERE fk_Question = OLD.id_question;
  -- Verificar si hay respuestas asociadas con un id de pregutna
  IF questions_answer_count > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La respuesta ya esta asignada con una pregunta.';
  END IF;
END;$$

#----------------------disparador after delete Questions_answer-----------------------------------
DELIMITER $$
CREATE TRIGGER delete_answer
AFTER DELETE ON Questions_answer
FOR EACH ROW
BEGIN
    signal sqlstate '45000'
SET MESSAGE_TEXT = 'Se elimino la respuesta de la pregunta';
delete from Questions_answer where id_Question_answer;
END;$$

#-------------------disparador before insert Exam_questions----------------------
/*delimiter $$
CREATE TRIGGER tr_check_fk_question_exam
BEFORE INSERT ON Exam_questions
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);
    DECLARE count_records INT;

    -- Verificar si existe una relación entre fk_Question y fk_Exam en las tablas question y exam
    SELECT COUNT(*) INTO count_records
    FROM question q
    INNER JOIN exam e ON q.fk_Exam = e.id_Exam
    WHERE q.id_Question = NEW.fk_Question AND e.id_Exam = NEW.fk_Exam;

    -- Validar la existencia de la relación
    IF count_records = 0 THEN
        -- Generar mensaje de error
        SET error_message = 'La relación entre fk_Question y fk_Exam no existe en las tablas question y exam.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;$$
*/
#------------------disparador after insert Exam_questions-----------------------
/*DELIMITER $$
-- Crear el trigger
CREATE TRIGGER tr_check_relations_exam_questions
AFTER INSERT ON exam_questions
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);
    DECLARE count_records INT;
    
    -- Verificar si existe una relación entre id_Examen_pregunta, fk_Question y fk_Exam en las tablas question y exam
    SELECT COUNT(*) INTO count_records
    FROM question q
    INNER JOIN exam e ON q.fk_Exam = e.id_Exam
    WHERE q.id_Question = NEW.fk_Question AND e.id_Exam = NEW.fk_Exam;
    
    -- Validar la existencia de la relación
    IF count_records = 0 THEN
        -- Generar mensaje de error
        SET error_message = 'La relación entre id_Examen_pregunta, fk_Question y fk_Exam no existe en las tablas question y exam.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        -- Generar mensaje de éxito
        SET error_message = 'La inserción se realizó correctamente.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;$$
*/
#--------------------------disparador before update Exam_questions------------------------------
/*DELIMITER $$
CREATE TRIGGER tr_check_id_exam_question
BEFORE UPDATE ON exam_questions
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);
    
    -- Verificar si el nuevo valor de id_Examen_questions es distinto al valor ya almacenado
    IF NEW.id_Examen_questions <> OLD.id_Examen_questions THEN
        -- Validar si el nuevo valor de id_Examen_questions está repetido
        IF EXISTS (SELECT 1 FROM exam_questions WHERE id_Examen_questions = NEW.id_Examen_questions) THEN	
            -- Generar mensaje de error
            SET error_message = 'Número de pregunta repetido en la tabla exam_questions.';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;
    END IF;
END;$$
*/
#--------------------------disparador after update Exam_questions-------------------------------
/*DELIMITER $$
CREATE TRIGGER updated_data
AFTER UPDATE ON Questions_answer
FOR EACH ROW
BEGIN
    -- Validar si todos los datos están correctos
    IF NEW.id_Question_answer IS NOT NULL
        AND NEW.answer IS NOT NULL
        AND NEW.if_answer IS NOT NULL
        AND NEW.fk_Question IS NOT NULL THEN
        -- Mensaje de éxito
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Los datos se han actualizado correctamente.';
    ELSE
        -- Mensaje de error
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Uno o más campos requeridos están incompletos.';
    END IF;
END;$$
*/
#-------------------------disparador before delete Exam_questions------------------------
/*DELIMITER $$
CREATE TRIGGER delete_questions_answer_correct
BEFORE DELETE ON Questions
FOR EACH ROW
BEGIN
  DECLARE Exam_Question_count INT;
  SELECT COUNT(*) INTO Exam_Question_count
  FROM Exam_Questions
  WHERE fk_Question = OLD.id_question;
  -- Verificar si hay respuestas asociadas con un id de pregunta
  IF Exam_Question_count > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La respuesta ya esta asignada con una pregunta.';
  END IF;
END; $$
*/
#----------------------disparador after delete Exam_questions------------------------
/*DELIMITER $$
CREATE TRIGGER after_delete_trigger_exam_question
AFTER DELETE ON exam_questions
FOR EACH ROW
BEGIN
    signal sqlstate '45000'
SET MESSAGE_TEXT = 'Se elimino el registro de la tabla';
delete from Questions_answer where id_Question_answer;
END;$$*/