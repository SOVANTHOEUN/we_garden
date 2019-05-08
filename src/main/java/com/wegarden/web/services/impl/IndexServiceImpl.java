package com.wegarden.web.services.impl;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.repositories.IndexRepository;
import com.wegarden.web.repositories.OrderRepository;
import com.wegarden.web.services.IndexService;
import com.wegarden.web.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IndexServiceImpl implements IndexService {

    @Autowired
    private IndexRepository indexRepository;

    @Override
    public Integer countOrder(String type) {
        return indexRepository.countOrder(type);
    }

    @Override
    public Integer countEmployee(String type) {
        return indexRepository.countEmployee(type);

    }

    @Override
    public Integer countStock() {
        return indexRepository.countStock();

    }

    @Override
    public Integer countRefrigerator() {
        return indexRepository.countRefrigerator();

    }
}
