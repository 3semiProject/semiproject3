package org.sixpack.semi.bfaf.controller;

import org.sixpack.semi.bfaf.model.service.BfafService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class BfafController {
	private static final Logger logger = LoggerFactory.getLogger(BfafController.class);
	@Autowired
	private BfafService bfafService;
}
