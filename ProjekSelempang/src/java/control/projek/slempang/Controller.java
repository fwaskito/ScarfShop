package control.projek.slempang;

import admin.projek.slempang.Barang;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import user.projek.slempang.DbConnection;

/**
 *
 * @author Fajar W.
 */
public class Controller {

    public boolean addProduk(Barang br) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int rs = 0;

        DbConnection dbc = new DbConnection();
        try {
            con = dbc.getConnection();
            String sql = "INSERT INTO barang VALUES (?,?,?,?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, br.getId_barang());
            pstmt.setString(2, br.getNama());
            pstmt.setString(3, br.getImage());
            pstmt.setDouble(4, br.getHarga());

            rs = pstmt.executeUpdate();
        } catch (SQLException sqle) {
            System.out.println("Kesalahan: " + sqle);
        } finally {
            DbConnection.close(pstmt);
            DbConnection.close(con);
        }

        if (rs > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean addGambar(String img, String id_barang){
        Connection con = null;
        PreparedStatement pstmt = null;
        //Statement stmt = null;
        int rs = 0;

        DbConnection dbc = new DbConnection();
        try {
            con = dbc.getConnection();
            String sql = "UPDATE barang SET image = ? WHERE id_barang = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, img);
            pstmt.setString(2, id_barang);

            rs = pstmt.executeUpdate();
        } catch (SQLException sqle) {
            System.out.println("Kesalahan: " + sqle);
        } finally {
            DbConnection.close(pstmt);
            DbConnection.close(con);
        }

        if (rs > 0) {
            return true;
        } else {
            return false;
        }
    }
}
