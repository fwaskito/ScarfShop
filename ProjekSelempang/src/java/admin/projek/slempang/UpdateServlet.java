/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin.projek.slempang;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lonely
 */
@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String id_barang = request.getParameter("id_barang");
        String nama = request.getParameter("nama");
        String image = request.getParameter("image");
        double harga = Double.parseDouble(request.getParameter("harga"));

        Barang sp = new Barang(id_barang, nama, image, harga);
        BarangControll br = new BarangControll();
        try {
            if (br.updateOld(sp, id)) {
                String urlResponse = "update.jsp?id="+id_barang;
                urlResponse = response.encodeRedirectURL(urlResponse);
                response.sendRedirect(urlResponse);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
