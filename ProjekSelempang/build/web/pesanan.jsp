<%-- 
    Document   : pesanan
    Created on : Dec 16, 2020, 2:20:02 AM
    Author     : Fajar W
--%>

<%@page import="admin.projek.slempang.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pesanan - Admin</title>
    <link rel="stylesheet" type="text/css" href="css/stylepesanan.css">
    <link link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" 
          rel="stylesheet"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body>
    <!------------------------- header---------------------------->
   <jsp:include page="WEB-INF/jspf/headerAdmin.jspf" />
    <!--------------------header close---------------------------->
    <!--------------------samll container----------------------->
    <div class="small-container">
      <!-------------------sorting---------------------------->
      <div class="row">
        <h1 align="center">Semua Pesanan Produk</h1>
      </div>
      <br><br><br>
      <!-------------------sorting close---------------------->
      <% ArrayList<Pesanan> lst = new PesananControll().getAllPesanan(); %>

      <%
          String sorting = "";
          if (request.getParameter("sorting") != null)
                    sorting = (String) request.getParameter("sorting");
          
          int temp = 0;
          boolean row = true;
          
          for (Pesanan psn : lst) {
              String id_order = psn.getId_order();
              String id_pembeli = psn.getId_pembeli();
              String id_barang = psn.getId_barang();
              String tanggal = psn.getTanggal();
              int jumlah = psn.getJumlah();
              double total_biaya = psn.getTotal_biaya();

              String deleteURL = "DeleteServletPsn?id=" + id_order;
              if (row) {
                  row = false;

      %>
      <div class="row">
        <%              }
            if (temp <= 5) {
               
        %>

        <div class="col-4">
          <h4>[<b>ID order</b>: <%=id_order%>]</h4>
          <h4>[<b>ID pembeli</b>: <%=id_pembeli%>]</h4>
          <h4>[<b>ID barang</b>: <%=id_barang%>]</h4>
          <p>-Tgl & waktu Pesan :</p>
          <p>&nbsp;&nbsp;&nbsp;<%=tanggal%></p>
          <p>-Jumlah  Pesan     : <%=jumlah%></p><hr>
          <p>-<b>Total Biaya</b>:</p>
          <p>&nbsp;&nbsp;&nbsp;Rp<%=total_biaya%></p><hr>
          <h4 class="delete"><b><i><a href="<%=deleteURL%>">Delete</a></i></b></h4>
        </div>
        <%
            } else {
                temp = 0;
                row = true;
            }

            if (row) {
        %>
        <!-- </table>--->
      </div>
      <%
              }
          }
      %>

      <br><br><br>
  </div>
      </div>
  <!----------------==========---close small container--------------------------->
  <!-------------footer----------------->
  <jsp:include page="WEB-INF/jspf/footer.jspf"/>
  <!-----------close footer-------------->

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