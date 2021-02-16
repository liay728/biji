# poi

## poi概念

​	由 apeche 公司提供；

​	Java 编写的免费的开源的跨平台的Java API

​	提供 API 给 Java 程序对 Microsoft Office 格式档案读和写的功能

## poi包结构

​	HSSF：读写 Microsoft  Excel XLS（专门操作 2007 版本之前的Excel）

​	XSSF：读写 Microsoft  Excel OOXML XLSX（专门操作 2007 版本之后的Excel）

​	HWPF：读写 Microsoft  Word DOC（专门操作 Word 文档）

​	HSLF：提供读写 Microsoft  PowerPoint（专门操作 PPT 文档）

## poi封装的对象

### XSSFWorkbook

​	含义：工作薄

### XSSFsheet

​	含义：工作表

### Row

​	含义：行

### Cell

​	含义：单元格（列）

## 读

```java
package com.liay.read;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;

public class ReadStu {

    public static void main(String[] args) throws IOException {

        // 获取工作薄
        XSSFWorkbook workbook = new XSSFWorkbook("D:\\poiTest\\testone.xlsx");
        // 获取工作表
        XSSFSheet sheet = workbook.getSheetAt(0);
        // 获取行
        for (Row row: sheet) {
            // 获取单元格
            for(Cell cell : row){
                // 获取单元格中的内容
                String value = cell.getStringCellValue();
                System.out.println(value);
            }
        }

        System.out.println("------------------------------");

        // 普通 for 循环方式

        // 获取 行的 最后索引
        int lastRowNum = sheet.getLastRowNum();
        for (int i = 0; i <= lastRowNum; i++){

            XSSFRow row = sheet.getRow(i);
            if (null != row) {

                // 获取 单元格（列） 最后索引
                short lastCellNum = row.getLastCellNum();
                for (int j = 0; j <= lastCellNum; j++){

                    XSSFCell cell = row.getCell(j);
                    if (null != cell) {
                        String value = cell.getStringCellValue();
                        System.out.println(value);
                    }
                }
            }
        }


        // 释放资源
        workbook.close();
    }
}
```

## 写

```java
package com.liay.write;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class WriteStu {

    public static void main(String[] args) throws IOException {

        // 创建 工作薄 对象
        XSSFWorkbook workbook = new XSSFWorkbook();

        // 创建 工作表 对象
        XSSFSheet sheet = workbook.createSheet("工作表");

        // 创建 行
        XSSFRow rowone = sheet.createRow(0);

        // 创建单元格
        rowone.createCell(0).setCellValue("第一行，第一列");
        rowone.createCell(1).setCellValue("第一行，第二列");
        rowone.createCell(2).setCellValue("第一行，第三列");

        XSSFRow rowtwo = sheet.createRow(1);
        // 创建单元格
        rowtwo.createCell(0).setCellValue("第二行，第一列");
        rowtwo.createCell(1).setCellValue("第二行，第二列");
        rowtwo.createCell(2).setCellValue("第二行，第三列");

        // 创建输出流对象
        FileOutputStream outputStream = new FileOutputStream("D:\\poiTest\\test1.xlsx");
        // 将数据写入 指定 文件中（没有则创建）
        workbook.write(outputStream);
        // 清空缓冲区数据
        outputStream.flush();
        // 释放资源
        outputStream.close();
        // 释放资源
        workbook.close();

    }
}
```

