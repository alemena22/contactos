package mx.edu.utez.contactos.model.Dao;

import mx.edu.utez.contactos.model.Grupo;
import mx.edu.utez.contactos.utils.SQLconnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GrupoDao {

    public List<Grupo> getAll() {
        List<Grupo> lista = new ArrayList<>();
        String sql = "SELECT g.id_grupo, g.nombre, COUNT(c.id_contacto) AS total " +
                "FROM GRUPO g " +
                "LEFT JOIN CONTACTO c ON g.id_grupo = c.id_grupo AND c.eliminado_en IS NULL " +
                "GROUP BY g.id_grupo, g.nombre " +
                "ORDER BY g.id_grupo ASC";

        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Grupo g = new Grupo();
                g.setIdGrupo(rs.getInt("id_grupo"));
                g.setNombre(rs.getString("nombre"));
                g.setTotalContactos(rs.getInt("total"));
                lista.add(g);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
    public boolean existeNombre(String nombre) {
        String sql = "SELECT 1 FROM GRUPO WHERE LOWER(nombre) = LOWER(?)";
        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombre.trim());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean create(String nombre) {
        String sql = "INSERT INTO GRUPO(nombre) VALUES(?)";
        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombre.trim());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}