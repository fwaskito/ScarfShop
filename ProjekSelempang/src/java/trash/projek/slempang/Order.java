/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trash.projek.slempang;

import trash.projek.slempang.Troli;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "Order", urlPatterns = {"/Order"})
public class Order extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Troli troli = (Troli) session.getAttribute("troli");

        // Update
        String upd = request.getParameter("upadate");
        if (upd != null) {
            Enumeration keys = request.getParameterNames();
            while (keys.hasMoreElements()) {
                String key = (String) keys.nextElement();
                // Ambil jumlah item
                if (key.startsWith("jum")) {
                    String item = key.substring(3);
                    String sjum = request.getParameter(key);
                    if (sjum != null) {
                        int jum = 1;
                        try {
                            jum = Integer.parseInt(sjum);
                        } catch (NumberFormatException nfe) {
                        }
                        // Update jumlah item
                        troli.addItem(item, jum);
                    }
                }
            }
        }

        // Deelte
        String del = request.getParameter("del");
        if (del != null) {
            troli.delItem(del);
        }

        // Ambil String HTML
        String strOrder = "Troli Kosong.";
        if (troli != null) {
            strOrder = troli.getAllItem(response);
        }

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Url-rewriting
        String urlHome = response.encodeURL("home.jsp");
        String urlOrder = response.encodeURL("Order");
/*
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Order Servlet</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Ini masuk Kok</h1>");
        out.println("<<h2>Tuh masuk kok. Semangat!!!</h2>");
        out.println("</body>");
        out.println("</html>");*/
        // Output page
        out.println("<html><head>"
                + "<title>Order</title></head>"
                + "<body>"
                + "<img alt='banner' src='gambar/logo/logo-4.png' width='200px'>"
                + "<font style='font-familiy:Arial; font-size:12pt'>"
                + "<p><a href='" + urlHome + "'>HOME</a>&nbsp;&nbsp;"
                + "</p></font>"
                + "<font style='font-family: Arial; font-size:16pt'"
                + "<p style='background-color: #B8EACF'>"
                + "Order:</p></font>"
                + "<form action='" + urlOrder + "' method='POST'>"
                + "<table border='1' cellspacing='0' "
                + "cellpadding='4'>" + strOrder+"</table></form>"
                + "<form action=' method ='POST'"
                + "target='_blank'><p align='right'>"
                + "<input type='submit' value='checkout'/></p>"
                + "</table></form>");
        
        out.close();

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Order Selempang Servlet";
    }// </editor-fold>

}
