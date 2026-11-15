package mx.edu.utez.contactos.model.Dao;

import mx.edu.utez.contactos.model.Contacto;
import mx.edu.utez.contactos.model.structures.ListaDoble;
import mx.edu.utez.contactos.utils.SQLconnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ContactoDao {

    private TelefonoAlternoDao telefonoAlternoDao = new TelefonoAlternoDao();

    public int create(Contacto entidad) {
        String sql = "INSERT INTO CONTACTO(nombre, apellido_paterno, apellido_materno, telefono, correo, id_grupo) VALUES(?, ?, ?, ?, ?, ?)";
        Connection con = null;
        try {
            con = SQLconnector.getConnection();
            con.setAutoCommit(false);

            try (PreparedStatement ps = con.prepareStatement(sql, new String[]{"ID_CONTACTO"})) {
                ps.setString(1, entidad.getNombre());
                ps.setString(2, entidad.getApellidoPaterno());
                ps.setString(3, entidad.getApellidoMaterno().isEmpty() ? null : entidad.getApellidoMaterno());
                ps.setString(4, entidad.getTelefono());
                ps.setString(5, entidad.getCorreo().isEmpty() ? null : entidad.getCorreo());
                ps.setInt(6, entidad.getIdGrupo());

                int filasAfectadas = ps.executeUpdate();
                if (filasAfectadas == 0) {
                    throw new SQLException("No se pudo insertar el contacto.");
                }

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int idContacto = rs.getInt(1);
                        telefonoAlternoDao.insertarLista(con, idContacto, entidad.getTelefonosAlternos());
                        con.commit();
                        return idContacto;
                    }
                }
                throw new SQLException("No se pudo obtener el ID del contacto insertado.");
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            System.out.println(e.getMessage());
            e.printStackTrace();
            return -1;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public ListaDoble getAllActivos() {
        ListaDoble lista = new ListaDoble();
        String sql = "SELECT id_contacto, nombre, apellido_paterno, apellido_materno, telefono, correo, id_grupo " +
                "FROM CONTACTO " +
                "WHERE eliminado_en IS NULL " +
                "ORDER BY fecha_alta DESC";

        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Contacto c = new Contacto();
                c.setIdContacto(rs.getInt("id_contacto"));
                c.setNombre(rs.getString("nombre"));
                c.setApellidoPaterno(rs.getString("apellido_paterno"));
                c.setApellidoMaterno(rs.getString("apellido_materno"));
                c.setTelefono(rs.getString("telefono"));
                c.setCorreo(rs.getString("correo"));
                c.setIdGrupo(rs.getInt("id_grupo"));
                lista.insertarFinal(c);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    public int contarEliminados() {
        String sql = "SELECT COUNT(*) FROM CONTACTO WHERE eliminado_en IS NOT NULL";
        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public boolean telefonoExistente(String telefono) {
        String sql = "SELECT 1 FROM CONTACTO WHERE telefono = ?";
        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, telefono);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean correoExistente(String correo) {
        String sql = "SELECT 1 FROM CONTACTO WHERE correo = ?";
        try (Connection con = SQLconnector.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, correo);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}