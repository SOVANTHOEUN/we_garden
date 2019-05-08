package com.wegarden.web.repositories;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.model.stock.StockReport;

import java.util.List;

public interface OrderRepository {
    List<Order> getOrderList();
    List<UserOrder> getUserOrderList(String userUuid);
    List<OrderDetail> getOrderDetailList(String orderUuid);
}
