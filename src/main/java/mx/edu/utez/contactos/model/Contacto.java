package mx.edu.utez.contactos.model;

import mx.edu.utez.contactos.model.structures.ListaSimple;
import java.sql.Timestamp;

public class Contacto {
    private int idContacto;
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String telefono;
    private String correo;
    private int idGrupo;
    private Timestamp fechaAlta;
    private Timestamp eliminadoEn;
    private ListaSimple telefonosAlternos;

    public Contacto() {
        this.telefonosAlternos = new ListaSimple();
    }

    public void agregarTelefonoAlterno(String numero) {
        if (numero != null && !numero.trim().isEmpty()) {
            TelefonoAlterno tel = new TelefonoAlterno();
            tel.setNumero(numero.trim());
            this.telefonosAlternos.insertarFinal(tel);
        }
    }

    public int getIdContacto() {
        return idContacto;
    }

    public void setIdContacto(int idContacto) {
        this.idContacto = idContacto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidoPaterno() {
        return apellidoPaterno;
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public String getApellidoMaterno() {
        return apellidoMaterno;
    }

    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getIdGrupo() {
        return idGrupo;
    }

    public void setIdGrupo(int idGrupo) {
        this.idGrupo = idGrupo;
    }

    public Timestamp getFechaAlta() {
        return fechaAlta;
    }

    public void setFechaAlta(Timestamp fechaAlta) {
        this.fechaAlta = fechaAlta;
    }

    public Timestamp getEliminadoEn() {
        return eliminadoEn;
    }

    public void setEliminadoEn(Timestamp eliminadoEn) {
        this.eliminadoEn = eliminadoEn;
    }

    public ListaSimple getTelefonosAlternos() {
        return telefonosAlternos;
    }
}