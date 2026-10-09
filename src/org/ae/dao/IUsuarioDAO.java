package org.ae.dao;

import org.ae.model.Usuario;

public interface IUsuarioDAO {
    Usuario autenticar(String username, String password);
}