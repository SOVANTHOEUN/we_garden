package com.wegarden.web.services;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;

import java.util.List;

public interface IndexService {
    Integer countOrder(String type);
    Integer countEmployee(String type);
    Integer countStock();
    Integer countRefrigerator();
}
