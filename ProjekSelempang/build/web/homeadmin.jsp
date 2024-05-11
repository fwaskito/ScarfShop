<%-- 
    Document   : homeadmin
    Created on : 
    Author     : Dewi
--%>

<%@page import="control.projek.slempang.FormatIdn"%>
<%@page import="admin.projek.slempang.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Admin</title>
    <link rel="stylesheet" type="text/css" href="css/stylehomeadmin.css">
    <link link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" 
          rel="stylesheet"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body>
    <!------------------------ header----------------------------->
    <jsp:include page="WEB-INF/jspf/headerAdmin.jspf" />
    <!--------------------header close---------------------------->
    <!--------------------samll container------------------------->
    <div class="small-container">
      <!-------------------sorting--------------------------------->
      <div class="info-adm">
        <h3>Anda login sebagai admin</h3>
      </div>
      <div class="info-adm">
        <b>ID</b>    : <%=session.getAttribute("id")%>
      </div>
      <div class="info-adm">
        <b>Nama</b>  : <%=session.getAttribute("nama")%>
      </div>

      <br><br>
      <div class="row">
        <h1 align="center">Semua Produk yang Terupload</h1>
      </div>

      <div class="row row-2">
        <h3 class="insert"><a href="insert.jsp">Upload Produk Baru</a></h3>

        <form action="homeadmin.jsp" method="POST">
          <h4>Cari</h4>
          <input type="text"  name="cari" value="" class="cari"/>
          <input type="submit" name="submit-cari" value="cari"/>
        </form>

        <form action="homeadmin.jsp" method="post">
          <h4>Sorting</h4>
          <%
              String sorting = "";
              if (request.getParameter("submit-sorting") != null) {
                  sorting = (String) request.getParameter("sorting");

                  if (sorting.startsWith("ALL")) {
          %>
          <select name="sorting">
            <option value="ALL" selected>Semua Produk</option>
            <option value="CL">Classic</option>
            <option value="CU">Custom</option>
            <option value="IN">International</option>
            <option value="LI">Line</option>
          </select>
          <%          } else if (sorting.startsWith("CL")) {
          %>
          <select name="sorting">
            <option value="ALL">Semua Produk</option>
            <option value="CL" selected>Classic</option>
            <option value="CU">Custom</option>
            <option value="IN">International</option>
            <option value="LI">Line</option>
          </select>
          <%          } else if (sorting.startsWith("CU")) {
          %>
          <select name="sorting">
            <option value="ALL">Semua Produk</option>
            <option value="CL">Classic</option>
            <option value="CU" selected>Custom</option>
            <option value="IN">International</option>
            <option value="LI">Line</option>
          </select>
          <%          } else if (sorting.startsWith("IN")) {
          %>
          <select name="sorting">
            <option value="ALL">Semua Produk</option>
            <option value="CL">Classic</option>
            <option value="CU">Custom</option>
            <option value="IN" selected>International</option>
            <option value="LI">Line</option>
          </select>
          <%
          } else {
          %>
          <select name="sorting">
            <option value="ALL">Semua Produk</option>
            <option value="CL">Classic</option>
            <option value="CU">Custom</option>
            <option value="IN">International</option>
            <option value="LI" selected>Line</option>
          </select>
          <%
              }
          } else {
          %>
          <select name="sorting">
            <option value="ALL" selected>Semua Produk</option>
            <option value="CL">Classic</option>
            <option value="CU">Custom</option>
            <option value="IN">International</option>
            <option value="LI">Line</option>
          </select>
          <%
              }

          %> 
          <input type="submit" value="sorting" name="submit-sorting">
        </form>
      </div>
      <!-------------------sorting close---------------------->

      <!--------------------list barang---------------------------->
      <%          ArrayList<Barang> lst = null;
          BarangControll bc = new BarangControll();
          int temp = 0;
          FormatIdn fidn = new FormatIdn();

          if (request.getParameter("submit-cari") == null) {
              lst = bc.getAllProducts();

              for (Barang sp : lst) {
                  String id_barang = sp.getId_barang();
                  String nama = sp.getNama();
                  String gambar = sp.getImage();
                  double harga = sp.getHarga();

                  String editURL = "update.jsp?id=" + id_barang;
                  String deleteURL = "DeleteServlet?id=" + id_barang;
                  if (temp == 0) {

      %>
      <div class="row">
        <%              }
            if (temp <= 5) {
                if (request.getParameter("submit-sorting") != null) {
                    if (!sorting.equals("ALL")) {
                        if (id_barang.startsWith(sorting)) {
                            temp++;
        %>
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4>[ID: <%=id_barang%>]</h4>
          <h4><%=nama%></h4>
          <p><%=fidn.formatter(harga)%></p><hr>
          <h4><b><a href="<%=editURL%>">Update</a></b></h4>
          <h4><b><i><a href="<%=deleteURL%>"><font color="red">Delete</font></a></i></b></h4>
        </div>
        <%
            }
        } else {
            temp++;
        %> 
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4>[ID: <%=id_barang%>]</h4>
          <h4><%=nama%></h4>
          <p><%=fidn.formatter(harga)%></p><hr>
          <h4><b><a href="<%=editURL%>">Update</a></b></h4>
          <h4><b><i><a href="<%=deleteURL%>"><font color="red">Delete</font></a></i></b></h4>
        </div>
        <%
            }
        } else {
            temp++;
        %>
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4>[ID: <%=id_barang%>]</h4>
          <h4><%=nama%></h4>
          <p><%=fidn.formatter(harga)%></p><hr>
          <h4><b><a href="<%=editURL%>">Update</a></b></h4>
          <h4><b><i><a href="<%=deleteURL%>"><font color="red">Delete</font></a></i></b></h4>
        </div>
        <%
                }
            }
            if (temp == 5) {
                temp = 0;
        %>
        <!-- </table>--->
      </div>
      <%
              }
          }
      } else {
          String key = (String) request.getParameter("cari");
          lst = new BarangControll().cariProduk(key);
          for (Barang sp : lst) {
              String id_barang = sp.getId_barang();
              String nama = sp.getNama();
              String gambar = sp.getImage();
              double harga = sp.getHarga();

              String editURL = "update.jsp?id=" + id_barang;
              String deleteURL = "DeleteServlet?id=" + id_barang;
              if (temp == 0) {

      %>
      <div class="row">
        <%              }
            if (temp <= 5) {
                temp++;
        %>
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4>[ID: <%=id_barang%>]</h4>
          <h4><%=nama%></h4>
          <p><%=fidn.formatter(harga)%></p><hr>
          <h4><b><a href="<%=editURL%>">Update</a></b></h4>
          <h4><b><i><a href="<%=deleteURL%>"><font color="red">Delete</font></a></i></b></h4>
        </div>
        <%
            }

            if (temp == 5) {
                temp = 0;
        %>
      </div>
      <%
                  }
              }
          }
      %>

    </div>
    <!-----------------------------close list barang------------------------------->

    <!-------------------------------------close small container--------------------------->
  </div>
  <!----------------------footer--------------------->
  <jsp:include page="WEB-INF/jspf/footer.jspf" />
  <!-------------------close footer------------------->

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