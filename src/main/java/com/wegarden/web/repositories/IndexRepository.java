package com.wegarden.web.repositories;

import com.wegarden.web.model.CountTotalIncome;
import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;

import java.util.List;

public interface IndexRepository {
    Integer countOrder(String type);
    Integer countEmployee(String type);
    Integer countStock();
    Integer countRefrigerator();

    Double countTotalExpend();
    List<CountTotalIncome> countTotalIncome();
}
