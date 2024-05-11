<%-- 
    Document   : Login
    Created on :
    Author     : Dewi 
--%>

<%@ page import="java.sql.*" %>
<%@ page import="user.projek.slempang.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        if (request.getParameter("btn_login") != null) {
            String username, password;
            username = request.getParameter("txt_username");
            password = request.getParameter("txt_password");

            DbConnection dbConn = new DbConnection();
            conn = dbConn.getConnection();

            String dbid, dbnama, dbusername, dbpassword;
            boolean adm = false;
            if (password.toLowerCase().startsWith("adm")) {
                adm = true;
                pstmt = conn.prepareStatement("SELECT * FROM admin "
                        + "WHERE username=? AND password=?");
            } else {
                pstmt = conn.prepareStatement("SELECT * FROM pembeli "
                        + "WHERE username=? AND password=?");
            }
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            try {
                if (rs.next()) {
                    String urlHome = "";
                    if (adm) {
                        dbid = rs.getString("id_admin");
                        dbnama = rs.getString("nama");
                        urlHome = "homeadmin.jsp";

                    } else {
                        dbid = rs.getString("id_pembeli");
                        dbnama = rs.getString("nama");
                        urlHome = "home.jsp";
                    }
                    dbusername = rs.getString("username");
                    dbpassword = rs.getString("password");

                    if (username.equals(dbusername) && 
                            password.equals(dbpassword)) {
                        session.setAttribute("id", dbid);
                        session.setAttribute("nama", dbnama);
                        response.sendRedirect(urlHome);
                    }
                } else {
                    request.setAttribute("errorMsg", "Username atau password invalid");
                }
            } finally {
                dbConn.close(conn); //close connection	
                dbConn.close(pstmt); //close preparedStatement	
                dbConn.close(rs); //close ResultSet
            }
        }
    } catch (Exception e) {
        out.println(e);
    }
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Login</title>

    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/login-register.css">

    <script>

        function validate()
        {
            var username = document.myform.txt_username;
            var password = document.myform.txt_password;

            if (username.value == null || username.value == "") //check username textbox not blank
            {
                window.alert("Isikan username ?"); //alert message
                username.style.background = '#f08080';
                username.focus();
                return false;
            }
            if (password.value == null || password.value == "") //check password textbox not blank
            {
                window.alert("please enter password ?"); //alert message
                password.style.background = '#f08080';
                password.focus();
                return false;
            }
        }

    </script>

  </head>
  <body>

    <div class="main-content">
      <form class="form-register" method="post" name="myform" onsubmit="return validate();">
        <div class="form-register-with-email">
          <div class="form-white-background">

            <div class="form-title-row">
              <h1>Login</h1>
            </div>

            <p style="color:red">				   		
              <%
                  if (request.getAttribute("errorMsg") != null) {
                      out.println(request.getAttribute("errorMsg")); //error message for email or password 
                  }
              %>
            </p>
            </br>
            <div class="form-row">
              <label>
                <span>Username</span>
                <input type="text" name="txt_username" id="username" placeholder="enter username">
              </label>
            </div>

            <div class="form-row">
              <label>
                <span>Password</span>
                <input type="password" name="txt_password" id="password" placeholder="enter password">
              </label>
            </div>

            <input type="submit" name="btn_login" value="Login">
          </div><!-------- Close Div White Bg ---------->
          <a href="daftar.jsp" class="form-log-in-with-existing">Belum memiliki akun? <b> Daftar disini </b></a>
        </div> <!--------- Close Form Register------------>
      </form>
    </div><!------ Close Div Main Content -------------->

  </body>

</html>
