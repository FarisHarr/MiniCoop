package com.model;

/**
 *
 * @author FarisHarr
 */

public class Product {

    private int id;
    private byte[] image; // Change the type to byte[] for BLOB
    private String title;
    private double price;

    public Product(int id, byte[] image, String title, double price) {
        this.id = id;
        this.image = image;
        this.title = title;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public byte[] getImage() {
        return image;
    }

    public String getTitle() {
        return title;
    }

    public double getPrice() {
        return price;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    

}

