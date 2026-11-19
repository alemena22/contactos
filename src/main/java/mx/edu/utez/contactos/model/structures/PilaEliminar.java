package mx.edu.utez.contactos.model.structures;

import mx.edu.utez.contactos.model.Contacto;
import mx.edu.utez.contactos.model.structures.nodos.NodoPila;

public class PilaEliminar {
    private NodoPila cima;
    private int tamanio;

    public PilaEliminar() {
        this.cima = null;
        this.tamanio = 0;
    }

    public void push(Contacto dato) {
        NodoPila nuevo = new NodoPila(dato);
        nuevo.siguiente = cima;
        cima = nuevo;
        tamanio++;
    }

    public Contacto pop() {
        if (isEmpty()) {
            return null;
        }
        Contacto dato = cima.dato;
        cima = cima.siguiente;
        tamanio--;
        return dato;
    }

    public Contacto peek() {
        if (isEmpty()) {
            return null;
        }
        return cima.dato;
    }

    public boolean isEmpty() {
        return cima == null;
    }

    public int getTamanio() {
        return tamanio;
    }

    public NodoPila getCima() {
        return cima;
    }
}