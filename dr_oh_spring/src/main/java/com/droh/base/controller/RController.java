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
	
	//Desc: 당뇨병 예측
	//Date: 2023-01-12
	@GetMapping("/diabetes")
	public String Diabetes(HttpServletRequest request, Model model) throws Exception{
		service.PredictDiabetes(request, model);
		return "result";
	}
	
	@GetMapping("/stroke")
	public String Stroke(HttpServletRequest request, Model model) throws Exception{
		service.PredictStroke(request, model);
		return "result";
	}
	
	@GetMapping("/dementia")
	public String Dementia(HttpServletRequest request, Model model) throws Exception{
		service.PredictDementia(request, model);
		return "result";
	}
	
	@GetMapping("/dementiareg")
	public String DementiaReg(HttpServletRequest request, Model model) throws Exception{
		service.PredictDementiaReg(request, model);
		return "result";
	}

}
