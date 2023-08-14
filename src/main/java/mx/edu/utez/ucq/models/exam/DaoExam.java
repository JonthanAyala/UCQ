package mx.edu.utez.ucq.models.exam;

import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoExam{
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;

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

    public boolean saveQuestion(Question object) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO questions (type_question, description, points) VALUES (?, ?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, object.getType_question());
            pstm.setString(2, object.getDescription());
            pstm.setLong(3, object.getPoints());
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean saveAnswer(Answer object) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO Questions_answer (answer, is_correct, fk_question) VALUES (?, ?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getAnswer());
            pstm.setBoolean(2, object.isIf_answer());
            pstm.setLong(3, object.getFk_question());
            return pstm.executeUpdate() > 0;
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
    public Long extractIdQuestion(String questionDescription) {
        Long id = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_Question) AS id_question FROM question where description = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, questionDescription);
            rs = pstm.executeQuery();
            if (rs.next()) {
                id = rs.getLong("id_question"); // Obtener el valor de la columna "id_exam"
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return id;
    }

    public boolean saveEQ(Long fkExam, Long idQuestion) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO exams_questions (fk_question, fk_exam) VALUES (?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, String.valueOf(idQuestion));
            pstm.setString(2, String.valueOf(fkExam));
            return pstm.executeUpdate() > 0;
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return false;
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
    public Exam findExam(Long code) {
        Exam exam = new Exam();
        try {
        conn = new MySQLConnection().connect();
        String query = "SELECT name,id_exam from exams where code=?;";
        pstm = conn.prepareStatement(query);
        pstm.setString(1, String.valueOf(code));
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return exam;
    }
}
