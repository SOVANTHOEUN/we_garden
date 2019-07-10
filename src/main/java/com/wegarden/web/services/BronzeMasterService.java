package com.wegarden.web.services;

import com.wegarden.web.model.user.BronzeMasterUsage;

import java.util.List;

public interface BronzeMasterService {
    List<BronzeMasterUsage> getListReportBronzeMasterUsage(String sDate);
}
