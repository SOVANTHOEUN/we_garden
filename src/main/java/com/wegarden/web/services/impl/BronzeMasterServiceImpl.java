package com.wegarden.web.services.impl;

import com.wegarden.web.model.user.BronzeMasterUsage;
import com.wegarden.web.repositories.BronzeMasterRepository;
import com.wegarden.web.services.BronzeMasterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BronzeMasterServiceImpl implements BronzeMasterService {

    @Autowired
    private BronzeMasterRepository bronzeMasterRepository;

    @Override
    public List<BronzeMasterUsage> getListReportBronzeMasterUsage(String sDate) {
        return bronzeMasterRepository.getListReportBronzeMasterUsage(sDate);
    }
}
