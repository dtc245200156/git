package com.codegym.service;

import com.codegym.model.Customer;
import java.util.List;

/**
 * Interface định nghĩa hợp đồng cho tầng Service quản lý khách hàng.
 */
public interface CustomerService {
    List<Customer> findAll();
    void save(Customer customer);
    Customer findById(int id);
    void update(int id, Customer customer);
    void remove(int id);
}