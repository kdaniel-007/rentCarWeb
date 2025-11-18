    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package com.mycompany.rentcarweb.model;

    import java.math.BigDecimal;
    import java.sql.Date;

    public class Pago {

        private int idPago;
        private int idReserva;
        private Date fechaPago;
        private String formaPago;
        private String tipoPago;
        private BigDecimal monto;
        private BigDecimal impuestos;
        private BigDecimal descuento;
        private BigDecimal total;
        private String estado;

        // Getters y Setters
        public int getIdPago() { return idPago; }
        public void setIdPago(int idPago) { this.idPago = idPago; }

        public int getIdReserva() { return idReserva; }
        public void setIdReserva(int idReserva) { this.idReserva = idReserva; }

        public Date getFechaPago() { return fechaPago; }
        public void setFechaPago(Date fechaPago) { this.fechaPago = fechaPago; }

        public String getFormaPago() { return formaPago; }
        public void setFormaPago(String formaPago) { this.formaPago = formaPago; }

        public String getTipoPago() { return tipoPago; }
        public void setTipoPago(String tipoPago) { this.tipoPago = tipoPago; }

        public BigDecimal getMonto() { return monto; }
        public void setMonto(BigDecimal monto) { this.monto = monto; }

        public BigDecimal getImpuestos() { return impuestos; }
        public void setImpuestos(BigDecimal impuestos) { this.impuestos = impuestos; }

        public BigDecimal getDescuento() { return descuento; }
        public void setDescuento(BigDecimal descuento) { this.descuento = descuento; }

        public BigDecimal getTotal() { return total; }
        public void setTotal(BigDecimal total) { this.total = total; }

        public String getEstado() { return estado; }
        public void setEstado(String estado) { this.estado = estado; }
    }
