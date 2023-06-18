create database UCQ_prueba;
use UCQ_prueba;
 alter table Users change statuts status varchar(7) not null;
 select * from Users;
 #----------------------------------------------------------------
create table Users(
	id_user int(254) not null auto_increment,
	name varchar(254) not null,
    surname varchar(254) not null,
    curp varchar (18),
    status varchar(7),
    type_user int(1) not null,
    mail varchar(254),
    enrollment varchar (10),
    password varchar(254),
    primary key (id_user),
    primary key (type_user)
);

insert into users values (3,'Emilio','alpizar','AIGE041218HMSLRMA3','activo', 3,'20223tn.edu@utez.edu.mx' );
/*vistas de users________________________________________________________________________________________________________________________________________________*/
create view vista_user as select id_user as id, name as nombre, surname as apellido, curp ,
status as estatus, type_user as tipo_usuario, mail as gmail, enrollment as matricula from users
group by type_user =1 and type_user = 2 and type_user = 3
order by type_user asc;
select * from vista_user;
#________________________________________________________________________________________________________________________________________________________________________
#INDICES________________________________________________________________________________________________________________________________________________________________
create unique index idx_users_type_user on Users(type_user);
/* indice simple*/
create index idx_users_enrollment on Users (enrollment);
/* indice compuesto*/
create index idx_users_name_surname on Users (name,surname);
#________________________________________________________________________________________________________________________________________________________________________
#disparador before update________________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER update_status_trigger
before UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.type_user = 1 THEN -- Admin
        IF NEW.status = 'activo' THEN
SET NEW.status = 'activo';
            -- Actualizar el status del usuario admin activo
        ELSE
SET NEW.status = 'inactivo';
            -- Actualizar el status del usuario admin inactivo
        END IF;
    ELSEIF NEW.type_user = 2 THEN -- Docente
        IF NEW.status = 'activo' THEN
SET NEW.status = 'activo';
            -- Actualizar el status del usuario docente activo
        ELSE
SET NEW.status = 'inactivo';
            -- Actualizar el status del usuario docente inactivo
        END IF;
    ELSEIF NEW.type_user = 3 THEN -- Alumno
        IF NEW.status = 'activo' THEN
SET NEW.status = 'activo';
            -- Actualizar el status del usuario alumno activo
        ELSE
SET NEW.status = 'inactivo';
            -- Actualizar el status del usuario alumno inactivo
        END IF;
    END IF;
END;$$
#_____________________________________________________________________________________________________________________________________________________________________
#disparador after update________________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER update_status_trigger
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.type_user = 3 THEN
        SET NEW.status = 'activo';
    ELSE
        SET NEW.status = 'inactivo';
    END IF;
END;
$$
#________________________________________________________________________________________________________________________________________________________________________
#Disparador before delete________________________________________________________________________________________________________________________________________________
DELIMITER $$
CREATE TRIGGER deleted_user
BEFORE DELETE ON Users 
FOR EACH ROW
BEGIN
    if new.type_user <3 then
    SELECT CONCAT('Eliminando usuario: ', OLD.name, ' ', OLD.surname) AS 'Mensaje';
    else
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Usuario no existe.';
    end if;
END; $$
#_______________________________________________________________________________________________________________________________________________________________________
#Disparador after delete________________________________________________________________________________________________________________________________________________
DELIMITER $$
CREATE TRIGGER deleted_user
after DELETE ON Users 
FOR EACH ROW
BEGIN
    SELECT CONCAT('Se elimino el usuario: ', OLD.name, ' ', OLD.surname) AS 'Mensaje';
END; $$
#-________________________________________________________________________________________________________________________________________________________________________
#disparador  after insert________________________________________________________________________________________________________________________________________________
DELIMITER $$
CREATE TRIGGER trigger_inserted_user
AFTER INSERT
ON Users FOR EACH ROW
BEGIN
    if new.type_user >3 then
    SELECT CONCAT('Nuevo usuario creado: ', NEW.name, ' ', NEW.surname) AS 'Mensaje';
    else
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ERROR.';
    end if;
END; $$
#________________________________________________________________________________________________________________________________________________________________________
#disparador before insert________________________________________________________________________________________________________________________________________________
DELIMITER $$
CREATE TRIGGER trigger_inserted_user
before INSERT
ON Users FOR EACH ROW
BEGIN
    if new.type_user >3 then
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ERROR.';
    end if;
END; $$
#____________________________________________________________________________________________________________________________________________________________________________

CREATE TABLE exams (
    id_exam INT(254) NOT NULL,
    name_exam VARCHAR(254) NOT NULL,
    code VARCHAR(5) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fk_user INT(254) NOT NULL,
    PRIMARY KEY (id_exam),
    FOREIGN KEY (fk_user) REFERENCES Users (type_user)
);

/*vista de examenes________________________________________________________________________________________________________________________________________________*/
create view vista_exams as select exams.id_exam as id_examen, exams.name_exam as nombre_examen,
exams.code as codigo, users.name as nombre_profesor, users.surname as apellido, users.mail as gmail 
from exams
join users on exams.fk_user = users.id_user
group by users.type_user=2
order by users.name asc;
select * from vista_exams;
#______________________________________________________________________________________________________________________________________________________________________
#INDICES EXAMS__________________________________________________________________________________________________________________________________________________________
create index idx_exams_code on exams (code);
/* indice compuesto*/
create index idx_exams_start_time_end_time on exams (start_time,end_time);
#________________________________________________________________________________________________________________________________________________________________________
#disparador after insert exams__________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER create_exam_trigger
AFTER INSERT ON exams
FOR EACH ROW
BEGIN
    DECLARE new_exam_id INT(254);
    SET new_exam_id = NEW.id_exam;

    INSERT INTO exams (id_exam, name_exam, code, start_time, fk_user)
    VALUES (new_exam_id, NEW.name_exam, NEW.code, NEW.start_time, NEW.fk_user);
END;$$
#________________________________________________________________________________________________________________________________________________________________________
#disparador before insert exams___________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER create_exam_trigger
BEFORE INSERT ON exams
FOR EACH ROW
BEGIN
    if old.name_exam = new.name_exam then
	  SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Examen existente';
    end if;
END;$$
#________________________________________________________________________________________________________________________________________________________________________
#disparador after update exams__________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER update_exam_trigger
AFTER UPDATE ON exams
FOR EACH ROW
BEGIN
    UPDATE exams
    SET name_exam = NEW.name_exam,
        code = NEW.code,
        start_time = NEW.start_time,
        fk_user = NEW.fk_user
    WHERE id_exam = NEW.id_exam;
END;$$
#________________________________________________________________________________________________________________________________________________________________________
#disparador before update exams____________________________________________________________________________________________________________________________________________

#________________________________________________________________________________________________________________________________________________________________________
#disparador AFTER delete exams__________________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER delete_exam_trigger
AFTER DELETE ON exams
FOR EACH ROW
BEGIN
    DELETE FROM exams WHERE id_exam = OLD.id_exam;
END;$$
#________________________________________________________________________________________________________________________________________________________________________
#disparadorv BEFORE delete exams__________________________________________________________________________________________________________________________________________

#__________________________________________________________________________________________________________________________________________________________________________
CREATE TABLE Students_exam (
  id_Student_exam INT NOT NULL,
  score INT(3) NULL,
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  fk_user INT(1) NOT NULL,
  fk_exam INT(254) NOT NULL,
  PRIMARY KEY (id_Student_exam),
    FOREIGN KEY (fk_user)
    REFERENCES Users (type_User),
    FOREIGN KEY (fk_exam)
	REFERENCES Exams (id_Exam)
);
drop view vista_Students_exam;
/*vista de estudiantes tienen examen*/
create view vista_Students_exam as select Students_exam.id_Student_exam as id_estudiante, Users.type_user as tipo_usuario ,Users.name as nombre, Users.surname as apellido,
Users.enrollment as matricula, Users.mail as gmail, exams.id_exam as id_examen, exams.name_exam as nombre_examen, Students_exam.score as calificacion, 
Students_exam.start_date as fecha_inicio, Students_exam.end_date as fecha_final, exams.start_time as tiempo_inicio, exams.end_time as tiempo_final 
from Students_exam
join Users on Students_exam.fk_user = Users.id_user
join exams on Students_exam.fk_exam = exams.id_exam
group by exams.id_exam
order by users.name asc;
select * from vista_Students_exam;
#_____________________________________________________________________________________________________________________________________________________________________________
#INDICES STUDENTS_EXAM________________________________________________________________________________________________________________________________________________________
/* indice simple*/
create index idx_students_exam_id_Student_exam on Students_exam (id_Student_exam);
/* indice compuesto*/
create index idx_students_exam_start_date_end_date on Students_exam (start_date,end_date);
#________________________________________________________________________________________________________________________________________________________________________
#disparador after insert Students_exam___________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER trigger_inserted_student_exam
AFTER INSERT
ON Students_exam FOR EACH ROW
BEGIN
    SET MESSAGE_TEXT = 'Calificacion insertada.';
END;$$
#_________________________________________________________________________________________________________________________________________________________________________
#disparador before insert Students_exam___________________________________________________________________________________________________________________________________
delimiter $$
CREATE TRIGGER trigger_inserted_student_exam
before INSERT
ON Students_exam FOR EACH ROW
BEGIN
    if fk_user<3 then
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No es un estudiante.';
    end if;
END;$$
#_________________________________________________________________________________________________________________________________________________________________________
#disparador after update Students_exam__________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before update Students_exam____________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before delete Students_exam__________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after delete Students_exam__________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________

CREATE TABLE Questions (
  id_Question INT(5) NOT NULL,
  url_image VARCHAR(254) NOT NULL,
  type_question INT(1) NOT NULL,
  description VARCHAR(254) NOT NULL,
  points INT(2) NOT NULL,
  PRIMARY KEY (id_Question)
  );
  
  /*vista de preguntas______________________________________________________________________________________________________________________________________________________*/
  create view vista_questions as select questions.id_question as id_pregunta, questions.type_question as tipo_pregunta,
  questions.points as puntaje, questions.description as descripcion, questions_answer.answer as respuestas, 
  questions_answer.if_answer as v_f
  from questions
  join questions_answer on questions.id_Question = questions_answer.fk_question
  group by questions.type_question
  order by questions.points asc;
  
  select*from vista_questions;
  #_________________________________________________________________________________________________________________________________________________________________________
  #INDICES QUESTIONS_____________________________________________________________________________________________________________________________________________________
    /* indice simple*/
	create index idx_questions_url_image on questions (url_image);
	/* indice compuesto*/
	create index idx_questions_id_question_type_question_ on questions (id_Question,type_question);
#_________________________________________________________________________________________________________________________________________________________________________
#disparador after insert questions_______________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before insert questions_______________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after update questions______________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before update questions________________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before delete questions______________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after delete questions______________________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________

  CREATE TABLE Questions_answer (
  id_Question_answer INT NOT NULL,
  answer VARCHAR(254) NOT NULL,
  if_answer TINYINT NOT NULL,
  fk_question INT(5) NOT NULL,
  PRIMARY KEY (id_Question_answer),
    FOREIGN KEY (fk_question)
    REFERENCES Questions (id_Question)
);

/*----------------vista preguntas respuesta--------------------------------------------------------------------------*/
create view vista_questions_answer as select questions_answer.id_Question_answer as id_pregunta_respuesta,  students_exam_answer.fk_student_exam as id_estudiante,
questions.type_question as tipo_pregunta, questions.description as descripcion, questions.points as puntos_pregunta ,
students_exam_answer.answer as respuesta_estudiante, questions_answer.answer as respuesta_correcta, questions_answer.if_answer as correcta from questions_answer
join students_exam_answer on questions_answer.id_Question_answer = students_exam_answer.fk_answer
join questions on questions_answer.fk_question= questions.id_Question
group by questions.type_question
order by questions.points asc;

select * from vista_questions_answer;
#_________________________________________________________________________________________________________________________________________________________________________
#INDICES QUESTIONS_ANSWER_________________________________________________________________________________________________________________________________________________
/* indice simple*/
create index idx_questions_answer_id_Question_answer on Questions_answer (id_Question_answer);
/* indice compuesto */
create index idx_questions_answer_answer_if_answer on Questions_answer (answer,if_answer);
#_________________________________________________________________________________________________________________________________________________________________________
#disparador after insert questions Questions_answer______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before insert questions Questions_answer_______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after update questions Questions_answer____________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before update questions Questions_answer________________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before delete questions Questions_answer_____________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after delete questions Questions_answer____________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________

CREATE TABLE Students_exam_answer (
  id_Student_exam_answer INT NOT NULL,
  fk_student_exam INT NOT NULL,
  answer VARCHAR(254) NOT NULL,
  fk_answer INT(5) NOT NULL,
  fk_question INT(5) NOT NULL,
  PRIMARY KEY (id_Student_exam_answer),
    FOREIGN KEY (fk_student_exam)
    REFERENCES Students_exam (id_Student_exam),
    FOREIGN KEY (fk_question)
    REFERENCES Questions (id_Question),
    FOREIGN KEY (fk_answer)
    REFERENCES Questions_answer (id_Question_answer)
    );
    
    /*vista estudiantes con sus respuestas*/
    create view vista_students_exam_answer as select students_exam.id_student_exam as id_alumno, students_exam_answer.fk_question as id_pregunta, 
    questions.type_question as tipo_pregunta, questions.points as puntos_pregunta, questions.description as descripcion,
    students_exam_answer.answer as respuesta_alumno from students_exam_answer 
    join students_exam on students_exam_answer.fk_student_exam = students_exam.id_Student_exam
    join questions on students_exam_answer.fk_question = questions.id_Question
    group by questions.type_question
    order by questions.points asc;
    
    select * from vista_students_exam_answer;
    #_________________________________________________________________________________________________________________________________________________________________________
    #INDICES STUDENTS_EXAM_ANSWER_____________________________________________________________________________________________________________________________________________
        /* indice simple*/
create index idx_Student_exam_answer_id_Student_exam_answer on Students_exam_answer (id_Student_exam_answer);
    /* indice compuesto */
create index idx_Student_exam_answer_fk_question_fk_answer on Students_exam_answer (fk_question,fk_answer);
#____________________________________________________________________________________________________________________________________________________________________________
#_________________________________________________________________________________________________________________________________________________________________________
#disparador after insert questions Students_exam_answer______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before insert questions Students_exam_answer______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after update questions Students_exam_answer______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before update questions Students_exam_answer______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before delete questions Students_exam_answer_____________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after delete questions Students_exam_answer_______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
    
CREATE TABLE Exam_questions (
  id_Exam_questions INT NOT NULL,
  fk_question INT(5) NOT NULL,
  fk_exam INT(254) NOT NULL,
  PRIMARY KEY (id_Exam_questions),
    FOREIGN KEY (fk_exam)
    REFERENCES Exams (id_Exam),
    FOREIGN KEY (fk_question)
    REFERENCES Questions (id_Question)
);

/*vista de examne preguntas*/
create view vista_exam_questions as select exams.id_exam as id_examen, exams.name_exam as nombre_examen,
questions.id_Question as id_pregunta, questions.type_question as tipo_pregunta,
questions.points as puntos_pregunta, questions.description as descripcion from exam_questions
join exams on exam_questions.fk_exam=exams.id_exam
join questions on exam_questions.fk_question=questions.id_Question
group by questions.type_question
order by questions.points asc;

select * from vista_exam_questions;
#_______________________________________________________________________________________________________________________________________________________________________
#INDICES EXAM_QUESTIONS______________________________________________________________________________________________________________________________________________________
 /* indice simple*/
 create index idx_exam_questions_id_Exam_questions on Exam_questions (id_Exam_questions);
 /* indice compuesto */
create index idx_Exam_questions_fk_exam_fk_question on Exam_questions (fk_exam,fk_question);
#_________________________________________________________________________________________________________________________________________________________________________
#disparador after insert questions Exam_questions______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before insert questions Exam_questions______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after update questions Exam_questions______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before update questions Exam_questions______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador before delete questions Exam_questions_____________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________
#disparador after delete questions Exam_questions_______________________________________________________________________________________________________________________

#_________________________________________________________________________________________________________________________________________________________________________