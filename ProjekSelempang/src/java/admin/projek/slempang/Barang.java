package admin.projek.slempang;

/**
 *
 * @author Lonely
 */
public class Barang {

    private String id_barang;
    private String nama;
    private String image;
    private double harga;
    
    public Barang(String id_barang, String nama, String image, double harga) {
       this.id_barang = id_barang;
       this.nama = nama;
       this.image = image;
       this.harga = harga;
    }
    
    
    public Barang(String id_barang, String image){
        this.id_barang = id_barang;
        this.image = image;
    }

    public String getId_barang() {
        return id_barang;
    }

    public void setId_barang(String id_barang) {
        this.id_barang = id_barang;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getHarga() {
        return harga;
    }

    public void setHarga(double harga) {
        this.harga = harga;
    }

    
}