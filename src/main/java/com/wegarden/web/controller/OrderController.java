package com.wegarden.web.controller;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.util.ExcelGenerator;
import com.wegarden.web.model.stock.StockReportOut;
import com.wegarden.web.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/order")
@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;
    String startDate;
    String endDate;

    @RequestMapping("/select")
    public String home(){
        return "order_view";
    }

    @RequestMapping(value = "/get_order_list", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getOrderList(){
        Map<String, Object> response = new HashMap<>();

        List<Order> orderList = orderService.getOrderList();
        response.put("DATA_REC", orderList);
        return response;
    }

    @RequestMapping("/user_order")
    @ResponseBody
    public Map<String, Object> getUserOrderList(@ModelAttribute("USER_UUID") String userUuid){
        Map<String, Object> response = new HashMap<>();

        List<UserOrder> userOrderList = orderService.getUserOrderList(userUuid);
        response.put("DATA_REC", userOrderList);
        return response;
    }

    @RequestMapping("/order_detail_list")
    @ResponseBody
    public Map<String, Object> getOrderDetailList(@ModelAttribute("ORDER_UUID") String orderUuid){
        Map<String, Object> response = new HashMap<>();

        List<OrderDetail> orderDetailsList = orderService.getOrderDetailList(orderUuid);
        response.put("DATA_REC", orderDetailsList);
        return response;
    }

    @PostMapping("/order_pay_money")
    @ResponseBody
    public Map<String, Object> payOrderItem(@RequestBody HashMap<String, Object> inRec){
        Map<String, Object> response = new HashMap<>();
        ArrayList arrIn = (ArrayList)inRec.get("IN_REC");
        String actionCode = "";

        for(int i = 0; i <= arrIn.size()-1; i++){
            HashMap  objItem = (HashMap)arrIn.get(i);
            String orderUuid      = (String)objItem.get("ORDER_UUID");
            actionCode = orderService.payOrderItem(orderUuid);
        }

        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

    @RequestMapping("/order_stock_out")
    @ResponseBody
    public Map<String, Object> getReportStockOutList(@ModelAttribute("START_DATE") String sDate, @ModelAttribute("END_DATE") String eDate){
        Map<String, Object> response = new HashMap<>();
        startDate   = sDate;
        endDate    = eDate;

        List<StockReportOut> stockOutList = orderService.getReportStockOutList(sDate, eDate);
        response.put("DATA_REC", stockOutList);
        return response;
    }

    @GetMapping(value = "/download")
    public ResponseEntity<InputStreamResource> excelCustomersReport () throws IOException {
        List<StockReportOut> stockOutList = orderService.getReportStockOutList(startDate, endDate);
        String[] header             = { "ITEMS", "UNIT PRICE", "SALE", "BRONZE-MASTER", "TEAM-TIME", "CREDIT", "CASH", "TOTAL INCOME" };
        List<String[]> list         = new ArrayList<>();

        for (int i = 0;i < stockOutList.size();i++){
            String unitPriceStr         = stockOutList.get(i).getProductPrice().toString();
            String orderQtyStr         = stockOutList.get(i).getOrderQuantity().toString();
            BigDecimal unitPrice    = new BigDecimal(unitPriceStr).setScale(5, RoundingMode.HALF_EVEN);
            BigDecimal orderQty    = new BigDecimal(orderQtyStr).setScale(5, RoundingMode.HALF_EVEN);
            BigDecimal totalIncome = unitPrice.setScale(2, BigDecimal.ROUND_HALF_DOWN).multiply(orderQty.setScale(2, BigDecimal.ROUND_HALF_DOWN));

            String[] arr = {
                    stockOutList.get(i).getProductName().toString(),
                    "$"+unitPrice.setScale(2, BigDecimal.ROUND_HALF_DOWN).toString(),
                    stockOutList.get(i).getOrderQuantity().toString(),
                    stockOutList.get(i).getBronzeMasterQuantity().toString(),
                    stockOutList.get(i).getTeaTimeQuantity().toString(),
                    stockOutList.get(i).getCreditQuantity().toString(),
                    stockOutList.get(i).getDebitQuantity().toString(),
                    "$"+totalIncome.setScale(2, BigDecimal.ROUND_HALF_DOWN).toString()
                    };
//                    (Double)  * (Double) orderQty.setScale(2)};
            list.add(arr);
        }
        ByteArrayInputStream in = ExcelGenerator.customersToExcel(list,header);
        // return IOUtils.toByteArray(in);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=WeGaden_INSTOCK.xlsx");
        return ResponseEntity
                .ok()
                .headers(headers)
                .body(new InputStreamResource(in));
    }

}