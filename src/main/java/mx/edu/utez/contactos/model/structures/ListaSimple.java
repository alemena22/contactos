package mx.edu.utez.contactos.model.structures;

import mx.edu.utez.contactos.model.TelefonoAlterno;

public class ListaSimple {
    private NodoTelefono inicio;

    public ListaSimple() {
        this.inicio = null;
    }

    public void insertarFinal(TelefonoAlterno dato) {
        NodoTelefono nodoFinal = new NodoTelefono(dato);
        if (inicio == null) {
            inicio = nodoFinal;
        } else {
            NodoTelefono actual = inicio;
            while (actual.siguiente != null) {
                actual = actual.siguiente;
            }
            actual.siguiente = nodoFinal;
        }
    }

    public NodoTelefono getInicio() {
        return inicio;
    }

    public void setInicio(NodoTelefono inicio) {
        this.inicio = inicio;
    }
    public boolean isEmpty() {
        return inicio == null;
    }
}