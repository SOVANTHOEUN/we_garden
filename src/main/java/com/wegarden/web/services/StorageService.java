package com.wegarden.web.services;

import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface StorageService {
    public Map<String,Object> store(MultipartFile file, String name);
}
