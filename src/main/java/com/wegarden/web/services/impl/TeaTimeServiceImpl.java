package com.wegarden.web.services.impl;

import com.wegarden.web.model.order.TeaTimeUsage;
import com.wegarden.web.repositories.TeaTimeRepository;
import com.wegarden.web.services.TeaTimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeaTimeServiceImpl implements TeaTimeService {

    @Autowired
    private TeaTimeRepository teaTimeRepository;

    @Override
    public List<TeaTimeUsage> getListReportTeaTimeUsage(String month, String year) {
        return teaTimeRepository.getListReportTeaTimeUsage(month, year);
    }
}
