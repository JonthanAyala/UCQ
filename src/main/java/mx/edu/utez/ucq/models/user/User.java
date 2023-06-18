package mx.edu.utez.ucq.models.user;

public class User {
    private Long id;
    private String usuario;
    private String contra;
    public User() {
    }

    public User(Long id, String usuario, String contra) {
        this.id = id;
        this.usuario = usuario;
        this.contra = contra;
    }

    public String getId() {
        return String.valueOf(id);
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContra() {
        return contra;
    }

    public void setContra(String contra) {
        this.contra = contra;
    }

}