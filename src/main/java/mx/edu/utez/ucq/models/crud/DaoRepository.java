package mx.edu.utez.ucq.models.crud;

import java.util.List;

public interface DaoRepository <T>{


    List<T> findAll();

    T findOne(long id);

    boolean save(T object);

    boolean update(T object);

    boolean delete(Long id);

    T loadUserByUsernameAndPassword(String mail, String password);
}