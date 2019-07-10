package com.wegarden.web.repositories;


import com.wegarden.web.model.user.BronzeMasterUsage;

import java.util.List;

public interface BronzeMasterRepository {
    List<BronzeMasterUsage> getListReportBronzeMasterUsage(String sDate);
}
