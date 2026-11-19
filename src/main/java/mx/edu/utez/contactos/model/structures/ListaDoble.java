package mx.edu.utez.contactos.model.structures;

import mx.edu.utez.contactos.model.Contacto;
import mx.edu.utez.contactos.model.structures.nodos.NodoDoble;

public class ListaDoble {
    private NodoDoble inicio;

    public ListaDoble() {
        this.inicio = null;
    }

    public void insertarFinal(Contacto dato) {
        NodoDoble nodoFinal = new NodoDoble(dato);
        if (inicio == null) {
            inicio = nodoFinal;
        } else {
            NodoDoble actual = inicio;
            while (actual.siguiente != null) {
                actual = actual.siguiente;
            }
            nodoFinal.anterior = actual;
            actual.siguiente = nodoFinal;
        }
    }

    public NodoDoble getInicio() {
        return inicio;
    }

    public boolean isEmpty() {
        return inicio == null;
    }
}