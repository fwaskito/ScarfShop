/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trash.projek.slempang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import user.projek.slempang.DbConnection;

/**
 *
 * @author Lenovo
 */
public class ChartUser {

    private Map<String, Integer> chart = null;

    public ChartUser() {
        chart = new HashMap<>();
    }

    public void addItem(String item, int jum) {
        if (item != null) {
            chart.put(item, jum);
        }
    }

    public void delItem(String item) {
        if (item != null) {
            chart.remove(item);
        }
    }

    public boolean isEmpty() {
        return chart.isEmpty();
    }

    public Map getAllItem() {
        Map<Object, Object> items = new HashMap();
        Map<Object, Object> detailItem = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
         DbConnection dbConn = new DbConnection();
        String sql = "SELECT * FROM barang WHERE id_barang=?";
        try{     
        conn = dbConn.getConnection();
        Iterator iterator = this.chart.entrySet().iterator();
        while (iterator.hasNext()) {
            detailItem = new HashMap();
            Map.Entry<Object, Object> entry = (Map.Entry) iterator.next();
            String id_barang = (String) entry.getKey();
            int jumlah = (int) this.chart.get(id_barang);
            
            double subtotal = 0.0;
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id_barang);
            
            rs = pstmt.executeQuery();
            
            String nama = "";
            double harga = 0.0;
            while(rs.next()){
                nama = rs.getString("nama");
                harga = rs.getDouble("harga");
                subtotal = harga * jumlah;
                detailItem.put("nama", nama);
                detailItem.put("harga", harga);
                detailItem.put("jumlah", jumlah);
                detailItem.put("subtotal", subtotal);
            }
            
            items.put(id_barang, detailItem);
        }
        }catch(Exception e){
            System.out.println(e);
        }finally{
            dbConn.close(rs);
            dbConn.close(pstmt);
            dbConn.close(conn);
        }
        return items;
    }
}
