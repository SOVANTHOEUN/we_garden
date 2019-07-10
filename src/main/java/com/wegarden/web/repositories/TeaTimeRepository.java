package com.wegarden.web.repositories;


import com.wegarden.web.model.order.TeaTimeUsage;

import java.util.List;

public interface TeaTimeRepository {
    List<TeaTimeUsage> getListReportTeaTimeUsage(String month, String year);
//    List<> getListReportTeaTimeUsage(String month, String year);
}
