package mx.edu.utez.ucq.models.user;

public class User {
    private Long id;
    private String name;
    private String lastname;
    private String surname;
    private String curp;
    private String status;
    private Long type_user;
    private String mail;
    private String enrollment;
    private String password;

    public User() {
    }

    public User(Long id, String name,String lastname, String surname, String curp, String status, Long type_user, String mail, String enrollment, String password) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.lastname = lastname;
        this.curp = curp;
        this.status = status;
        this.type_user = type_user;
        this.mail = mail;
        this.enrollment = enrollment;
        this.password = password;

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getType_user() {
        return type_user;
    }

    public void setType_user(Long type_user) {
        this.type_user = type_user;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(String enrollment) {
        this.enrollment = enrollment;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}