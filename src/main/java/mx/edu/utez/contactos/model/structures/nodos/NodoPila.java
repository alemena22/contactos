package mx.edu.utez.contactos.model.structures.nodos;

import mx.edu.utez.contactos.model.Contacto;

public class NodoPila {
    public Contacto dato;
    public NodoPila siguiente;

    public NodoPila(Contacto dato) {
        this.dato = dato;
        this.siguiente = null;
    }
}