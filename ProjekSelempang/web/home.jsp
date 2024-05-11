<%-- 
    Document   : home
    Created on : Dec 13, 2020, 3:31:47 PM
    Author     : Fajar Waskito
--%>
<%@page import="control.projek.slempang.FormatIdn"%>
<%@page import="admin.projek.slempang.*"%>
<%@page import="java.util.ArrayList"%>

<%
    String id_pembeli = "";
    if (request.getParameter("id_pembeli") != null) {
        id_pembeli = (String) request.getParameter("id_pembeli");
    }
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - User</title>
    <link rel="stylesheet" type="text/css" href="css/stylehome.css">
    <link link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" 
          rel="stylesheet"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body>

    <!-----------------------------------------header----------------------------------------->
    <jsp:include page="WEB-INF/jspf/headerPembeli.jspf" />
    <!-------------------------------------close header--------------------------------------->
    <!-------------------------------------Info User---------------------------------->
    <br>
    <div class="small-container">
      <div class="info-adm">
        <b>Anda login sebagai</b> :<%=session.getAttribute("nama")%>
      </div>
      <div class="info-adm">
        <b>ID</b>    : <%=session.getAttribute("id")%>
      </div>
      <br>
      <div class="row">
        <h1>Katalog</h1>
      </div>
      <!------------------------------------------------------------------------------>
      <!------------------------------Search & Sorting-------------------------------->
      <div class="row row-2">

        <form action="home.jsp" method="POST">
          <h4>Cari</h4>
          <input type="text"  name="cari" value="" class="cari"/>
          <input type="submit" name="submit-cari" value="cari"/>
        </form>

        <form action="home.jsp" method="post">
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
      <!------------------------------------Close search & Soritng-------------------------------->
      <!------------------------------------------Katalog----------------------------------------->
      <%                ArrayList<Barang> lst = null;
          BarangControll bc = new BarangControll();
          int temp = 0;
          FormatIdn fidn = new FormatIdn();
          String urlDetail;

          if (request.getParameter("submit-cari") == null) {
              lst = bc.getAllProducts();
              for (Barang sp : lst) {
                  String id_barang = sp.getId_barang();
                  String nama = sp.getNama();
                  String gambar = sp.getImage();
                  double harga = sp.getHarga();
                  urlDetail = "";
                  urlDetail = "detailProduk.jsp?id_barang=" + id_barang;
                  urlDetail = response.encodeURL(urlDetail);
                  if (temp == 0) {

      %>
      <div class="row">
        <%              }
            if (temp <= 3) {
                if (request.getParameter("submit-sorting") != null) {
                    if (!sorting.equals("ALL")) {
                        if (id_barang.startsWith(sorting)) {
                            temp++;
        %>
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4><a href="<%=urlDetail%>"><b><%=nama%></b></a></h4>
          <p><%=fidn.formatter(harga)%></p>
        </div>
        <%
            }
        } else {
            temp++;
        %> 
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4><a href="<%=urlDetail%>"><b><%=nama%></b></a></h4>
          <p><%=fidn.formatter(harga)%></p>
        </div>
        <%
            }
        } else {
            temp++;
        %>
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4><a href="<%=urlDetail%>"><b><%=nama%></b></a></h4>
          <p><%=fidn.formatter(harga)%></p>
        </div>
        <%
                }
            }

            if (temp == 3) {
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
              urlDetail = "";
              urlDetail = "detailProduk.jsp?id_barang=" + id_barang;
              urlDetail = response.encodeURL(urlDetail);
              if (temp == 0) {

      %>
      <div class="row">
        <%              }
            if (temp <= 3) {
                temp++;
        %>
        <div class="col-4">
          <img src="gambar/produk/<%=gambar%>">
          <h4><a href="<%=urlDetail%>"><b><%=nama%></b></a></h4>
          <p><%=fidn.formatter(harga)%></p>
        </div>
        <%
            }

            if (temp == 3) {
                temp = 0;
        %>
        <!-- </table>--->
      </div>
      <%
                  }
              }
          }
      %>

    </div>
    <!------------------------------close katalog--------------------------------------->
    <!-----------------------------------close small container----------------------------------->
  </div>
  <!-------------footer----------------->
  <jsp:include page="WEB-INF/jspf/footer.jspf"/>
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
