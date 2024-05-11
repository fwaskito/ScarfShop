/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trash.projek.slempang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.Hashtable;
import javax.servlet.http.HttpServletResponse;
import user.projek.slempang.DbConnection;

/**
 *
 * @author Lenovo
 */
public class Troli {

    private Hashtable troli = null;

    public Troli() {
        troli = new Hashtable();
    }

    public void addItem(String item, int jum) {
        if (item != null) {
            troli.put(item, jum);
        }
    }

    public void delItem(String item) {
        if (item != null) {
            troli.remove(item);
        }
    }

    public boolean isEmpty() {
        return troli.isEmpty();
    }

    public String getAllItem(HttpServletResponse response) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbConn = new DbConnection();

        String order = "<tr><th>Item</th><th>Harga</th>"
                + "<th>jumlah</th><th>SubTotal</th>"
                + "<th><i>delete</i><th><tr>";
                    double total = 0;
        try {
            // All item

            Enumeration en = troli.keys();
            while (en.hasMoreElements()) {
                String id_barang = (String) en.nextElement();
                int jum = (Integer) troli.get(id_barang);

                try {

                    pstmt.setString(1, id_barang);

                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String nama = rs.getString("nama");
                        double harga = rs.getDouble("harga");
                        double sub = harga * jum;
                        total += sub;

                        //rewriting
                        String urlUpdate = "OrderServlet?upd=" + id_barang;
                        urlUpdate = response.encodeURL(urlUpdate);
                        String urlDelete = "OrderServlet?del=" + id_barang;
                        urlDelete = response.encodeURL(urlDelete);

                        //Html
                        order += "<tr><td>" + nama + "</td>"
                                + "<td align='right'>" + harga + "</td>"
                                + "<td><input type='text' maxlength='2' size='3' "
                                + "name='jum'" + id_barang
                                + "' value='" + String.valueOf(jum) + "' />"
                                + "<td align='right'>" + sub + "</td>"
                                + "<td><a href='" + urlDelete + " '>Delete</a></td>"
                                + "</tr>";
                    }
                } catch (Exception e) {
                }

            }
        } catch (Exception e) {

        } finally {
            DbConnection.close(rs);
            DbConnection.close(pstmt);
            DbConnection.close(conn);
        }
        order += "<tr><td colspan='3' align='right'>"
                + "<input type='submit' name='update' value='Update'/>"
                + "</td></tr>";
        order += "<tr><td colspan='3' align='right'>Total</td>"
                + "<td colspan='2'>" + total + "</td>"
                + "</tr>";
        return order;
    }
}
