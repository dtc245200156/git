package com.codegym.service;

import com.codegym.model.Product;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductServiceImpl implements ProductService {
    private static final Map<Integer, Product> products = new HashMap<>();

    static {
        products.put(1, new Product(1, "iPhone 16", 22990000, "Điện thoại thông minh.", "Apple"));
        products.put(2, new Product(2, "Galaxy S25", 19990000, "Điện thoại Android cao cấp.", "Samsung"));
        products.put(3, new Product(3, "MacBook Air M4", 28990000, "Laptop mỏng nhẹ.", "Apple"));
        products.put(4, new Product(4, "ThinkPad E14", 17990000, "Laptop doanh nghiệp.", "Lenovo"));
        products.put(5, new Product(5, "XPS 13", 31990000, "Laptop cao cấp.", "Dell"));
    }

    public List<Product> findAll() {
        return new ArrayList<>(products.values());
    }

    public List<Product> searchByName(String name) {
        if (name == null || name.trim().isEmpty()) return findAll();
        String keyword = name.trim().toLowerCase();
        List<Product> result = new ArrayList<>();
        for (Product product : products.values()) {
            if (product.getName().toLowerCase().contains(keyword)) result.add(product);
        }
        return result;
    }

    public Product findById(int id) { return products.get(id); }
    public void save(Product product) { products.put(product.getId(), product); }

    public void update(int id, Product product) {
        product.setId(id);
        products.put(id, product);
    }

    public void remove(int id) { products.remove(id); }
}