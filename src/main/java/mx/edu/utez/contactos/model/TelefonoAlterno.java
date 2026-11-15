package mx.edu.utez.contactos.model;

public class TelefonoAlterno {
    private int idTelefonoAlterno;
    private int idContacto;
    private String numero;

    public TelefonoAlterno() {
    }

    public TelefonoAlterno(int idTelefonoAlterno, int idContacto, String numero) {
        this.idTelefonoAlterno = idTelefonoAlterno;
        this.idContacto = idContacto;
        this.numero = numero;
    }

    public int getIdTelefonoAlterno() {
        return idTelefonoAlterno;
    }

    public void setIdTelefonoAlterno(int idTelefonoAlterno) {
        this.idTelefonoAlterno = idTelefonoAlterno;
    }

    public int getIdContacto() {
        return idContacto;
    }

    public void setIdContacto(int idContacto) {
        this.idContacto = idContacto;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }
}