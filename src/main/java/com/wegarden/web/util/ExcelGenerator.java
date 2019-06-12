package com.wegarden.web.util;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.*;


public class ExcelGenerator {

    public static ByteArrayInputStream customersToExcel(List<String[]> list, String[] header) throws IOException {
        try(
                Workbook workbook = new XSSFWorkbook();
                ByteArrayOutputStream out = new ByteArrayOutputStream();
        ){
            CreationHelper createHelper = workbook.getCreationHelper();

            Sheet sheet = workbook.createSheet("DownloadRefrig");
            short COLOR_RED = 20;
            short FONT_SIZE   = 250;
            sheet.setDefaultColumnWidth(18);
            sheet.setVerticallyCenter(true);
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeight(FONT_SIZE);
            headerFont.setColor(IndexedColors.BLACK.getIndex());

            CellStyle style = workbook.createCellStyle();
            style.setFont(headerFont);
            style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            style.setAlignment(HorizontalAlignment.CENTER );

            // Row for Header
            Row headerRow = sheet.createRow(0);

            // Header
            for (int col = 0; col < header.length; col++) {
                Cell cell = headerRow.createCell(col);
                cell.setCellValue(header[col]);
                cell.setCellStyle(style);
            }

            // CellStyle for Age
            CellStyle ageCellStyle = workbook.createCellStyle();
            ageCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("#"));

            int rowIdx = 1;
            for (int i = 0; i < list.size(); i++) {
                Row row = sheet.createRow(rowIdx++);
                for (int j= 0; j <list.get(i).length; j++) {
                    String[] data = list.get(i);
                    row.createCell(j).setCellValue(data[j]);
                    Cell ageCell = row.createCell(header.length);
                    ageCell.setCellStyle(ageCellStyle);
                }
            }
            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }
}
