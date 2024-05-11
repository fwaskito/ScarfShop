package user.projek.slempang;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Fajar W.
 */
public class DbConnection {

    protected String username = "waskito";
    protected String password = "admwaskito";

    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            /*String host = this.host;
            String port = this.port;
            String dbName = this.dbName;
            String username = this.username;
            String password = this.username;
            String param = this.param;*/

            String url = "jdbc:mysql://localhost:3306/projek_selempang?autoReconnect=true&useSSL=false";
            conn = DriverManager.getConnection(url, username, password);

        } catch (ClassNotFoundException e) {
        } catch (SQLException ex) {
        }
        return conn;
    }

    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException se) {
            }
        }
    }

    /**
     * Close a prepared statement
     * @param pstmt
     */
    public static void close(PreparedStatement pstmt) {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException se) {
            }
        }
    }

    /**
     * Close a statement
     * @param stmt
     */
    public static void close(Statement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException se) {
            }
        }
    }

    /**
     * Close a result-set
     * @param rs
     */
    public static void close(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException se) {
            }
        }
    }

    public static void main(String[] args) {
      System.out.println("\n****mySQL JDBC Connection Testing ***");
      Connection conn = null;
      try{
         Class.forName("com.mysql.cj.jdbc.Driver");
            String username = "waskito";
            String password = "admwaskito";
            String url = "jdbc:mysql://localhost:3306/projek_selempang?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("\nDatabase connection established...");
      }catch(Exception ex){
         System.out.println("Cannot connect to database server.");
         ex.printStackTrace();
      }
    }
}
