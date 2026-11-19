package mx.edu.utez.contactos.model.structures.nodos;

import mx.edu.utez.contactos.model.Contacto;

public class NodoDoble {
    public Contacto dato;
    public NodoDoble siguiente;
    public NodoDoble anterior;

    public NodoDoble(Contacto dato) {
        this.dato = dato;
        this.siguiente = null;
        this.anterior = null;
    }
}