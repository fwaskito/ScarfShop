<%-- 
    Document   : detailProduk
    Created on : Dec 14, 2020, 4:41:31 AM
    Author     : Fajar W.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="user.projek.slempang.*" %>
<%@page import="control.projek.slempang.FormatIdn" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detail Produk</title>
    <link rel="stylesheet" type="text/css" href="css/styledetailproduk.css">
    <link link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" 
          rel="stylesheet"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body>
    <!------------------------header------------------------->
  <jsp:include page="WEB-INF/jspf/headerPembeli.jspf" />
    <!--------------- single product details ----------------->
    <%
        String id_barang = request.getParameter("id_barang");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbConn = new DbConnection();

        String nama = "";
        String gambar = "";
        double harga = 0.0;
        try {
            conn = dbConn.getConnection();
            pstmt = conn.prepareStatement("SELECT * FROM barang WHERE id_barang=?");
            pstmt.setString(1, id_barang);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                nama = rs.getString("nama");
                gambar = rs.getString("image");
                harga = rs.getDouble("harga");
            }

        } catch (SQLException sqle) {
        } finally {
            dbConn.close(rs);
            dbConn.close(pstmt);
            dbConn.close(conn);
        }

        String urlOrder = "order.jsp?id_barang=" + id_barang;
        urlOrder = response.encodeURL(urlOrder);
        FormatIdn fidn = new FormatIdn();
    %>

    <div class="small-container single-product">
      <div class="row">
        <div class="col-2">
          <img src="gambar/produk/<%=gambar%>" width="100%" id="ProductImg">
        </div>

        <div class="col-2">
          <p>Home / Detail</p>
          <h1><%=nama%></h1>
          <h4><%=fidn.formatter(harga)%></h4>
          <form action="<%=urlOrder%>" method="post">
            <table>
              <tr>
                <td>Jumlah</td>
                <td><input id="jumlah" type="number" value="1" name="jumlah"/></td>           
              </tr>
              <tr>
                <td><input id="order" type="submit" value="order" name="order" /></td>
              </tr>
            </table>    
          </form>
          <br>
        </div>
      </div>
    </div>
    <!-----------------------footer--------------------------------------------->
    <jsp:include page="WEB-INF/jspf/footer.jspf"/>
    <!----------------------close footer---------------------------------------->
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