package admin.projek.slempang;

import java.io.File;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.Part;

/**
 *
 * @author Lonely
 */
public class BarangControll {

    private Connection conn = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    private ConnectDB connectdb;

    public BarangControll() {
        connectdb = new ConnectDB();
    }

    public ArrayList<Barang> getAllProducts() {
        ArrayList<Barang> list = new ArrayList();
        String sql = "SELECT * FROM barang";
        try {
            rs = connectdb.getStatement().executeQuery(sql);
            while (rs.next()) {
                String id_barang = rs.getString(1);
                String name = rs.getString(2);
                String image = rs.getString(3);
                double harga = rs.getDouble(4);
                Barang sp = new Barang(id_barang, name, image, harga);
                list.add(sp);
            }
        } catch (Exception e) {
            System.out.println("Please check getAllProduct index.jsp in barang");
        }
        connectdb.closeConnect();
        return list;
    }

    public ArrayList<Barang> cariProduk(String key) throws SQLException {
        ArrayList<Barang> list = new ArrayList();
        String sql = "SELECT * FROM barang WHERE nama LIKE " + "'%" + key + "%'";
        rs = connectdb.getStatement().executeQuery(sql);
        try {
            while (rs.next()) {
                String id_barang = rs.getString(1);
                String name = rs.getString(2);
                String image = rs.getString(3);
                double harga = rs.getDouble(4);
                Barang sp = new Barang(id_barang, name, image, harga);
                list.add(sp);
            }
        } catch (Exception e) {
            System.out.println("Please check getAllProduct index.jsp in barang");
        }
        connectdb.closeConnect();
        return list;
    }

    public boolean insertNew(Barang sp) throws SQLException {
        String sql = "INSERT INTO `barang` (id_barang`, `nama`, `image`, `harga`) VALUES ("
                + sp.getId_barang() + ","
                + sp.getNama() + ","
                + sp.getImage() + ","
                + sp.getHarga() + ")";
        return connectdb.getStatement().executeUpdate(sql) > 0;

    }

    public boolean insertNewGambar(Barang sp) throws SQLException {
        String sql = "UPDATE barang SET `image`=? WHERE `id_barang`=?";
        stmt = connectdb.openConnect().prepareStatement(sql);
//        InputStream file=new InputStream(new File(s));
        stmt.setString(1, sp.getImage());
        stmt.setString(1, sp.getId_barang());
        return stmt.executeUpdate() > 0;
    }

    public boolean updateOld(Barang sp, String id) throws SQLException {
        String sql = "UPDATE barang SET `id_barang`=?, `nama`=?, `image`=?, `harga`=? WHERE `id_barang`=?";
        stmt = connectdb.openConnect().prepareStatement(sql);
        stmt.setString(1, sp.getId_barang());
        stmt.setString(2, sp.getNama());
        stmt.setString(3, sp.getImage());
        stmt.setDouble(4, sp.getHarga());
        stmt.setString(5, id);
        return stmt.executeUpdate() > 0;
    }

    public boolean delete(String id_barang) throws SQLException {
        String sql = "DELETE FROM `barang` WHERE `id_barang`=?";
        stmt = connectdb.openConnect().prepareStatement(sql);
        stmt.setString(1, id_barang);
        return stmt.executeUpdate() > 0;
    }

    public Barang getUpdateID(String id_barang) throws SQLException {
        String sql = "SELECT * FROM barang WHERE id_barang=?";
        stmt = connectdb.openConnect().prepareStatement(sql);
        stmt.setString(1, id_barang);
        rs = stmt.executeQuery();
        Barang sp = null;
        while (rs.next()) {
            String idsp = rs.getString("id_barang");
            String name = rs.getString("nama");
            String image = rs.getString("image");
            double harga = rs.getDouble("harga");
            sp = new Barang(idsp, name, image, harga);
        }
        return sp;
    }
    
    public static void main(String[] args) {
        BarangControll bc = new BarangControll();
        ArrayList<Barang> list = null;
        list = bc.getAllProducts();
        
        String id = "";
        String nama = "";
        String image = "";
        double harga = 0.0;
        for(Barang br : list){
            id = br.getId_barang();
            nama = br.getNama();
            image = br.getImage();
            harga = br.getHarga();
            
            System.out.println("id:"+ id);
            System.out.println("nama:"+ nama);
            System.out.println("image:"+image);
            System.out.println("harga:"+harga);
            System.out.println();
        }
    }
}
