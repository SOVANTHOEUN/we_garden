package com.wegarden.web.util;

import com.wegarden.web.model.stock.StockReportOut;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class ExcelGenerator {
	
	public static ByteArrayInputStream customersToExcel(List<StockReportOut> stockReportOuts) throws IOException {
		String[] COLUMNs = {"TEST1", "TEST2", "TEST3", "TEST4"};
		try(
				Workbook workbook = new XSSFWorkbook();
				ByteArrayOutputStream out = new ByteArrayOutputStream();
		){
			CreationHelper createHelper = workbook.getCreationHelper();
	 
			Sheet sheet = workbook.createSheet("Stock Out");
	 
			Font headerFont = workbook.createFont();
			headerFont.setBold(true);
			headerFont.setColor(IndexedColors.BLUE_GREY.getIndex());
	 
			CellStyle headerCellStyle = workbook.createCellStyle();
			headerCellStyle.setFont(headerFont);

			// Row for Header
			Row headerRow = sheet.createRow(0);
	 
			// Header
			for (int col = 0; col < COLUMNs.length; col++) {
				Cell cell = headerRow.createCell(col);
				cell.setCellValue(COLUMNs[col]);
				cell.setCellStyle(headerCellStyle);
			}
	 
			// CellStyle for Age
			CellStyle ageCellStyle = workbook.createCellStyle();
			ageCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("#"));
	 
			int rowIdx = 1;
			for (StockReportOut stockReportOut : stockReportOuts) {
				Row row = sheet.createRow(rowIdx++);
	 
				row.createCell(0).setCellValue(stockReportOut.getCategoryName());
				row.createCell(1).setCellValue(stockReportOut.getCategoryUuid());
				row.createCell(2).setCellValue(stockReportOut.getCreditQuantity());
	 
				Cell ageCell = row.createCell(3);
				ageCell.setCellValue(stockReportOut.getProductName());
				ageCell.setCellStyle(ageCellStyle);
			}
	 
			workbook.write(out);
			return new ByteArrayInputStream(out.toByteArray());
		}
	}
}