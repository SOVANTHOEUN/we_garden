package com.wegarden.web.services.impl;
import com.wegarden.web.model.stock.Refrigerator;
import com.wegarden.web.repositories.RefrigeratorRepository;
import com.wegarden.web.services.RefrigeratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RefrigeratorServiceImpl implements RefrigeratorService {

    @Autowired
    private RefrigeratorRepository refrigeratorRepository;

    @Override
    public List<Refrigerator> getRefrigeratorList(String srch_wd, String status, String pro_uuid) {
        return refrigeratorRepository.getRefrigeratorList(srch_wd, status, pro_uuid);
    }

    @Override
    public String saveQty(String proUuid, Integer quantity) {
        return refrigeratorRepository.saveQty(proUuid,quantity);
    }

    /*@Override
    public List<Refrigerator> getReportRefrigerator(String sDate, String eDate) {
        return refrigeratorRepository.getReportRefrigerator(sDate,eDate);
    }*/

}
