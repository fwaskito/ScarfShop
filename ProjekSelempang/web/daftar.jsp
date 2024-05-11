<%-- 
    Document   : daftar
    Created on : 
    Author     : Dewi
--%>

<%@ page import="java.sql.*" %>  
<%@page import="user.projek.slempang.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    DbConnection dbConn = new DbConnection();
    try {
        conn = dbConn.getConnection();
        if (request.getParameter("btn_register") != null) {
            String nama, email, alamat, noTelpon, username, password;

            nama = request.getParameter("txt_nama");
            email = request.getParameter("txt_email");
            alamat = request.getParameter("txt_alamat");
            noTelpon = request.getParameter("txt_noTelpon");
            username = request.getParameter("txt_username");
            password = request.getParameter("txt_password");

            pstmt = conn.prepareStatement("insert into pembeli(nama,email,alamat,no_Telpon,username,password) values(?,?,?,?,?,?)"); //sql insert query
            pstmt.setString(1, nama);
            pstmt.setString(2, email);
            pstmt.setString(3, alamat);
            pstmt.setString(4, noTelpon);
            pstmt.setString(5, username);
            pstmt.setString(6, password);
            pstmt.executeUpdate();

            request.setAttribute("successMsg", "Pendaftaran Berhasil! Silahkan  login"); //register success messeage

        }
    } catch (Exception e) {
        out.println(e);
    } finally {
        dbConn.close(pstmt);
        dbConn.close(conn);
    }
%>  
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/login-register.css">
    <!--------------------------- js untuk validasi pendftaran-------------------------------->
    <script>

        function validate()
        {
            var nama = /^[a-z A-Z]+$/; //pattern allowed alphabet a-z or A-Z 
            var email_valid = /^[\w\d\.]+\@[a-zA-Z\.]+\.[A-Za-z]{1,4}$/; //pattern valid email validation
            var password_valid = /^[A-Z a-z 0-9 !@#$%&*()<>]{6,12}$/; //pattern password allowed A to Z, a to z, 0-9, !@#$%&*()<> charecter 

            var nama = document.getElementById("nama"); //textbox id fname
            var email = document.getElementById("email"); //textbox id lname
            var alamat = document.getElementById("alamat"); //textbox id email
            var noTelpon = document.getElementById("username"); //textbox id email
            var username = document.getElementById("username"); //textbox id email
            var password = document.getElementById("password"); //textbox id password

            if (!nama.test(nama.value) || nama.value == '')
            {
                alert("Masukan Nama Lengkap!!");
                nama.focus();
                nama.style.background = '#f08080';
                return false;
            }
            if (!email_valid.test(email.value) || email.value == '')
            {
                alert("Masukan email dengan benar!");
                email.focus();
                email.style.background = '#f08080';
                return false;
            }
            if (!alamat.test(alamat.value) || alamat.value == '')
            {
                alert("Mauskan Alamat!");
                alamat.focus();
                alamat.style.background = '#f08080';
                return false;
            }
            if (!noTelpon.test(noTelpon.value) || noTelpon.value == '')
            {
                alert("Enter Lastname Alphabet Only....!");
                noTelpon.focus();
                noTelpon.style.background = '#f08080';
                return false;
            }
            if (!username.test(username.value) || username.value == '')
            {
                alert("Masukan Username!");
                username.focus();
                username.style.background = '#f08080';
                return false;
            }
            if (!password_valid.test(password.value) || password.value == '')
            {
                alert("Password Must Be 6 to 12 and allowed !@#$%&*()<> character");
                password.focus();
                password.style.background = '#f08080';
                return false;
            }
        }
    </script>	
  </head>
  <body>
    <div class="main-content">
      <form class="form-register" method="post" onsubmit="return validate();">
        <div class="form-register-with-email">
          <div class="form-white-background">
              <h1>Daftar</h1>
            <p style="color:green">				   		
              <%
                  if (request.getAttribute("successMsg") != null) {
                      out.println(request.getAttribute("successMsg")); //register success message
                  }
              %>
            </p>
            <div class="form-row">
              <label>
                <span>Nama</span>
                <input type="text" name="txt_nama" id="fname" placeholder="enter nama">
              </label>
            </div>
            <div class="form-row">
              <label>
                <span>Email</span>
                <input type="text" name="txt_email" id="lname" placeholder="enter email">
              </label>
            </div>

            <div class="form-row">
              <label>
                <span>Alamat</span>
                <input type="text" name="txt_alamat" id="email" placeholder="enter alamat">
              </label>
            </div>

            <div class="form-row">
              <label>
                <span>No Telpon</span>
                <input type="text" name="txt_noTelpon" id="email" placeholder="enter nomor telpon">
              </label>
            </div>

            <div class="form-row">
              <label>
                <span>Username</span>
                <input type="text" name="txt_username" id="email" placeholder="enter username">
              </label>
            </div>

            <div class="form-row">
              <label>
                <span>Password</span>
                <input type="password" name="txt_password" id="password" placeholder="enter password">
              </label>
            </div>

            <input type="submit" name="btn_register" value="Register">

          </div>
          <a href="Login.jsp" class="form-log-in-with-existing">Sudah punya akun? <b> Login disini </b></a>
        </div>
      </form>
    </div>
  </body>
</html>
