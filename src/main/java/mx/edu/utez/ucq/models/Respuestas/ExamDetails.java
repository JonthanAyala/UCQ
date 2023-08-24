package mx.edu.utez.ucq.models.Respuestas;

public class ExamDetails {

    private Long id_Student_exam;
    private String start_date;
    private String end_date;
    private String name_exam;
    private String professor_name;
    private Long id_s;

    public ExamDetails() {
    }

    public ExamDetails(Long id_Student_exam, String start_date, String end_date, String name_exam, String professor_name, Long id_s) {
        this.id_Student_exam = id_Student_exam;
        this.start_date = start_date;
        this.end_date = end_date;
        this.name_exam = name_exam;
        this.professor_name = professor_name;
        this.id_s = id_s;
    }

    public Long getId_Student_exam() {
        return id_Student_exam;
    }

    public void setId_Student_exam(Long id_Student_exam) {
        this.id_Student_exam = id_Student_exam;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getName_exam() {
        return name_exam;
    }

    public void setName_exam(String name_exam) {
        this.name_exam = name_exam;
    }

    public String getProfessor_name() {
        return professor_name;
    }

    public void setProfessor_name(String professor_name) {
        this.professor_name = professor_name;
    }

    public Long getId_s() {
        return id_s;
    }

    public void setId_s(Long id_s) {
        this.id_s = id_s;
    }
}
