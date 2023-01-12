package com.droh.base.service;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;

@Service
public interface RService {
	
	public void PredictDiabetes(HttpServletRequest request, Model model) throws Exception;

	public void PredictStroke(HttpServletRequest request, Model model) throws Exception;
	
	public void PredictDementia(HttpServletRequest request, Model model) throws Exception;
	
	public void PredictDementiaReg(HttpServletRequest request, Model model) throws Exception;


}
