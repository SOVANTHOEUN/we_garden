package com.wegarden.web.controller;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/stock")
public class StockController {
    @Autowired
    private StockService stockService;

    @RequestMapping("/select")
    public String home(){
        System.out.println("stock is called...");
        return "stock_view";
    }

    @RequestMapping("/get_stock_lists")
    @ResponseBody
    public Map<String, Object> getUsersList(@ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("PRO_UUID") String pro_uuid){
        Map<String, Object> response = new HashMap<>();
        String status       = "1"; // get from view soon
        List<Stock> userList = stockService.getStocksList(srch_wd, status, pro_uuid);

        response.put("DATA_REC", userList);
        return response;
    }

    @RequestMapping("/get_categorry_lists")
    @ResponseBody
    public Map<String, Object> getCategoryList(@ModelAttribute("STATUS") String status){
        Map<String, Object> response = new HashMap<>();

        List<Category> cateRec= stockService.getCategoryList(status);

        response.put("DATA_REC", cateRec);
        return response;
    }

    @RequestMapping("/save_pro_img")
    @ResponseBody
    public Map<String, Object> saveProductImage(@ModelAttribute("FILENAME") String filename, @ModelAttribute("EXTENSION") String extension){
        Map<String, Object> response = new HashMap<>();
        System.out.println("filename:: "+filename);
        System.out.println(extension);

         String imageUuid = stockService.saveProImg(filename, extension);
        return new HashMap<String, Object>(){
            {
                put("IMG_UUID", imageUuid);
//                put("EXTENSION",  objectMap.get("EXTENSION"));
            }
        };
    }

    @RequestMapping("/save_product_data")
    @ResponseBody
    public Map<String, Object> saveProductData(@ModelAttribute("PRO_NM") String proNm, @ModelAttribute("PRO_PRICE") Double proPrice,
                                               @ModelAttribute("CATE_UUID") String catUuid, @ModelAttribute("FILENAME") String filename,
                                               @ModelAttribute("EXTENSION") String extension){
        Map<String, Object> response = new HashMap<>();

        String imageUuid = stockService.saveProImg(filename, extension);
        String actionCode = stockService.saveProductData(proNm, proPrice, catUuid, imageUuid);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

    @RequestMapping("/update_product_data")
    @ResponseBody
    public Map<String, Object> updateProductData(@ModelAttribute("PRO_NM") String proNm, @ModelAttribute("PRO_PRICE") Double proPrice,
                                                 @ModelAttribute("PRO_UUID") String proUuid, @ModelAttribute("CATE_UUID") String catUuid,
                                                 @ModelAttribute("FILENAME") String filename, @ModelAttribute("EXTENSION") String extension){
        Map<String, Object> response = new HashMap<>();

        String imageUuid = stockService.saveProImg(filename, extension);
        String actionCode = stockService.updateProductData(proNm,proPrice,catUuid,imageUuid,proUuid);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

    @RequestMapping("/save_product_amount")
    @ResponseBody
    public Map<String, Object> saveProductAmount(@ModelAttribute("PRO_UUID") String proUuid, @ModelAttribute("QUANTITY") Integer quantity){
        Map<String, Object> response = new HashMap<>();

        String actionCode = stockService.saveProductAmt(proUuid, quantity);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

    @RequestMapping("/save_refrigerator_amount")
    @ResponseBody
    public Map<String, Object> saveRefrigeratorAmount(@ModelAttribute("PRO_UUID") String proUuid, @ModelAttribute("QUANTITY") Integer quantity){
        Map<String, Object> response = new HashMap<>();

        String actionCode = stockService.saveRefrigeratorAmt(proUuid, quantity);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }
}
