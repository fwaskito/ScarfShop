/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin.projek.slempang;

import com.oreilly.servlet.MultipartRequest;
import control.projek.slempang.Controller;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Fajar W
 */
@WebServlet(name = "UploadGambar", urlPatterns = {"/UploadGambar"})
public class UploadGambar extends HttpServlet {

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
        response.setContentType("text/html; charset=UTF-8");
        String id_barang = "";
        if (request.getParameter("id_barang") != null) {
            id_barang = (String) request.getParameter("id_barang");
        }
       
        String tempatUpload = 
                "C:\\Users\\Lenovo\\Documents\\NetBeansProjects\\PBP\\Projek Selempang\\web\\gambar\\produk";
        MultipartRequest mr = 
                new MultipartRequest(request, tempatUpload, 10000000);

        Enumeration en = mr.getFileNames();
        String kd = (String) en.nextElement();

        String image = mr.getFilesystemName(kd);
        //File file = mr.getFile(kd);

        Controller ctr = new Controller();
        boolean r = ctr.addGambar(image, id_barang);
        
        String urlResponse = "";
        String hasilUploadGambar = "";
        if(r){
            hasilUploadGambar = "berhasil";
            urlResponse = "insert.jsp?id_barang="+id_barang+"&hasilUploadGambar="+hasilUploadGambar+"&path="+image;
        }else{
            hasilUploadGambar = "gagal";
            urlResponse = "insert.jsp?id_barang="+id_barang+"%hasilUploadGambar="+hasilUploadGambar;
        }     
        urlResponse = response.encodeRedirectURL(urlResponse);
        response.sendRedirect(urlResponse);
//        try {
//            if (r) {
//                String urlResponse = "testupload.jsp?path=gambar/" + image;
//                urlResponse = response.encodeRedirectURL(urlResponse);
//                response.sendRedirect(urlResponse);
//            } else {
//                response.sendRedirect("testupload.jsp");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
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
