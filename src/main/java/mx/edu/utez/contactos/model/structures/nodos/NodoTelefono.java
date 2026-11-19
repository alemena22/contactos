package mx.edu.utez.contactos.model.structures.nodos;

import mx.edu.utez.contactos.model.TelefonoAlterno;

public class NodoTelefono {
    public TelefonoAlterno dato;
    public NodoTelefono siguiente;

    public NodoTelefono(TelefonoAlterno dato) {
        this.dato = dato;
        this.siguiente = null;
    }
}