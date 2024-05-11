<%-- 
    Document   : insert
    Created on :
    Author     : Fajar W.
--%>
<%@page import="admin.projek.slempang.*"%>
<%@page import="control.projek.slempang.*"%>
<%@page import="user.projek.slempang.DbConnection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Produk - Admin</title>
    <link rel="stylesheet" type="text/css" href="css/styleinsertupdate.css">
    <link link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" 
          rel="stylesheet"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
</head>
<body>
  <!------------------------------------header----------------------------------->
    <jsp:include page="WEB-INF/jspf/headerAdmin.jspf" />
  <!--------------------------close header--------------------------------------------->
  <div class="small-container">
    <div class="row">
      <h1>Update Produk</h1>
      <br>
    </div>
    <div class="row">
      <%
          String id = request.getParameter("id");
          Barang sp = new BarangControll().getUpdateID(id);

          String id_barang = sp.getId_barang();
          String nama = sp.getNama();
          String gambar = sp.getImage();
          String harga = String.valueOf(sp.getHarga());

          FormatIdn fidn = new FormatIdn();
      %>
      <div class="col-2">
        <img src="gambar/produk/<%=gambar%>" width="100%">
      </div>

      <div class="col-2">
        <br><br>
        <p>Home / Update Produk</p><br>
        <h4><b>ID</b>    : <%=id_barang%></h4>
        <h4><b>Nama</b>  : <%=nama%></h4>
        <h4><b>Gambar</b>: <%=gambar%></h4>
        <h4><b>Harga</b> : <%=fidn.formatter(Double.parseDouble(harga))%></h4><br><br>

        <%
            String urlUpdate = "UpdateServlet?id=" + id;
            urlUpdate = response.encodeURL(urlUpdate);
        %>
        <form action="<%=urlUpdate%>" method="POST">
          <h3>Update Produk</h3>
          <table>
            <tr>
              <td>ID Produk</td>
              <td><input type="text" name="id_barang" value="<%=sp.getId_barang()%>"></td>
            </tr>
            <tr>
              <td>Nama Produk</td>
              <td><input type="text" name="nama" value="<%=sp.getNama()%>"></td>
            </tr>
            <tr>
              <td>Image</td>
              <td><input type="text" name="image" value="<%=sp.getImage()%>"></td>
            </tr>
            <tr>
              <td>Harga</td>
              <td><input type="text" name="harga" value="<%=sp.getHarga()%>"></td>
            </tr>
            <tr>

              <td colspan="2" align="right">
                <button class="btn" type="submit" name="Update">Update</button>
                <button class="btn" type="reset" name="reset">Reset</button>
              </td>
            </tr>
          </table>
        </form>
        <br><br><br><br><br>
      </div>
    </div>
  </div>
  <!-----------------------footer--------------------------------------------->
  <jsp:include page="WEB-INF/jspf/footer.jspf"/>
  <!-----------------------close footer--------------------------------------->
   <!-------------------------js toggle menu------------------------>
  <script>
      var Menuitems = document.getElementById("Menuitems");

      Menuitems.style.maxHeight = "0px";

      function menutoggle() {
          if (Menuitems.style.maxHeight === "0px") {
              Menuitems.style.maxHeight = "200px";
          } else {
              Menuitems.style.maxHeight = "0px";
          }
      }
  </script>
</body>
</html>
