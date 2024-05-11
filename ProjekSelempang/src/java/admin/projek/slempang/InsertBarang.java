/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin.projek.slempang;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import trash.projek.slempang.ControllerBuraMobil;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "InsertBarang", urlPatterns = {"/InsertBarang"})
public class InsertBarang extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        ControllerBuraMobil ctr = null;
        Barang br = null;
        String id_barang = "";
        String nama = "";
        String image = "";
        double harga = 0.0;

        if (request.getParameter("submit-insert") != null) {
            id_barang = request.getParameter("id_barang");
            nama = request.getParameter("nama");
            image = "kosong";
            harga = Double.parseDouble(request.getParameter("harga"));
            br = new Barang(id_barang, nama, image, harga);
            ctr = new ControllerBuraMobil();

            try {
                if (ctr.addProduk(br)) {
                    String urlRespon = "insert.jsp";
                    response.sendRedirect(urlRespon);
                } else {
                    String urlFailed = "error.jsp";
                    response.sendRedirect("error.jsp");
                }
            } catch (Exception e) {
                System.out.println("Kesalahan: " + e);
            }
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
