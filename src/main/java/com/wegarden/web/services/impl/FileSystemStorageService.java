package com.wegarden.web.services.impl;

import com.sun.javafx.iio.ImageStorageException;
import com.wegarden.web.model.StorageProperties;
import com.wegarden.web.services.StorageException;
import com.wegarden.web.services.StorageService;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class FileSystemStorageService implements StorageService {
    private final Path rootLocation = Paths.get("src/main/resources/static/images");

    @Override
    public Map<String, Object> store(MultipartFile file, String fileName) {
        try {
            if (file.isEmpty()) {
                throw new StorageException("Failed to store empty file " + file.getOriginalFilename());
            }

            // create new File objects
//            String tempDirPath = this.rootLocation.toString();
//            String tempPath = tempDirPath + File.separator + fileName;

            String getName       = file.getOriginalFilename().replaceFirst("[.][^.]+$", "");
            String fileNmDate   = getName+"_"+DateFormatUtils.format(new Date(), "yyyyMMddss");
            String fileExe           = "."+FilenameUtils.getExtension(file.getOriginalFilename());

            Files.copy(file.getInputStream(),this.rootLocation.resolve(fileNmDate+fileExe));
//            FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(tempPath));
            return new HashMap<String, Object>(){
                {
                    put("FILENAME",   fileNmDate);
                    put("EXTENSION", fileExe);
                }
            };

        } catch (IOException e) {
            throw new StorageException("Failed to store file " + file.getOriginalFilename(), e);
        }
    }

}
