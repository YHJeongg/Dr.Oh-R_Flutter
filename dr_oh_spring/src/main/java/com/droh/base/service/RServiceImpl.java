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
		
		int age=Integer.parseInt(request.getParameter("age"));
		double bmi=Double.parseDouble(request.getParameter("bmi"));
		int physact=request.getParameter("physact").equals("true")?1:0;
		double genHealth=5-Double.parseDouble(request.getParameter("genhealth"));
		int heartattack=request.getParameter("hdattack").equals("true")?1:0;
		int highbp=request.getParameter("highbp").equals("true")?1:0;
		int stroke=request.getParameter("stroke").equals("true")?1:0;
		int physhealth=Integer.parseInt(request.getParameter("physhealth"));
		int diffwalk=request.getParameter("diffwalk").equals("true")?1:0;
		
		RConnection conn = new RConnection();
		
		conn.voidEval("library(nnet)");
		conn.voidEval("setwd('" + path + "')");
		conn.voidEval("machine <- readRDS('nnet_diabetes.rds','rb')");
		conn.voidEval("result=as.character(predict(machine,list(Age=" + age + ",BMI=" + bmi + ",HeartDiseaseorAttack=" + heartattack + ",PhysActivity=" + physact + ",GenHlth=" + genHealth + ",PhysHlth=" + physhealth + ",DiffWalk=" + diffwalk + ",Stroke=" + stroke + ",HighBP=" + highbp + ")))");

		String result = conn.eval("result").asString();
		
		model.addAttribute("ITEM", result);
	}

}
