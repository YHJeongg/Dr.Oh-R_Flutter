package com.droh.base.service;

import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class RServiceImpl implements RService {

	@Override
	public void PredictDiabetes(HttpServletRequest request, Model model) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		ServletContext context=session.getServletContext();
		String path=context.getRealPath("/");
		path=path.replaceAll("\\\\", "/");
		
		RConnection conn = new RConnection();
		
		conn.voidEval("library(randomForest)");
		conn.voidEval("rf <- readRDS('" + path + "Diabetes.rds','rb')");

		conn.voidEval("");

		String result = conn.eval("result").asString();
		
		model.addAttribute("ITEM", result);
	}

}
