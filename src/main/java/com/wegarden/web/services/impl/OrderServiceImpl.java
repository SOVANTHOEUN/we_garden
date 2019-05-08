package com.wegarden.web.services.impl;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.model.stock.StockReport;
import com.wegarden.web.repositories.OrderRepository;
import com.wegarden.web.repositories.StockRepository;
import com.wegarden.web.services.OrderService;
import com.wegarden.web.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public List<Order> getOrderList() {
        return orderRepository.getOrderList();
    }

    @Override
    public List<UserOrder> getUserOrderList(String userUuid) {
        return orderRepository.getUserOrderList(userUuid);
    }
}
