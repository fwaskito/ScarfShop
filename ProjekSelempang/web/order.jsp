<%-- 
    Document   : order
    Created on : Dec 14, 2020, 4:41:31 AM
    Author     : Fajar W
--%>

<%@page import="control.projek.slempang.FormatIdn"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="user.projek.slempang.*" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Produk</title>
    <link rel="stylesheet" type="text/css" href="css/styleorder.css">
    <link link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" 
          rel="stylesheet"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body>
    <!------------------------header------------------------->
<jsp:include page="WEB-INF/jspf/headerPembeli.jspf" />
   <!---------------------close header------------------------------->

    <%
        String id_pembeli = (String) session.getAttribute("id");
        String id_barang = (String) request.getParameter("id_barang");
        int jumlah = Integer.valueOf(request.getParameter("jumlah"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbConn = new DbConnection();

        String nama_barang = "";
        double harga = 0.0;
        double total = 0.0;
        int afterOrder = 0;

        String nama_pembeli = "";
        String email = "";
        String alamat = "";
        String no_telpon = "";

        try {
            conn = dbConn.getConnection();
            pstmt = conn.prepareStatement("SELECT * FROM barang WHERE id_barang=?");
            pstmt.setString(1, id_barang);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                nama_barang = rs.getString("nama");
                harga = rs.getDouble("harga");
            }
            total = harga * jumlah;
            pstmt = conn.prepareStatement("SELECT * FROM pembeli  WHERE id_pembeli=?");
            pstmt.setString(1, id_pembeli);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                nama_pembeli = rs.getString("nama");
                email = rs.getString("email");
                alamat = rs.getString("alamat");
                no_telpon = rs.getString("no_telpon");
            }

            if (request.getParameter("pesan") != null) {
                pstmt = conn.prepareStatement("INSERT INTO orders (id_pembeli, id_barang, tanggal, jumlah, total_biaya) VALUES (?, ?, ?, ?, ?)");

                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                Calendar cal = Calendar.getInstance();
                String time = dateFormat.format(cal.getTime());

                pstmt.setString(1, id_pembeli);
                pstmt.setString(2, id_barang);
                pstmt.setString(3, time);
                pstmt.setInt(4, jumlah);
                pstmt.setDouble(5, total);
                afterOrder = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            dbConn.close(rs);
            dbConn.close(pstmt);
            dbConn.close(conn);
        }

    %>
    <br><br><br><br>    
    <div class="small-container">
      <div class="row">
        <!-----------------------------data pesanan------------------------------------->
        <div class="col-2">
          <h2>Order Produk</h2>
          <br>
          <table>
            <tr>
              <td><h3>Item</h3></td>
              <td><h4>:  <%=nama_barang%></h4></td>
            </tr>
            <%
                FormatIdn fidn = new FormatIdn();
            %>
            <tr>
              <td><h3>Harga</h3></td>
              <td><h4>:  <%=fidn.formatter(harga)%></h4></td>
            </tr>
            <tr>
              <td><h3>Jumlah</h3></td>
              <td><h4>:  <%=jumlah%></h4></td>
            </tr>
            <tr>
              <td><h3>Total</h3></td>
              <td><h4>:  <%=fidn.formatter(total)%></h4></td>
            </tr>
          </table>
          <br><br><br><br><br><br>
        </div>
        <!---------------------close data pesanan------------------------------------>
        
        <!---------------------data pembeli------------------------------------------>
        <div class="col-2">
          <h2>Data Pemesan</h2>
          <br>
          <table>
            <tr>
              <td><h3>Nama</h3></td>
              <td><h4>:  <%=nama_pembeli%></h4></td>
            </tr>
            <tr>
              <td><h3>Email</h3></td>
              <td><h4>:  <%=email%></h4></td>
            </tr>
            <tr>
              <td><h3>Nomor Telpon</h3></td>
              <td><h4>:  <%=no_telpon%></h4></td>
            </tr>
            <tr>
              <td><h3>Alamat</h3></td>
              <td><h4>:  <%=alamat%></h4></td>
            </tr>
          </table>
          <br>

          <%
              if (afterOrder == 0) {
                  String pesan = "yes";
                  String urlOrder = "order.jsp?id_barang=" + id_barang
                          + "&id_pembeli=" + id_pembeli
                          + "&jumlah=" + jumlah
                          + "&pesan=" + pesan;
                  urlOrder = response.encodeURL(urlOrder);
          %>
          <br>
          <a href="<%=urlOrder%>" class="btn">Pesan</a>      
          <%
          } else {
              String urlAfterOrder = "home.jsp?id_pembeli=" + id_pembeli;
              urlAfterOrder = response.encodeURL(urlAfterOrder);
          %>
          <h4><i>Pesanan telah diposes.</i></h4>
          <a href="<%=urlAfterOrder%>" class="btn">Kembali ke Home</a>  
          <%              }
          %>
        </div>
        <!--------------------------close data pembeli----------------------------->
      </div>
    </div>
  </div>
  <br><br><br>
  
  <!-----------------footer------------------->
  <jsp:include page="WEB-INF/jspf/footer.jspf"/>
  <!-------------close footer------------------>
  <!-------------------------js for toggle menu------------------------>
  <script>
      var Menuitems = document.getElementById("Menuitems");

      Menuitems.style.maxHeight = "0px";

      function menutoggle() {
          if (Menuitems.style.maxHeight == "0px") {
              Menuitems.style.maxHeight = "200px";
          } else {
              Menuitems.style.maxHeight = "0px";
          }
      }
  </script>
</body>
</html>