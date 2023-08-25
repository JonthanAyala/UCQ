package mx.edu.utez.ucq.models.exam;

import mx.edu.utez.ucq.models.Respuestas.ExamDetails;
import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoExam{
    private Connection conn,conn2;
    private PreparedStatement pstm, pstm2;
    private ResultSet rs, rs2;

    public boolean saveExam(Exam object) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO exams (name_exam, code, fk_user) VALUES (?, ?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getName_exam());
            pstm.setString(2, object.getCode());
            pstm.setLong(3, object.getFk_user());
            return pstm.executeUpdate() > 0 ;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean updateExam(Exam object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE exams SET name_exam = ? WHERE id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getName_exam());
            pstm.setLong(2,object.getId_exam());
            System.out.println(pstm.executeUpdate());
            return pstm.executeUpdate() > 0 ;
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error update" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean saveQuestion(Question object) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO questions (type_question, fk_exam) VALUES (?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, object.getType_question());
            pstm.setLong(2,object.getFk_exam());
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la pregunta"+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean saveDescription(Question object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE questions SET description = ? WHERE id_Question = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getDescription());
            pstm.setLong(2,object.getId_question());
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean saveScore(Question object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE questions SET points = ? WHERE id_Question = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,object.getPoints());
            pstm.setLong(2,object.getId_question());
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la puntuacion: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean deleteQuestion(Long idQuestion){
        try {
        conn = new MySQLConnection().connect();
        String query = "DELETE FROM questions WHERE id_Question = ?;";
        pstm = conn.prepareStatement(query);
        pstm.setLong(1,idQuestion);
        int result = pstm.executeUpdate();
        System.out.println("Pregunta Eliminada: "+result);
        return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    //crear ID respuesta y colocar la descripcion, si es correcta etc.
    public boolean createAnswer(Long idQ){
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO questions_answer (fk_question) VALUES (?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, idQ);
            int result = pstm.executeUpdate();
            System.out.println("Se creo la respuesta "+idQ+": "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean saveAnswer(Answer object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE questions_answer SET answer = ? WHERE id_Question_answer = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1,object.getAnswer());
            pstm.setLong(2,object.getId_answer());
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la respuesta: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean answerif(Long idQ, Long idAnswer){
        try {
            conn = new MySQLConnection().connect();
            String query = "CALL respuestasif(?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,idQ);
            pstm.setLong(2,idAnswer);
            int result = pstm.executeUpdate();
            System.out.println("Se hizo? : "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean deleteAnswer(Long idA){
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM questions_answer WHERE id_Question_answer = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,idA);
            int result = pstm.executeUpdate();
            System.out.println("Respuesta Eliminada: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public List<Exam> findAllExam(Long id) {
        List<Exam> exams = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * from exams where fk_user = "+id+";";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()){
                Exam exam = new Exam();
                exam.setId_exam(rs.getLong("id_exam"));
                exam.setName_exam(rs.getString("name_exam"));
                exam.setCode(rs.getString("code"));
                exam.setStart_time(rs.getString("start_time"));
                exam.setEnd_time(rs.getString("end_time"));
                exam.setFk_user(rs.getLong("fk_user"));
                exams.add(exam);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return exams;
    }


    public void close(){
        try {
            if(conn != null) conn.close();
            if (pstm != null) pstm.close();
            if (rs != null) rs.close();
        }catch (SQLException e){

        }

    }
    public void close2(){
        try {
            if(conn2 != null) conn2.close();
            if (pstm2 != null) pstm2.close();
            if (rs2 != null) rs2.close();
        }catch (SQLException e){

        }

    }

    public Long extractId(Long userId) {
        Long id = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_exam) AS id_exam FROM exams WHERE fk_user = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, String.valueOf(userId));
            rs = pstm.executeQuery();
            if (rs.next()) {
                id = rs.getLong("id_exam"); // Obtener el valor de la columna "id_exam"
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error extractId"+e.getMessage());
        }finally {
            close();
        }
        return id;
    }
    public Long extractIdQuestion(Long fk_exam) {
        Long id_question = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_Question) AS id_question FROM questions where fk_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, String.valueOf(fk_exam));
            rs = pstm.executeQuery();
            if (rs.next()) {
                id_question = rs.getLong("id_question"); // Obtener el valor de la columna "id_question"
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return id_question;
    }
    public Long extractIdAnswer(Long idQuestion){
        Long id_answer = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_Question_answer) AS id_Question_answer FROM questions_answer where fk_question = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,idQuestion);
            rs = pstm.executeQuery();
            if (rs.next()) {
                id_answer = rs.getLong("id_Question_answer"); // Obtener el valor de la columna "id_question"
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return id_answer;

    }
    public boolean delete(Long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM exams where id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id);
            return  pstm.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error delete"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }


    public boolean comenzar(Long id_exam){
        try {
            // UPDATE `ucq_chido`.`exams` SET `start_time` = 'sysdate()' WHERE (`id_exam` = '53');
            conn = new MySQLConnection().connect();
            String query = "UPDATE exams SET start_time = sysdate() where id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id_exam);
            return  pstm.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error delete"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }
    public boolean terminar(Long id_exam){
        try {
            // UPDATE `ucq_chido`.`exams` SET `start_time` = 'sysdate()' WHERE (`id_exam` = '53');
            conn = new MySQLConnection().connect();
            String query = "UPDATE exams SET end_time = sysdate() where id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id_exam);
            return  pstm.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error delete"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }

    public List<ExamDetails> findAllExamS(Long id) {
        List<ExamDetails> exams = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM ExamDetails WHERE id_s = "+id+";";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()){
                ExamDetails examsd = new ExamDetails();
                examsd.setId_Student_exam(rs.getLong("id_Student_exam"));
                examsd.setStart_date(rs.getString("start_date"));
                examsd.setEnd_date(rs.getString("end_date"));
                examsd.setName_exam(rs.getString("name_exam"));
                examsd.setProfessor_name(rs.getString("professor_name"));
                examsd.setId_s(rs.getLong("id_s"));
                exams.add(examsd);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return exams;
    }

    // Buscar examen
    public Long findExam(String code) {
        Long id_exam = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT id_exam from exams where code = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, code);
            rs = pstm.executeQuery();
            if (rs.next()) {
                id_exam = rs.getLong("id_exam"); // Obtener el valor de la columna
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findExam"+e.getMessage());
        }finally {
            close();
        }
        return id_exam;
    }

    //-------------------------Validacion de contruccion de exam
        public Exam LoadExam(Long id_exam){
            try {
                conn = new MySQLConnection().connect();
                String query = "SELECT * FROM exams WHERE id_exam = ?;";
                pstm = conn.prepareStatement(query);
                pstm.setLong(1, id_exam);

                rs = pstm.executeQuery();
                if (rs.next()) {
                    Exam exam = new Exam();
                    exam.setId_exam(rs.getLong("id_exam"));
                    exam.setName_exam(rs.getString("name_exam"));
                    exam.setCode(rs.getString("code"));
                    exam.setStart_time(rs.getString("start_time"));
                    exam.setEnd_time(rs.getString("end_time"));
                    exam.setFk_user(rs.getLong("fk_user"));
                    return exam;
                }
            } catch (SQLException e) {
                Logger.getLogger(DaoUser.class.getName())
                        .log(Level.SEVERE,
                                "Credentials mismatch: " + e.getMessage());
            } finally {
                close();
            }
            return null;
        }

        public boolean createStudentExam(Long idExam, Long fkUser) {
            try {
                conn = new MySQLConnection().connect();
                String query = "INSERT INTO Students_exam (fk_exam, fk_user, start_date)" +
                        " VALUES ( ?, ?, NOW());";
                pstm = conn.prepareCall(query);
                pstm.setLong(1, idExam);
                pstm.setLong(2, fkUser);
                return  pstm.executeUpdate() == 1;
            } catch (SQLException e) {
                Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findExam" + e.getMessage());
            } finally {
                close();
            }
            return false;
        }

        public Long extractIdStudentExam(Long fkUser) {
            System.out.printf("fkUser en DAO: "+fkUser);
            Long id_student_exam = null;
            try {
                conn = new MySQLConnection().connect();
                String query = "SELECT MAX(id_Student_exam) AS max_id FROM students_exam WHERE fk_user = ?;";
                pstm = conn.prepareStatement(query);
                pstm.setLong(1, fkUser);
                rs = pstm.executeQuery();
                if (rs.next()) {
                    id_student_exam = rs.getLong("max_id");
                    System.out.println("idSW: " + id_student_exam);
                }
            } catch (SQLException e) {
                Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findExam" + e.getMessage());
            } finally {
                close();
            }
            return id_student_exam;
        }

        public List<Question> constructQ (Long id_exam){
            List<Question> questions = new ArrayList<>();
            try {
                conn = new MySQLConnection().connect();
                String query = "SELECT * FROM questions where fk_exam = "+id_exam+";";
                pstm = conn.prepareStatement(query);
                rs = pstm.executeQuery();
                while (rs.next()){
                    Question questionA = new Question();
                    questionA.setId_question(rs.getLong("id_Question"));
                    questionA.setType_question(rs.getLong("type_question"));
                    questionA.setDescription(rs.getString("description"));
                    questionA.setPoints(rs.getLong("points"));
                    List<Answer> answers = new ArrayList<>();
                    try {
                        conn2 = new MySQLConnection().connect();
                        String query2 = "SELECT * from questions_answer WHERE fk_question= "+questionA.getId_question()+";";
                        pstm2 = conn2.prepareStatement(query2);
                        rs2 = pstm2.executeQuery();
                        while (rs2.next()) {
                            Answer answerA = new Answer();
                            answerA.setId_answer(rs2.getLong("id_Question_answer"));
                            answerA.setAnswer(rs2.getString("answer"));
                            answers.add(answerA);
                        }
                    }catch (SQLException e){
                        Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
                    }finally {
                        close2();
                    }

                    questionA.setAnswer(answers);

                    questions.add(questionA);
                }
            }catch (SQLException e){
                Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
            }finally {
                close();
            }
            return questions;
        }

    public boolean createStudentAnswer(Long idA, Long idQ, Long idSe) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO students_exam_answer (fk_student_exam, fk_answer, fk_question) " +
                    "VALUES ( ?,?,?);";
            pstm = conn.prepareCall(query);
            pstm.setLong(1, idSe);
            pstm.setLong(2, idA);
            pstm.setLong(3,idQ);
            return  pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findExam" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public Long extractIDStudentAnswer(Long idSe) {
        Long id_Student_Answer = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_Student_exam_answer) AS max_id_SEA FROM students_exam_answer WHERE fk_student_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, idSe);
            rs = pstm.executeQuery();
            if (rs.next()) {
                id_Student_Answer = rs.getLong("max_id_SEA");
                System.out.println("idSEA: " + id_Student_Answer);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findExam" + e.getMessage());
        } finally {
            close();
        }
        return id_Student_Answer;
    }

    public boolean updateStudentAnswer(Long id_SE_A, Long id_A) {
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE students_exam_answer SET fk_answer = ? WHERE id_Student_exam_answer = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id_A);
            pstm.setLong(2,id_SE_A);
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la respuesta: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;

    }

    public boolean createStudentAnswerOpen(Long id_Question, Long id_Student_Exam, String answer) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO students_exam_answer (fk_student_exam, answer, fk_question) " +
                    "VALUES ( ?,?,?);";
            pstm = conn.prepareCall(query);
            pstm.setLong(1, id_Student_Exam);
            pstm.setString(2, answer);
            pstm.setLong(3,id_Question);
            return  pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findExam" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean updateStudentAnswerOpen(Long idStudentExamAnswer, String updatedAnswer) {
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE students_exam_answer SET answer = ? WHERE id_Student_exam_answer = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1,updatedAnswer);
            pstm.setLong(2,idStudentExamAnswer);
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la respuesta: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;


    }
}
