package org.sixpack.semi.diary.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DiaryController {
    Logger logger = LoggerFactory.getLogger(DiaryController.class);

    @RequestMapping("diary.do")
    public String moveDiaryMethod(){
        return "diary/diaryMain";
    }

}
