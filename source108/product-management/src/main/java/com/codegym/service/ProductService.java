package com.codegym.service;

import com.codegym.model.Product;
import java.util.List;

public interface ProductService {
    List<Product> findAll();
    List<Product> searchByName(String name);
    Product findById(int id);
    void save(Product product);
    void update(int id, Product product);
    void remove(int id);
}