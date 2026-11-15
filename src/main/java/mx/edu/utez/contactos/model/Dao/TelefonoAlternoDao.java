package mx.edu.utez.contactos.model.Dao;

import mx.edu.utez.contactos.model.TelefonoAlterno;
import mx.edu.utez.contactos.model.structures.ListaSimple;
import mx.edu.utez.contactos.model.structures.NodoTelefono;
import mx.edu.utez.contactos.utils.SQLconnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TelefonoAlternoDao {

    public void insertarLista(Connection con, int idContacto, ListaSimple telefonos) throws SQLException {
        if (telefonos == null || telefonos.isEmpty()) {
            return;
        }

        String sql = "INSERT INTO TELEFONO_ALTERNO(id_contacto, numero) VALUES(?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            NodoTelefono actual = telefonos.getInicio();
            while (actual != null) {
                ps.setInt(1, idContacto);
                ps.setString(2, actual.dato.getNumero());
                ps.executeUpdate();
                actual = actual.siguiente;
            }
        }
    }

    public ListaSimple getByContacto(int idContacto) {
        ListaSimple lista = new ListaSimple();
        String sql = "SELECT id_telefono_alterno, id_contacto, numero FROM TELEFONO_ALTERNO WHERE id_contacto = ? ORDER BY id_telefono_alterno ASC";

        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idContacto);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TelefonoAlterno t = new TelefonoAlterno();
                    t.setIdTelefonoAlterno(rs.getInt("id_telefono_alterno"));
                    t.setIdContacto(rs.getInt("id_contacto"));
                    t.setNumero(rs.getString("numero"));
                    lista.insertarFinal(t);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
}