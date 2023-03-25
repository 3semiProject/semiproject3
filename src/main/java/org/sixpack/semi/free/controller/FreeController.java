package org.sixpack.semi.free.controller;

import org.sixpack.semi.free.model.service.FreeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class FreeController {
	private static final Logger logger = LoggerFactory.getLogger(FreeController.class);
	
	@Autowired
	private FreeService freeService;
	
	
}
