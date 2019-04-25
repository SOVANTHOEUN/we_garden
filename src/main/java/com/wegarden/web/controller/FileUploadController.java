package com.wegarden.web.controller;

import com.wegarden.web.services.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/image")
public class FileUploadController {

    @Autowired
    private StorageService storageService;

    @RequestMapping(value = "/uploadimg", method = RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String,Object> upload(MultipartHttpServletRequest request, HttpServletResponse response) throws IOException {
        //0. notice, we have used MultipartHttpServletRequest
        //1. get the files from the request object

        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf   = request.getFile(itr.next());
        String fileName      = request.getFileNames().toString();
        Map<String,Object> objectMap =  storageService.store(mpf, fileName);

        //2. send it back to the client as <img> that calls get method
        //we are using getTimeInMillis to avoid server cached image
        return new HashMap<String, Object>(){
            {
                put("FILENAME", objectMap.get("FILENAME"));
                put("EXTENSION",  objectMap.get("EXTENSION"));
            }
        };
    }
}
