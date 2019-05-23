package com.wegarden.web.model.stock;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class ExcelGenerator {

    public static ByteArrayInputStream customersToExcel(List<DownloadRefrig> downloadRefrigs) throws IOException {
        String[] COLUMNs = {"Items", "Unit-Price", "In-Stock"};
        try(
                Workbook workbook = new XSSFWorkbook();
                ByteArrayOutputStream out = new ByteArrayOutputStream();
        ){
            CreationHelper createHelper = workbook.getCreationHelper();

            Sheet sheet = workbook.createSheet("DownloadRefrig");
            short COLOR_RED = 20;
            sheet.setDefaultColumnWidth(25);
            sheet.setVerticallyCenter(true);
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.BLACK.getIndex());


            CellStyle style = workbook.createCellStyle();
            style.setFont(headerFont);
            style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            style.setAlignment(HorizontalAlignment.CENTER );



            // Row for Header
            Row headerRow = sheet.createRow(0);

            // Header
            for (int col = 0; col < COLUMNs.length; col++) {
                Cell cell = headerRow.createCell(col);
                cell.setCellValue(COLUMNs[col]);
                cell.setCellStyle(style);
            }

            // CellStyle for Age
            CellStyle ageCellStyle = workbook.createCellStyle();
            ageCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("#"));

            int rowIdx = 1;
            for (DownloadRefrig refrig : downloadRefrigs) {
                Row row = sheet.createRow(rowIdx++);

                row.createCell(0).setCellValue(refrig.getItem());
                row.createCell(1).setCellValue(refrig.getPrice());
                row.createCell(2).setCellValue(refrig.getInStock());

                Cell ageCell = row.createCell(3);
                ageCell.setCellStyle(ageCellStyle);
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }
}
