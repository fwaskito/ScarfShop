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
    <title>Upload Produk - Admin</title>
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
      <h1>Upload Produk Baru</h1>
      <br>
    </div>
    <div class="row">
      <%
          String id_barang = "";
          String nama = "";
          String gambar = "";
          String harga = "";

          if (request.getParameter("save") != null) {
              id_barang = request.getParameter("id_barang");
              Connection conn = null;
              PreparedStatement pstmt = null;
              ResultSet rs = null;
              DbConnection dbConn = new DbConnection();

              try {
                  conn = dbConn.getConnection();
                  pstmt = conn.prepareStatement("SELECT * FROM barang WHERE id_barang=?");
                  pstmt.setString(1, id_barang);
                  rs = pstmt.executeQuery();

                  while (rs.next()) {
                      nama = rs.getString("nama");
                      gambar = rs.getString("image");
                      harga = String.valueOf(rs.getDouble("harga"));
                  }

              } catch (SQLException sqle) {
              } finally {
                  dbConn.close(rs);
                  dbConn.close(pstmt);
                  dbConn.close(conn);
              }
          }
      %>
      <div class="col-2">
        <img src="gambar/produk/<%=gambar%>" width="100%">
      </div>

      <div class="col-2">
        <br><br>
        <p>Home / Upload Produk</p><br>
        <h4><b>ID</b>    : <%=id_barang%></h4>
        <h4><b>Nama</b>  : <%=nama%></h4>
        <h4><b>Gambar</b>: <%=gambar%></h4>

        <%
            id_barang = request.getParameter("id_barang");
            if (!harga.equalsIgnoreCase("")) {
                FormatIdn fidn = new FormatIdn();
        %>
        <h4><b>Harga</b> : <%=fidn.formatter(Double.parseDouble(harga))%></h4><br><br>
        <%
        } else {
        %>
        <h4><b>Harga</b> : <%=harga%></h4><br><br>
        <%
            }
            nama = "";
            harga = "";
            if (request.getParameter("submit-insert") != null) {
                nama = request.getParameter("nama");
                harga = request.getParameter("harga");
                gambar = "";

                Barang br = new Barang(id_barang, nama, gambar, Double.parseDouble(harga));
                Controller ctr = new Controller();
                boolean r = ctr.addProduk(br);
                if (r) {
                    String urlUploadGambar = "UploadGambar?id_barang=" + id_barang;
                    urlUploadGambar = response.encodeURL(urlUploadGambar);
        %>
        <br>
        <br>
        <form action="<%=urlUploadGambar%>" method="POST" enctype="MULTIPART/FORM-DATA">
          <h3>Unggah Gambar Produk</h3>
          <table>
            <tr>
              <td>Open File </td>
              <td><input type="FILE" name="gambar"></td>
            </tr>
            <tr>
              <td colspan="2" align="center">
                <button class="btn" type="submit" name="submit-gambar">Upload</button>
              </td>
            </tr>
          </table>
        </form>
          <br><br><br><br><br><br><br>
        <%
        } else {
        %>
        <span style="color: red">Data barang gagal ditambahkan!</span>
        <br>
        <form action="insert.jsp" method="POST">   
          <h3>Masukkan Data Produk</h3>
          <table>
            <tr>
              <td>ID Produk</td>
              <td><input type="text" name="id_barang" placeholder="Masukkan Id"></td>
            </tr>
            <tr>
              <td>Nama Produk</td>
              <td><input type="text" name="nama" value="" placeholder="Masukka Nama"></td>
            </tr>
            <tr>
              <td>Harga</td>
              <td><input type="text" name="harga" value="" placeholder="Masukka Harga"></td>
            </tr>
            <tr>
              <td colspan="2" align="right">
                <button class="btn" type="submit" name="submit-insert" value="Upload">Upload</button>
                <button class="btn" type="reset" name="reset">Reset</button>
              </td>
            </tr>
          </table>
        </form>
        <br><br><br><br><br>
        <%
            }
        } else if (request.getParameter("hasilUploadGambar") != null) {
            String hasilUploadGambar = request.getParameter("hasilUploadGambar");

            if (hasilUploadGambar.equalsIgnoreCase("berhasil")) {
                String urlSave;
                urlSave = "insert.jsp?id_barang=" + id_barang + "&save=yes";
                urlSave = response.encodeURL(urlSave);
        %>
        <span style="color: green">Semua data produk berhasil diunggah.</span>
        <br><br>
        <a href="<%=urlSave%>" class="btn">Save</a>
        <br><br><br><br><br>
        <%
        } else {
            String urlUploadGambar = "UploadGambar?id_barang=" + id_barang;
            urlUploadGambar = response.encodeURL(urlUploadGambar);
        %>
        <span style="color: red">Gambar produk gagal diunggah! </span>
        <br>
        <form action="<%=urlUploadGambar%>" method="POST" enctype="MULTIPART/FORM-DATA">
          <h3>Unggah Gambar Produk</h3>
          <table>
            <tr>
              <td>Open File </td>
              <td><input type="FILE" name="gambar"></td>
            </tr>
            <tr>
              <td colspan="2" align="center">
                <button class="btn" type="submit" name="submit-gambar">Upload</button>
              </td>
            </tr>
          </table>
        </form>
          <br><br><br><br><br><br><br>
        <%
            }
        } else if (request.getParameter("save") != null) {
        %>
        <span><b>Data produk berhasil disimpan.</b></span>
        <br><br>
        <a href="homeadmin.jsp" class="btn">Kembali ke Home</a>
        <br><br><br>
        <%
        } else {
        %>
        <form action="insert.jsp" method="POST">   
          <h3>Masukkan Data Produk</h3>
          <table>
            <tr>
              <td>ID Produk</td>
              <td><input type="text" name="id_barang" placeholder="Masukkan Id"></td>
            </tr>
            <tr>
              <td>Nama Produk</td>
              <td><input type="text" name="nama" value="" placeholder="Masukka Nama"></td>
            </tr>
            <tr>
              <td>Harga</td>
              <td><input type="text" name="harga" value="" placeholder="Masukka Harga"></td>
            </tr>
            <tr>
              <td colspan="2" align="right">
                <button class="btn" type="submit" name="submit-insert" value="Upload">Upload</button>
                <button class="btn" type="reset" name="reset">Reset</button>
              </td>
            </tr>
          </table>
        </form>
        <br><br><br><br><br>
        <%
            }
        %>

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
