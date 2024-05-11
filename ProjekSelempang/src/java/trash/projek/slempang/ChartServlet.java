/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trash.projek.slempang;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
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
@WebServlet(name = "ChartServlet", urlPatterns = {"/ChartServlet"})
public class ChartServlet extends HttpServlet {

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
        ChartUser cu = null;
        if (session != null) {
            cu = (ChartUser) session.getAttribute("chart_user");
        }

        Map<Object, Object> items = new HashMap();
        Map<Object, Object> detailItem = null;
        double total = 0.0;

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Chart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h2>Chart</h2>");
            out.println("<table border='1' cellspacing='4' cellpadding='4'>");
            out.println("<tr>");
            out.println("<th>Nama Barang</th><th>Harga</th><th>Jumlah</th><th>Sub total</th>");
            out.println("</tr>");
            if (cu != null) {
                items = cu.getAllItem();
                Iterator iterator = items.entrySet().iterator();
                while (iterator.hasNext()) {
                    out.println("<tr>");
                    detailItem = new HashMap();
                    Map.Entry<Object, Object> entry = (Map.Entry) iterator.next();
                    String id_barang = (String) entry.getKey();
                    detailItem = (HashMap) items.get(id_barang);

                    String nama = (String) detailItem.get("nama");
                    double harga = (double) detailItem.get("harga");
                    int jumlah = (int) detailItem.get("harga");
                    double subtotal = (double) detailItem.get("subtotal");
                    total += subtotal;

                    out.println("<td>" + nama + "</td>");
                    out.println("<td>" + harga + "</td>");
                    out.println("<td>" + jumlah + "</td>");
                    out.println("<td>" + subtotal + "</td>");
                    out.println("</tr>");
                }
            }
            out.println("<tr>");
            out.println("<td></td>");
            out.println("<td></td>");
            out.println("<td>Total</td>");
            out.println("<td>"+total+"</td>");
            out.println("</tr>");
            out.println("<table>");
            out.println("</body>");
            out.println("</html>");
        }
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
        return "Short description";
    }// </editor-fold>

}
