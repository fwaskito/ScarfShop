/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin.projek.slempang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Lenovo
 */
public class PesananControll {
    
    private Connection conn = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    private ConnectDB connectdb;

    public PesananControll() {
        connectdb = new ConnectDB();
    }

    public ArrayList<Pesanan> getAllPesanan() {
        ArrayList<Pesanan> list = new ArrayList();
        String sql = "SELECT * FROM orders";
        try {
            rs = connectdb.getStatement().executeQuery(sql);
            while (rs.next()) {
                String id_order = rs.getString(1);
                String id_pembeli = rs.getString(2);
                String id_barang = rs.getString(3);
                String tanggal = rs.getString(4);
                int jumlah = rs.getInt(5);
                double total_biaya = rs.getDouble(6);
                
                Pesanan psn = new Pesanan(id_order, id_pembeli, id_barang, tanggal, jumlah, total_biaya);
                list.add(psn);
            }
        } catch (Exception e) {
            System.out.println("Cek getAllPesanan homeadmin.jsp in barang");
        }
        connectdb.closeConnect();
        return list;
    }

    public boolean updatePesanan(Pesanan psn) throws SQLException {
        String sql = "UPDATE orders SET `id_pembeli`=?, `id_barang`=?, `tanggal`=? `jumlah`=? `total_baiaya`=?  WHERE `id_order`=?";
        stmt = connectdb.openConnect().prepareStatement(sql);
        stmt.setString(1, psn.getId_pembeli());
        stmt.setString(2, psn.getId_barang());
        stmt.setString(3, psn.getTanggal());
        stmt.setInt(4, psn.getJumlah());
        stmt.setDouble(4, psn.getTotal_biaya());
        return stmt.executeUpdate() > 0;
    }

    public boolean delete(String id_order) throws SQLException {
        String sql = "DELETE FROM `orders` WHERE `id_order`=?";
        stmt = connectdb.openConnect().prepareStatement(sql);
        stmt.setString(1, id_order);
        return stmt.executeUpdate() > 0;
    }
    
        public Pesanan getUpdateID(String id_order) throws SQLException {
        String sql = "SELECT * FROM orders WHERE id_order=?";
        stmt = connectdb.openConnect().prepareStatement(sql);
        stmt.setString(1, id_order);
        rs = stmt.executeQuery();
        Pesanan psn = null;
        while (rs.next()) {
                String id = rs.getString(1);
                String id_pembeli = rs.getString(2);
                String id_barang = rs.getString(3);
                String tanggal = rs.getString(4);
                int jumlah = rs.getInt(5);
                double total_biaya = rs.getDouble(6);
                
                 psn = new Pesanan(id, id_pembeli, id_barang, tanggal, jumlah, total_biaya);
           
        }
        return psn;
    }
}
