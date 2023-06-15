package com.model;

/**
 *
 * @author FarisHarr
 */

public class Product {
    private int id;
    private String image;
    private String title;
    private double price;

    public Product(int id, String image, String title, double price) {
        this.id = id;
        this.image = image;
        this.title = title;
        this.price = price;
    }

    // Getters and setters for the private fields

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}

