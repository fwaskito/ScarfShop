/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin.projek.slempang;

/**
 *
 * @author Lenovo
 */
public class Pesanan {
    String id_order;
    String id_pembeli;
    String id_barang;
    String tanggal;
    int jumlah;
    double total_biaya;

    public Pesanan(String id_order, String id_pembeli, String id_barang, String tanggal, int jumlah, double total_biaya) {
        this.id_order = id_order;
        this.id_pembeli = id_pembeli;
        this.id_barang = id_barang;
        this.tanggal = tanggal;
        this.jumlah = jumlah;
        this.total_biaya = total_biaya;
    }

    public String getId_order() {
        return id_order;
    }

    public void setId_order(String id_order) {
        this.id_order = id_order;
    }

    public String getId_pembeli() {
        return id_pembeli;
    }

    public void setId_pembeli(String id_pembeli) {
        this.id_pembeli = id_pembeli;
    }

    public String getId_barang() {
        return id_barang;
    }

    public void setId_barang(String id_barang) {
        this.id_barang = id_barang;
    }

    public String getTanggal() {
        return tanggal;
    }

    public void setTanggal(String tanggal) {
        this.tanggal = tanggal;
    }

    public int getJumlah() {
        return jumlah;
    }

    public void setJumlah(int jumlah) {
        this.jumlah = jumlah;
    }

    public double getTotal_biaya() {
        return total_biaya;
    }

    public void setTotal_biaya(double total_biaya) {
        this.total_biaya = total_biaya;
    }
    
    
}
