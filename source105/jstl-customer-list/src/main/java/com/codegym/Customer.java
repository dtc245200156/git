package com.codegym;

public class Customer {
    private final String name;
    private final String dateOfBirth;
    private final String address;
    private final String image;

    public Customer(String name, String dateOfBirth, String address, String image) {
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public String getImage() {
        return image;
    }
}