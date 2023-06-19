create database UCQ_prueba;
use UCQ_prueba;
 alter table Users change statuts status varchar(7) not null;
 select * from Users;
 describe users;
 #----------------------------------------------------------------
create table Users(
	id_user int(254) not null auto_increment,
	name varchar(254) not null,
    surname varchar(254) not null,
    curp varchar (18) not null,
    status varchar(7) not null,
    type_user int(1) not null,
    mail varchar(254),
    enrollment varchar (10),
    password varchar(254),
    primary key (id_user)
);

insert into users values (0,'Emilio','alpizar','AIGE041218HMSLRMA3','activo', 3,'20223tn.edu@utez.edu.mx' );
/*vistas de users_______________________________________________________________________________________________________________________________________________________*/
create view vista_user as 
select * from users
group by type_user, enrollment order by type_user asc, enrollment asc;
select * from vista_user;

#INDICES________________________________________________________________________________________________________________________________________________________________
create unique index idx_users_type_user on Users(type_user);
/* indice simple*/
create index idx_users_enrollment on Users (enrollment);
/* indice compuesto*/
create index idx_users_name_surname on Users (name,surname);

#disparador before update________________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER update_password
before UPDATE ON users
FOR EACH ROW
BEGIN
    if new.password < 8 then
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'La contraseña debe tener más de 8 caracteres.';
    end if;
END;$$
#----------------------disparador after update User------------------------------
delimiter $$
CREATE TRIGGER user_updated
AFTER UPDATE ON users
FOR EACH ROW											/*enviar msj*/
BEGIN
	SELECT CONCAT('Actualizado', concat(old.name, OLD.surname));
END;$$
#------------------------Disparador before delete user-------------------------------
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
#-----------------Disparador after delete user---------------------------------------
DELIMITER $$
CREATE TRIGGER User_deleted
after DELETE ON Users 														/*enviar msj*/
FOR EACH ROW
BEGIN
    SELECT CONCAT(OLD.name, concat(' ', OLD.surname));
END;$$
#--------------------------disparador  after insert user--------------------------------
DELIMITER $$
CREATE TRIGGER user_created
AFTER INSERT
ON Users FOR EACH ROW
BEGIN
    if new.type_user >3 then
    SELECT CONCAT(new.name, concat(' ', new.surname)); 				/*enviar msj*/
    SET MESSAGE_TEXT = 'Nuevo usuario creado';
    end if;
END;$$
#--------------------disparador before insert user----------------------
DELIMITER $$
CREATE TRIGGER validate_mail
before INSERT
ON Users FOR EACH ROW
BEGIN
    if new.type_user >3 then
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ERROR.';
      elseIF NEW.mail NOT LIKE '%@utez.edu.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El campo mail debe contener la dirección de correo de "@utez.edu.mx".';
	END IF;
END;$$
#___________________________________________________________________
CREATE TABLE exams (
    id_exam INT(254) NOT NULL,
    name_exam VARCHAR(254) NOT NULL,
    code VARCHAR(5) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fk_user INT(254) NOT NULL,
    PRIMARY KEY (id_exam),
    FOREIGN KEY (fk_user) REFERENCES Users (id_user)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
#-----------------------------vista de examenes--------------------------------
create view vista_exams as select exams.id_exam , exams.name_exam ,
exams.code;
from exams
group by users.type_user=2
order by  start_time asc;
select * from vista_exams;

#---------------------------INDICES EXAMS------------------------------------
create index idx_exams_code on exams (code);
/* indice compuesto*/
create index idx_exams_start_time_end_time on exams (start_time,end_time);

#------------------------disparador after insert exams-----------------------
delimiter $$
CREATE TRIGGER create_exam_trigger
AFTER INSERT ON exams
FOR EACH ROW
BEGIN
    DECLARE new_exam_id INT(254);            dudas			DUDAS
    SET new_exam_id = NEW.id_exam;

    INSERT INTO exams (id_exam, name_exam, code, start_time, fk_user)
    VALUES (new_exam_id, NEW.name_exam, NEW.code, NEW.start_time, NEW.fk_user);
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
#---------------------------disparador after update exams---------------------------
delimiter $$
CREATE TRIGGER update_exam_trigger
AFTER UPDATE ON exams
FOR EACH ROW
BEGIN
	if end_time < start_time then      						DUDA
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'tiempo mal';
    end if;
END;$$
#disparador before update exams____________________________________________________________________________________________________________________________________________
															DUDA
#disparador BEFORE delete exams__________________________________________________________________________________________________________________________________________
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
#disparador AFTER delete exams__________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER delete_exam
AFTER DELETE ON exams
FOR EACH ROW
BEGIN
    DELETE FROM exams WHERE id_exam = OLD.id_exam;
END;$$
#_____________________________________________

CREATE TABLE Students_exam (
  id_Student_exam INT NOT NULL auto_increment,
  score INT(3) NULL,
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
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
drop view vista_Students_exam;
/*----------------vista de estudiantes tienen examen--------------------*/
create view vista_Students_exam as select Students_exam.id_Student_exam , Users.type_user ,Users.name , Users.surname ,
Users.enrollment , Users.mail , exams.id_exam , exams.name_exam , Students_exam.score , 
Students_exam.start_date, Students_exam.end_date , exams.start_time , exams.end_time 
from Students_exam
join Users on Students_exam.fk_user = Users.id_user
join exams on Students_exam.fk_exam = exams.id_exam
group by exams.id_exam
order by users.name asc;
select * from vista_Students_exam;
#--------------------------INDICES STUDENTS_EXAM----------------------------
/* indice simple*/
create index idx_students_exam_id_Student_exam on Students_exam (id_Student_exam);
/* indice compuesto*/
create index idx_students_exam_start_date_end_date on Students_exam (start_date,end_date);
#--------------------------disparador after insert Students_exam------------------------
delimiter $$
CREATE TRIGGER trigger_inserted_student_exam
AFTER INSERT
ON Students_exam FOR EACH ROW							/*enviar msj*/
BEGIN
    SET MESSAGE_TEXT = 'calificacion insertada.';
END;$$
#------------------------disparador before insert Students_exam----------------------------
delimiter $$
CREATE TRIGGER trigger_inserted_student_exam
before INSERT
ON Students_exam FOR EACH ROW
BEGIN
    /*declare type_u int(1);
    select type_user into type_u from users where id_user=fk_user;
    if type_u!=3 then
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No es un estudiante.';
    end if;*/
    declare fecha_inicio timestamp;
    select start_time into fecha_inicio from exam where id_exam=fk_exam;
    if	fecha_inicio>new.start_date then
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No ha iniciado el examen.';
      end if;
END;$$
#--------------------disparador before update Students_exam-----------------------

#------------------disparador after update Students_exam----------------------
delimiter $$
CREATE TRIGGER updated_rating
before update
ON Students_exam FOR EACH ROW
BEGIN
	duda
END;$$
#-----------------------disparador before delete Students_exam--------------------
delimiter $$
CREATE TRIGGER validate_student
before delete
ON Students_exam FOR EACH ROW
BEGIN
	IF (SELECT * FROM Students_exam WHERE fk_user = 3) THEN
	DUDA
    elseif
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El ID del estudiante no existe.';
	end if;
END;$$
#-------------------disparador after delete Students_exam----------------------
delimiter $$
CREATE TRIGGER validate_student
after delete
ON Students_exam FOR EACH ROW					/*enviar msj*/
BEGIN
	SET MESSAGE_TEXT = 'Se elimino el estudiante';
	delete from students_exam where id_Student_exam;
END;$$
#______________________________________________________________________________

CREATE TABLE Questions (
  id_Question INT(5) NOT NULL,
  url_image VARCHAR(254) NOT NULL,
  type_question INT(1) NOT NULL,
  description VARCHAR(254) NOT NULL,
  points INT(2) NOT NULL,
  PRIMARY KEY (id_Question)
  );
  
/*vista de preguntas______________________________________________________________________________________________________________________________________________________*/
  create view vista_questions as select questions.id_question, questions.type_question ,
  questions.points, questions.description
  from questions
  join questions_answer on questions.id_Question = questions_answer.fk_question
  group by questions.type_question
  order by questions.points asc;
  
  select*from vista_questions;
#INDICES QUESTIONS_____________________________________________________________________________________________________________________________________________________
    /* indice simple*/
	create index idx_questions_url_image on questions (url_image);
	/* indice compuesto*/
	create index idx_questions_id_question_type_question_ on questions (id_Question,type_question);
#--------------disparador before insert questions----------------
delimiter $$
CREATE TRIGGER count_points_trigger
BEFORE INSERT ON questions
FOR EACH ROW
BEGIN
    DECLARE total_points INT;
    
    -- Calcular la suma de los puntos de todas las preguntas
    SELECT SUM(points) INTO total_points FROM questions;
    
    
    -- Verificar si la suma total excede los 100 puntos
    IF total_points > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La suma de puntos excede los 100';
    ELSEIF total_points = 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Puntos permitidos: 100';
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
#------------------disparador after update questions-------------------------
delimiter $$
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
        -- Mensaje de éxito
        SIGNAL SQLSTATE 'SUCCESS'							/*dice que esta mal el succes*/
            SET MESSAGE_TEXT = 'Los datos se han actualizado correctamente.';
    ELSE
        -- Mensaje de error
        SIGNAL SQLSTATE 'ERROR'
            SET MESSAGE_TEXT = 'Uno o más campos requeridos están incompletos.';
    END IF;
END;$$
#-----------------disparador before update questions---------------------
delimiter $$
CREATE TRIGGER validate_type_question_trigger
BEFORE UPDATE ON questions
FOR EACH ROW
BEGIN
    -- Verificar si el nuevo valor de type_question es igual al valor existente
    IF new.type_question = old.type_question THEN		/*manda error en el new y old we*/
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se permite actualizar con el mismo valor de type_question';
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
END;$$
#--------------------disparador after delete questions---------------------
DELIMITER $$
CREATE TRIGGER delete_id_question
AFTER DELETE ON questions
FOR EACH ROW
BEGIN
	IF ROW_COUNT() > 0 THEN
			-- Mensaje de éxito
			SELECT 'Los datos se eliminaron correctamente' AS Message;
		ELSE																	/*marca que: no se permite devolver un conjunto de resultados de un disparador*/
			-- Mensaje de error
			SELECT 'Error al eliminar los datos de la tabla Questions' AS Message;
	END IF;
END;$$
#_________________________________________________________________________________________________________________________________________________________________________

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

/*----------------vista preguntas respuesta-----------------------------------*/
create view vista_questions_answer as 
select questions_answer.id_Question_answer , students_exam_answer.fk_student_exam,
questions.type_question, questions.description, questions.points,
students_exam_answer.answer, questions_answer.answer, questions_answer.if_answer from questions_answer
join students_exam_answer on questions_answer.id_Question_answer = students_exam_answer.fk_answer
join questions on questions_answer.fk_question= questions.id_Question
group by questions.type_question
order by questions.points asc;

select * from vista_questions_answer;
#------------------INDICES QUESTIONS_ANSWER-------------------------
/* indice simple*/
create index idx_questions_answer_id_Question_answer on Questions_answer (id_Question_answer);
/* indice compuesto */
create index idx_questions_answer_answer_if_answer on Questions_answer (answer,if_answer);
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
drop trigger tr_check_if_answer;
DELIMITER $$
-- Crear el trigger
CREATE TRIGGER tr_check_if_answer
AFTER INSERT ON questions_answer
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);

    -- Validar el valor de if_answer
    IF new.if_answer <> 'verdadero' AND new.if_answer <> 'falso' THEN			/*creo en los news manda error*/
        -- Generar mensaje de error
        SET error_message = 'El valor de if_answer debe ser "verdadero" o "falso".';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END;$$
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
        SIGNAL SQLSTATE 'SUCCESS'							/*que esta mal el success*/
            SET MESSAGE_TEXT = 'Los datos se han actualizado correctamente.';
    ELSE
        -- Mensaje de error
        SIGNAL SQLSTATE 'ERROR'
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
delimiter $$
CREATE TRIGGER after_delete_trigger
AFTER DELETE ON Questions_answer
FOR EACH ROW
BEGIN
    IF ROW_COUNT() > 0 THEN
        -- Mensaje de éxito
        SELECT 'Los datos se eliminaron correctamente' AS Message;  /*que no se permite devolver un conjunto de resultados de un disparador*/
    ELSE
        -- Mensaje de error
        SELECT 'Error al eliminar los datos de la tabla Questions' AS Message;
    END IF;
END;$$
#_________________________________________________________________________________________________________________________________________________________________________

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
    
    /*vista estudiantes con sus respuestas*/
    create view vista_students_exam_answer as 
    select students_exam.id_student_exam , students_exam_answer.fk_question, 
    questions.type_question , questions.points , questions.description,
    students_exam_answer.answer from students_exam_answer 
    join students_exam on students_exam_answer.fk_student_exam = students_exam.id_Student_exam
    join questions on students_exam_answer.fk_question = questions.id_Question
    group by questions.type_question
    order by questions.points asc;
    
    select * from vista_students_exam_answer;
#--------------INDICES STUDENTS_EXAM_ANSWER-------------------
        /* indice simple*/
create index idx_Student_exam_answer_id_Student_exam_answer on Students_exam_answer (id_Student_exam_answer);
    /* indice compuesto */
create index idx_Student_exam_answer_fk_question_fk_answer on Students_exam_answer (fk_question,fk_answer);
#---------------disparador before insert Students_exam_answer------------------------

#---------------disparador after insert Students_exam_answer-------------------------

#----------------disparador before update Students_exam_answer-----------------------

#----------------disparador after update Students_exam_answer------------------------

#----------------disparador before delete Students_exam_answer-----------------------

#-----------------disparador after delete Students_exam_answer-----------------------

#_________________________________________________________________________________________________________________________________________________________________________    
CREATE TABLE Exam_questions (
  id_Exam_questions INT NOT NULL,
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

/*vista de examne preguntas*/
create view vista_exam_questions as select exams.id_exam, exams.name_exam,
questions.id_Question, questions.type_question,
questions.points, questions.description from exam_questions
join exams on exam_questions.fk_exam=exams.id_exam
join questions on exam_questions.fk_question=questions.id_Question
group by questions.type_question
order by questions.points asc;

select * from vista_exam_questions;
#INDICES EXAM_QUESTIONS______________________________________________________________________________________________________________________________________________________
 /* indice simple*/
 create index idx_exam_questions_id_Exam_questions on Exam_questions (id_Exam_questions);
 /* indice compuesto */
create index idx_Exam_questions_fk_exam_fk_question on Exam_questions (fk_exam,fk_question);
#disparador after insert questions Exam_questions______________________________________________________________________________________________________________________

#disparador before insert questions Exam_questions______________________________________________________________________________________________________________________

#disparador after update questions Exam_questions______________________________________________________________________________________________________________________

#disparador before update questions Exam_questions______________________________________________________________________________________________________________________

#disparador before delete questions Exam_questions_____________________________________________________________________________________________________________________

#disparador after delete questions Exam_questions_______________________________________________________________________________________________________________________
