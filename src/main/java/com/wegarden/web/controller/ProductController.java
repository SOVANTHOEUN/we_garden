package com.wegarden.web.controller;

import com.wegarden.web.model.stock.Category;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;

    @RequestMapping("/index")
    public String home(){
        System.out.println("product is called...");
        return "product_view";
    }

    @RequestMapping("/get_product_list")
    @ResponseBody
    public Map<String, Object> getProductList(@ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("PRO_UUID") String pro_uuid){
        Map<String, Object> response = new HashMap<>();
        String status       = "1"; // get from view soon
        List<Stock> userList = productService.getProductList(srch_wd, status, pro_uuid);

        response.put("DATA_REC", userList);
        return response;
    }

    @RequestMapping("/get_categorry_lists")
    @ResponseBody
    public Map<String, Object> getCategoryList(@ModelAttribute("STATUS") String status){
        Map<String, Object> response = new HashMap<>();

        List<Category> cateRec= productService.getCategoryList(status);

        response.put("DATA_REC", cateRec);
        return response;
    }

    @RequestMapping("/save_pro_img")
    @ResponseBody
    public Map<String, Object> saveProductImage(@ModelAttribute("FILENAME") String filename, @ModelAttribute("EXTENSION") String extension){
        Map<String, Object> response = new HashMap<>();

        String imageUuid = productService.saveProImg(filename, extension);
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
                                               @ModelAttribute("PRO_QTY_BOX") Integer proQtyBox, @ModelAttribute("CATE_UUID") String catUuid,
                                               @ModelAttribute("FILE_NAME") String filename, @ModelAttribute("EXTENSION") String extension,
                                               @ModelAttribute("IMG_UUID") String imgUuid){
        Map<String, Object> response = new HashMap<>();

        String imageUuid = productService.saveProImg(filename, extension);
        System.out.println("imageUuid:: "+imageUuid);
        System.out.println("imgUuid:: "+imgUuid);
        String actionCode = productService.saveProductData(proNm, proPrice, proQtyBox, catUuid, imageUuid);
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
                                                 @ModelAttribute("PRO_QTY_BOX") Integer proQtyBox,
                                                 @ModelAttribute("PRO_UUID") String proUuid, @ModelAttribute("CATE_UUID") String catUuid,
                                                 @ModelAttribute("FILE_NAME") String filename, @ModelAttribute("EXTENSION") String extension){
        Map<String, Object> response = new HashMap<>();

        String imageUuid = productService.saveProImg(filename, extension);
        String actionCode = productService.updateProductData(proNm, proPrice, proQtyBox, catUuid, imageUuid, proUuid);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

    @RequestMapping("/delete_product")
    @ResponseBody
    public Map<String, Object> deleteProduct(@ModelAttribute("PRO_UUID") String proUuid){
        Map<String, Object> response = new HashMap<>();

        String actionCode = productService.deleteProduct(proUuid);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }


}
