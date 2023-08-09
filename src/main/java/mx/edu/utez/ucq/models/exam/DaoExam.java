package mx.edu.utez.ucq.models.exam;

import mx.edu.utez.ucq.models.crud.DaoRepository;
import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.models.user.User;
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

    public boolean saveExam (Exam object){
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO exams (name_exam,code,fk_user) VALUES (?,?,?)";
            pstm = conn.prepareStatement(query);
            pstm.setString(1,object.getName_exam());
            pstm.setString(2,object.getCode());
            pstm.setLong(3,object.getFk_user());
            return pstm.executeUpdate() > 0; // == 1
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE,"Error save"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }

    public boolean saveQuestion (Question object){
        try {
            /*
        private long id_question;
        private String ur_image;
        private Long type_question;
        private String Description;
        private Long points;
        */
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO questions () VALUES (?,?,?)";

            return pstm.executeUpdate() > 0; // == 1
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE,"Error save"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }
    public boolean saveAnswer (Answer object){
        try {
            /*
        private Long id_question_answer;
        private String answer;
        private boolean if_answer;
        private Long fk_question;
        */
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO questions_answer () VALUES (?,?,?)";

            return pstm.executeUpdate() > 0; // == 1
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE,"Error save"+e.getMessage());
        }finally {
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
}
