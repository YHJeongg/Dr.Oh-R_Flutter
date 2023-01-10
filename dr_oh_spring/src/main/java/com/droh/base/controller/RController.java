package com.droh.base.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.droh.base.service.RService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RController {
	
	@Autowired
	RService service;
	
	@GetMapping("/diabetes")
	public String Diabetes(HttpServletRequest request, Model model) throws Exception{
		service.PredictDiabetes(request, model);
		return "result";
	}

}
