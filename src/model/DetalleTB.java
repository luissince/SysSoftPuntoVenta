/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.Date;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.SimpleIntegerProperty;

public class DetalleTB implements Serializable {

    private SimpleIntegerProperty idDetalle;
    private SimpleStringProperty idMantenimiento;
    private SimpleStringProperty nombre;
    private SimpleStringProperty descripcion;
    private SimpleStringProperty estado;
    private SimpleStringProperty usuarioRegistro;
    private Date fechaRegistro;

    public DetalleTB() {
    }

    public DetalleTB(SimpleIntegerProperty idDetalle, SimpleStringProperty nombre) {
        this.idDetalle = idDetalle;
        this.nombre = nombre;
    }
    
    

    public SimpleIntegerProperty getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(int idDetalle) {
        this.idDetalle = new SimpleIntegerProperty(idDetalle);
    }

    public SimpleStringProperty getIdMantenimiento() {
        return idMantenimiento;
    }

    public void setIdMantenimiento(String idMantenimiento) {
        this.idMantenimiento = new SimpleStringProperty(idMantenimiento);
    }

    public SimpleStringProperty getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = new SimpleStringProperty(nombre);
    }

    public SimpleStringProperty getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = new SimpleStringProperty(descripcion);
    }

    public SimpleStringProperty getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = new SimpleStringProperty(estado);
    }

    public SimpleStringProperty getUsuarioRegistro() {
        return usuarioRegistro;
    }

    public void setUsuarioRegistro(String usuarioRegistro) {
        this.usuarioRegistro = new SimpleStringProperty(usuarioRegistro);
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    @Override
    public String toString() {
        return nombre.get();
    }

}
