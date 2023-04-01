package org.sixpack.semi.diary.controller;


import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.sixpack.semi.diary.model.service.DiaryService;
import org.sixpack.semi.eat.model.vo.Food;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// 음식, 운동 데이터 db 삽입용

@Controller("InsertDataController")
public class InsertDataController {

    @Autowired
    private DiaryService diaryService;

    @RequestMapping(value = "insertFoodData.do", method = RequestMethod.POST)
    public String freeInsertMethod(Model model, @RequestParam("mfile") MultipartFile mfile) {


        String s = org.apache.commons.compress.archivers.zip.ZipArchiveInputStream.class.getProtectionDomain().getCodeSource().getLocation().toString();
        System.out.println(s);

        List<Food> datalist = new ArrayList<Food>();
        String extension = FilenameUtils.getExtension(mfile.getOriginalFilename());

        if (!extension.equals("xlsx") && !extension.equals("xls")) {
            model.addAttribute("message", "잘못된 파일 확장자 입니다.");
            return "common/error";
        }

        Workbook workbook = null;


        try {
            if (extension.equals("xlsx")) {
                workbook = new XSSFWorkbook(mfile.getInputStream());
            } else {
                workbook = new HSSFWorkbook(mfile.getInputStream());
            }

        } catch (IOException e) {
            model.addAttribute("message", "엑셀 파일 읽기 실패.");
            return "common/error";
        }
//        worksheet.getPhysicalNumberOfRows();
        Sheet worksheet = workbook.getSheetAt(0);
        for (int i = 0; i < 10; i++) {

            Row row = worksheet.getRow(i);

            Food food = new Food();

            food.setFood_code(row.getCell(1).getStringCellValue());
            food.setFood_name(row.getCell(2).getStringCellValue());
            food.setFood_kcal(row.getCell(3).getNumericCellValue());
            food.setFood_carbohydrate(row.getCell(4).getNumericCellValue());
            food.setFood_protein(row.getCell(5).getNumericCellValue());
            food.setFood_fat(row.getCell(6).getNumericCellValue());
            food.setFood_cholesterol(row.getCell(7).getNumericCellValue());
            food.setFood_roughage(row.getCell(8).getNumericCellValue());
            food.setFood_vitamin(row.getCell(9).getNumericCellValue());

            System.out.println(food);

            datalist.add(food);


        }

        return "common/main";
    }

}
