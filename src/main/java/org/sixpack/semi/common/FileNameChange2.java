package org.sixpack.semi.common;

import java.text.SimpleDateFormat;
import java.util.Random;

public class FileNameChange2 {

    public static String change(
            String fileName, String formatStr) {
        //바꿀 파일명에 대한 문자열 만들기
        //공지글 등록 | 수정 요청시점의 날짜시간정보를 이용함
    	int num = (int)(Math.random() * 1000);
        SimpleDateFormat sdf =
                new SimpleDateFormat(formatStr);
        //변경할 파일명 만들기
        String renameFileName = sdf.format(
                new java.sql.Date(System.currentTimeMillis())) + num;
        //원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
        renameFileName += "." + fileName.substring(
                fileName.lastIndexOf(".") + 1);

        return renameFileName;
    }
}
