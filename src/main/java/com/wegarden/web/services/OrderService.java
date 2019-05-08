package com.wegarden.web.services;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.model.stock.StockReport;

import java.util.List;

public interface OrderService {
    List<Order> getOrderList();
    List<UserOrder> getUserOrderList(String userUuid);
}
