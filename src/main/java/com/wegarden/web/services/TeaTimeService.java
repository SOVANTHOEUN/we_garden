package com.wegarden.web.services;

import com.wegarden.web.model.order.TeaTimeUsage;

import java.util.List;

public interface TeaTimeService {
    List<TeaTimeUsage> getListReportTeaTimeUsage(String month, String year);
}
