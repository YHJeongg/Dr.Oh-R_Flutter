package com.droh.base.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.droh.base.service.RService;

@Controller
public class RController {
	
	@Autowired
	RService service;

}
