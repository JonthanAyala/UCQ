/*
INSERT INTO `ucq_chido`.`users` (`id_user`, `name`, `lastname`, `surname`, `curp`, `status`, `type_user`, `mail`, `enrollment`, `password`) VALUES ('1', 'admin', 'utez', 'NA', 'NA', 'Activo', '1', 'admin@utez.edu.mx', 'N/A', 'adminucq');
INSERT INTO `ucq_chido`.`users` (`id_user`, `name`, `lastname`, `surname`, `curp`, `status`, `type_user`, `mail`, `enrollment`, `password`) VALUES ('2', 'Hugo', 'NA', 'NA', 'NA', 'Activo', '2', 'hugo@utez.edu.mx', 'NA', 'hugoucq');
INSERT INTO `ucq_chido`.`users` (`id_user`, `name`, `lastname`, `surname`, `curp`, `status`, `type_user`, `mail`, `enrollment`, `password`) VALUES ('3', 'Isai', 'acosta', 'guerra', 'iii', 'Activo', '3', 'isai@utez.edu.mx', '20213tn094', 'isaiucq');

*/

create database ucq_chido;
use ucq_chido;

CREATE TABLE Users (
    id_user INT auto_increment,
    name VARCHAR(254) NOT NULL,
    lastname VARCHAR(254) NOT NULL,
    surname VARCHAR(254) NOT NULL,
    curp VARCHAR(18) NOT NULL,
    status VARCHAR(7) NOT NULL,
    type_user INT NOT NULL,
    mail VARCHAR(254),
    enrollment VARCHAR(10),
    password VARCHAR(254),
    PRIMARY KEY (id_user)
);

CREATE TABLE Exams (
    id_exam INT NOT NULL AUTO_INCREMENT,
    name_exam VARCHAR(254) NOT NULL,
    code VARCHAR(5) NOT NULL UNIQUE,
    start_time DATETIME NULL,
    end_time DATETIME NULL,
    fk_user INT NULL,
    PRIMARY KEY (id_exam),
    FOREIGN KEY (fk_user) REFERENCES Users (id_user)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
/*Hay que ver los not null*/
CREATE TABLE Students_exam (
    id_Student_exam INT NOT NULL AUTO_INCREMENT,
    score INT NULL,
    start_date DATETIME NULL,
    end_date DATETIME NULL,
    fk_user INT NULL,
    fk_exam INT NULL,
    PRIMARY KEY (id_Student_exam),
    FOREIGN KEY (fk_user) REFERENCES Users (id_user),
    FOREIGN KEY (fk_exam) REFERENCES Exams (id_exam)
);

CREATE TABLE Questions (
    id_Question INT NOT NULL AUTO_INCREMENT,
    url_image VARCHAR(254),
    type_question INT,
    description VARCHAR(254),
    points INT null,
    fk_exam INT null,
    PRIMARY KEY (id_Question),
    FOREIGN KEY (fk_exam) REFERENCES Exams (id_exam)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Questions_answer (
    id_Question_answer INT NOT NULL AUTO_INCREMENT,
    answer VARCHAR (254) null,
    if_answer TINYINT null,
    fk_question INT null,
    PRIMARY KEY (id_Question_answer),
    FOREIGN KEY (fk_question) REFERENCES Questions (id_Question)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
/*Hay que ver los not null*/
CREATE TABLE Students_exam_answer (
    id_Student_exam_answer INT NOT NULL AUTO_INCREMENT,
    fk_student_exam INT NULL,
    answer VARCHAR(254) NULL,
    fk_answer INT NULL,
    fk_question INT NULL,
    PRIMARY KEY (id_Student_exam_answer),
    FOREIGN KEY (fk_student_exam) REFERENCES Students_exam (id_Student_exam)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (fk_question) REFERENCES Questions (id_Question)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (fk_answer) REFERENCES Questions_answer (id_Question_answer)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

create view view_user as 
select * from Users
group by type_user, enrollment 
order by type_user asc, enrollment asc;

create view view_exams as 
select * from exams
group by id_exam
order by  start_time asc;

create view view_Students_exam as select Students_exam.id_Student_exam , Users.type_user ,Users.name , Users.lastname, 
Users.surname, Users.enrollment , Users.mail , exams.id_exam , exams.name_exam , Students_exam.score , 
Students_exam.start_date, Students_exam.end_date , exams.start_time , exams.end_time 
from Students_exam
join Users on Students_exam.fk_user = Users.id_user
join exams on Students_exam.fk_exam = exams.id_exam
group by exams.id_exam
order by users.name asc;

CREATE VIEW view_questions_answer AS
SELECT questions_answer.id_Question_answer,students_exam_answer.fk_student_exam,
  questions.type_question, questions.description, questions.points, 
  questions_answer.answer,questions_answer.if_answer
FROM questions_answer
  JOIN students_exam_answer ON questions_answer.id_Question_answer = students_exam_answer.fk_answer
  JOIN questions ON questions_answer.fk_question = questions.id_Question
GROUP BY questions.type_question
ORDER BY questions.points ASC;

create view view_students_exam_answer as 
select students_exam.id_student_exam , students_exam_answer.fk_question, 
questions.type_question , questions.points , questions.description,
students_exam_answer.answer from students_exam_answer 
join students_exam on students_exam_answer.fk_student_exam = students_exam.id_Student_exam
join questions on students_exam_answer.fk_question = questions.id_Question
group by questions.type_question
order by questions.points asc;

CREATE VIEW ExamDetails AS
SELECT se.id_Student_exam, se.start_date, se.end_date, e.name_exam, u.name AS professor_name, se.fk_user as id_s
FROM Students_exam se
INNER JOIN exams e ON se.fk_exam = e.id_exam
INNER JOIN Users u ON e.fk_user = u.id_user;

create unique index idx_users_mail on Users(mail);

create index idx_users_name_type_user on Users (type_user);

create index idx_users_name_surname on Users (name,surname);

create index idx_exams_code on exams (code);

create index idx_exams_start_time_end_time on exams (start_time,end_time);

create index idx_students_exam_id_Student_exam on Students_exam (id_Student_exam);

create index idx_students_exam_start_date_end_date on Students_exam (start_date,end_date);

create index idx_questions_url_image on questions (url_image);

create index idx_questions_id_question_type_question_ on questions (id_Question,type_question);
    
create index idx_questions_answer_id_Question_answer on Questions_answer (id_Question_answer);

create index idx_questions_answer_answer_if_answer on Questions_answer (answer,if_answer);

create index idx_Student_exam_answer_id_Student_exam_answer on Students_exam_answer (id_Student_exam_answer);

create index idx_Student_exam_answer_fk_question_fk_answer on Students_exam_answer (fk_question,fk_answer);

delimiter $$
CREATE TRIGGER update_password
before UPDATE ON users
FOR EACH ROW
BEGIN													
    if length(new.password) < 4 then
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'La contraseña debe tener más de 4 caracteres.';
    end if;
END;$$

delimiter $$
CREATE TRIGGER user_Status
before UPDATE ON users
FOR EACH ROW											
BEGIN
	IF NEW.status <> 'ACTIVO' or new.status <> 'Activo' THEN		
        SET NEW.status = 'INACTIVO';
    END IF;
END; $$

DELIMITER $$
CREATE TRIGGER validate_user_exists
BEFORE DELETE ON Users
FOR EACH ROW
BEGIN
    DECLARE type_u INT;
    SELECT type_user INTO type_u FROM users WHERE id_user = old.id_user;                
    IF type_u > 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuario no existe';
    END IF;
END;$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER User_deleted_stu
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    DECLARE type_u INT;
    SELECT type_user INTO type_u FROM users WHERE id_user = old.id_user;            
    IF type_u = 3 THEN
        DELETE FROM students_exam WHERE fk_user = old.id_user;
    END IF;
END;$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER validate_mail
before INSERT
ON Users FOR EACH ROW
BEGIN
    if new.type_user>3 then												
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'ERROR en el tipo de usuario.';
      elseIF NEW.mail NOT LIKE '%@utez.edu.mx' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El campo mail debe contener la dirección de correo de "@utez.edu.mx".';
	END IF;
END;$$

DELIMITER $$
CREATE TRIGGER user_created
AFTER INSERT
ON Users FOR EACH ROW
BEGIN
	DECLARE diferent_name VARCHAR(100);
    DECLARE diferent_lastname VARCHAR(100);				 
    DECLARE diferent_surname VARCHAR(100);
		SET diferent_name = NEW.name;
        set diferent_lastname = new.lastname;
        set diferent_surname = new.surname;
	IF ( diferent_name REGEXP '[^a-zA-Z0-9 ]') or (diferent_lastname REGEXP '[^a-zA-Z0-9 ]') 
    or (diferent_surname REGEXP '[^a-zA-Z0-9 ]') THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se detectaron caracteres especiales';
END IF; 
 END$$

delimiter $$
CREATE TRIGGER validate_code
BEFORE INSERT ON exams
FOR EACH ROW
BEGIN
	IF length(new.code ) < 5 OR length(new.code) > 5 THEN
		SIGNAL SQLSTATE '45000'										
		SET MESSAGE_TEXT = 'El código debe ser de 8 digitos.';
	END IF;
END;$$

delimiter $$
CREATE TRIGGER insert_inter
AFTER INSERT ON exams
FOR EACH ROW
BEGIN
DECLARE exams_count INT;
    SELECT COUNT(*) INTO exams_count                                               
    FROM exams
    WHERE id_exam = NEW.id_exam;
    IF exams_count > 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El registro del examen fracasó.';
    END IF;
END;$$

DELIMITER $$
CREATE TRIGGER validate_id_exam
BEFORE DELETE ON exams
FOR EACH ROW
BEGIN
    DECLARE exam_count INT;
    SELECT COUNT(*) INTO exam_count FROM exams WHERE id_exam = OLD.id_exam;
    IF exam_count > 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El ID del examen no existe.';
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER validate_student
BEFORE INSERT
ON Students_exam FOR EACH ROW
BEGIN
    DECLARE type_u INT;
    SELECT type_user INTO type_u FROM users WHERE id_user = NEW.fk_user;            
    IF type_u != 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es un estudiante.';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER trigger_inserted_student_exam
AFTER INSERT
ON Students_exam FOR EACH ROW
BEGIN
    DECLARE type_u INT;
    SELECT type_user INTO type_u FROM users WHERE id_user = NEW.fk_user;
    IF type_u != 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No es un estudiante el tipo de usuario.';
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER validated_time_exam
before delete
ON Students_exam FOR EACH ROW
BEGIN
	IF old.end_date = '0000-00-00 00:00:00' THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'el estudiante aun tiene un examen en progreso';
    END IF;
END;$$

DELIMITER $$
CREATE TRIGGER delete_students_exam 
AFTER DELETE ON Students_exam 
FOR EACH ROW
BEGIN
    DELETE sea
    FROM Students_exam_answer sea
    WHERE sea.fk_student_exam = old.id_Student_exam;
END $$

DELIMITER $$
CREATE TRIGGER calification_exam
before UPDATE ON Students_exam											
FOR EACH ROW
BEGIN
  SET NEW.end_date = NOW();
END $$

delimiter $$
CREATE TRIGGER count_points
BEFORE INSERT ON questions
FOR EACH ROW
BEGIN
	DECLARE total_points INT;
	SELECT SUM(points) INTO total_points FROM questions;
	IF total_points > 10 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La suma de puntos excede los 10';
	END IF;
END;$$

delimiter $$
CREATE TRIGGER validate_type_question_trigger
AFTER INSERT ON questions
FOR EACH ROW
BEGIN
    IF NEW.type_question <> 1 AND NEW.type_question <> 2 THEN						
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El valor del atributo type_question no es válido.';
    END IF;
END;$$

DELIMITER $$
CREATE TRIGGER after_update_questions
AFTER UPDATE ON Questions
FOR EACH ROW
BEGIN
IF NEW.id_Question <> OLD.id_Question THEN
        UPDATE Questions_answer SET fk_question = NEW.id_Question WHERE fk_question = OLD.id_Question;		
        UPDATE Students_exam_answer SET fk_question = NEW.id_Question WHERE fk_question = OLD.id_Question;
    END IF;
END;$$

DELIMITER $$
CREATE TRIGGER before_insert_answer
BEFORE INSERT ON students_exam_answer
FOR EACH ROW
BEGIN
 DECLARE answer_name VARCHAR(254);
 SET answer_name = NEW.answer;
 IF (answer_name REGEXP '[^a-zA-Z0-9 ]') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Se detectaron caracteres especiales en la respuesta';			
 END IF;
END;$$

DELIMITER $$
CREATE TRIGGER trigger_after_delete_students_exam_answer
AFTER DELETE ON students_exam
FOR EACH ROW
BEGIN														
	DELETE FROM students_exam_answer WHERE fk_student_exam = OLD.id_Student_exam;		
END;$$

DELIMITER $$
CREATE TRIGGER before_delete_students_exam_answer
BEFORE DELETE ON Students_exam_answer
FOR EACH ROW
BEGIN														
    IF OLD.fk_student_exam >0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se pudo eliminar.';
    END IF;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE crear_usuarios(
    name_in VARCHAR(254),
    lastname_in VARCHAR(254),
    surname_in VARCHAR(254),
    curp_in VARCHAR(18),
    status_in VARCHAR(7),
    type_user_in INT,
    mail_in VARCHAR(254),
    enrollment_in VARCHAR(10),
    password_in VARCHAR(254)
)
BEGIN
    DECLARE conteo INT;
    SET autocommit = 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO conteo FROM users WHERE mail = mail_in OR enrollment = enrollment_in OR curp = curp_in;
    IF conteo = 0 THEN
        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al intentar registrar el usuario en la base de datos';
                ROLLBACK;
            END;
            INSERT INTO users(name, lastname, surname, curp, status, type_user, mail, enrollment, password)
            VALUES (name_in, lastname_in, surname_in, curp_in, status_in, type_user_in, mail_in, enrollment_in, password_in);
            COMMIT;
        END;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario que se intenta registrar YA existe en la base de datos';
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;

   
DELIMITER $$
CREATE PROCEDURE actualizar_usuario(
    id_user_new INT,
    name_new VARCHAR(254),
    lastname_new VARCHAR(254),
    surname_new VARCHAR(254),
    curp_new VARCHAR(18),
    status_new VARCHAR(7),
    type_user_new INT,
    mail_new VARCHAR(254),
    enrollment_new VARCHAR(10),
    password_new VARCHAR(254)
)
BEGIN
    DECLARE usuario_existente INT;
    SET autocommit = 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO usuario_existente FROM users WHERE id_user = id_user_new FOR UPDATE;
    IF usuario_existente > 0 THEN
        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al intentar actualizar el usuario en la base de datos';
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario que intenta actualizar NO existe';
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;


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

 DELIMITER $$
CREATE PROCEDURE crear_examenes(
	id_exam_in int,
    name_exam_in VARCHAR(254),
    code_in VARCHAR(5),
    fk_user_in int
)
BEGIN
    DECLARE conteo INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO conteo FROM exams WHERE id_exam = id_exam_in;
    IF conteo = 0 THEN
    BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al intentar registrar el examen en la base de datos';
                ROLLBACK;
            END;
        INSERT INTO exams(id_exam,name_exam, code,fk_user) VALUES 
        (id_exam_in,name_exam_in, code_in,fk_user_in);
        COMMIT;
        END;
    ELSE
        SELECT 'El examen que intenta registrar YA existe en la base de datos';
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE actualizar_examen(
    id_exam_new INT,
    name_exam_new VARCHAR(254),
    code_new VARCHAR(5)
    )
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
        SET name_exam = name_exam_new,code = code_new
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

DELIMITER $$
CREATE PROCEDURE crear_preguntas(
	id_Question_in int,
    type_question_in VARCHAR(254),
    fk_exam_in int
)
BEGIN
    DECLARE conteo INT DEFAULT 0;
    SET autocommit = 0;
    START TRANSACTION;
    SELECT COUNT(*) INTO conteo FROM questions WHERE id_Question = id_Question_in;
    IF conteo = 0 THEN
    BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SELECT 'Error al intentar registrar el examen en la base de datos';
                ROLLBACK;
            END;
        INSERT INTO questions(id_Question,type_question,fk_exam) VALUES 
        (id_Question_in,type_question_in, fk_exam_in);
        COMMIT;
        END;
    ELSE
        SELECT 'La pregunta tiene parametros incorrectos, intente de nuevo';
        ROLLBACK;
    END IF;
    SET autocommit = 1;
END$$
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateQuestionDescription(
    IN p_id INT,
    IN p_description VARCHAR(254)
)
BEGIN
    UPDATE Questions
    SET description = p_description
    WHERE id_Question = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsertQuestionAnswer(
    IN p_answer VARCHAR(254),
    IN p_if_answer TINYINT,
    IN p_fk_question INT
)
BEGIN
    INSERT INTO Questions_answer (answer, if_answer, fk_question)
    VALUES (p_answer, p_if_answer, p_fk_question);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateQuestionPoints(
    IN p_points INT,
    IN p_id_question INT
)
BEGIN
    UPDATE Questions
    SET points = p_points
    WHERE id_Question = p_id_question;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SelectMaxExamIdWithException(userId INT)
BEGIN
    DECLARE maxId INT;
    SELECT MAX(id_exam) INTO maxId
    FROM exams
    WHERE fk_user = userId;
    IF maxId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No Hay Examenes encontrados.';
    ELSE
        SELECT maxId AS id_exam;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SelectMaxQuestionIdWithException(fk_exam INT)
BEGIN
    DECLARE maxId INT;
    SELECT MAX(id_Question) INTO maxId
    FROM Questions
    WHERE fk_exam = fk_exam;
    IF maxId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No Hay Resultados.';
    ELSE
        SELECT maxId AS id_question;
    END IF;
END //
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE respuestasif(
    idQ INT,
    idAnswer INT
)
BEGIN
    START TRANSACTION;
    UPDATE Questions_answer
    SET if_answer = 0
    WHERE fk_question = idQ;
    UPDATE Questions_answer
    SET if_answer = 1
    WHERE id_Question_answer = idAnswer;
    COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE respuestasif(
	idQ INT,
	idAnswer INT
)
BEGIN
    START TRANSACTION;
    -- Desactivar todas las respuestas de la pregunta
    UPDATE Questions_answer
    SET if_answer = 0
    WHERE fk_question = idQ;

    -- Activar la respuesta específica
    UPDATE Questions_answer
    SET if_answer = 1
    WHERE id_Question_answer = idAnswer;

    -- Confirma los cambios
    COMMIT;
END$$
DELIMITER ;