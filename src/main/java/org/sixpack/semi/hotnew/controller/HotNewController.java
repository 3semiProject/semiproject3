package org.sixpack.semi.hotnew.controller;

import org.sixpack.semi.hotnew.model.service.HotNewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class HotNewController {
private static final Logger logger = LoggerFactory.getLogger(HotNewController.class);
	
	@Autowired
	private HotNewService hotNewService;
}
