package com.droh.base.service;

import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class RServiceImpl implements RService {

	//Desc: 당뇨병 예측
	//Date: 2023-01-12
	@Override
	public void PredictDiabetes(HttpServletRequest request, Model model) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		ServletContext context=session.getServletContext();
		String path=context.getRealPath("/");
		path=path.replaceAll("\\\\", "/");
		
		int age=Integer.parseInt(request.getParameter("age"));
		double bmi=Double.parseDouble(request.getParameter("bmi"));
		int physact=request.getParameter("physact").equals("TRUE")?1:0;
		double genHealth=5-Double.parseDouble(request.getParameter("genhealth"));
		int heartattack=request.getParameter("hdattack").equals("true")?1:0;
		int highbp=request.getParameter("highbp").equals("true")?1:0;
		int stroke=request.getParameter("stroke").equals("true")?1:0;
		int physhealth=Integer.parseInt(request.getParameter("physhealth"));
		int diffwalk=request.getParameter("diffwalk").equals("TRUE")?1:0;
		
		RConnection conn = new RConnection();
		
		conn.voidEval("library(nnet)");
		conn.voidEval("setwd('" + path + "')");
		conn.voidEval("machine <- readRDS('nnet_diabetes.rds','rb')");
		conn.voidEval("result=as.character(predict(machine,list(Age=" + age + ",BMI=" + bmi + ",HeartDiseaseorAttack=" + heartattack + ",PhysActivity=" + physact + ",GenHlth=" + genHealth + ",PhysHlth=" + physhealth + ",DiffWalk=" + diffwalk + ",Stroke=" + stroke + ",HighBP=" + highbp + ")))");

		String result = conn.eval("result").asString();
		
		model.addAttribute("ITEM", result);
		
		conn.close();
	}
	
	@Override
	public void PredictStroke(HttpServletRequest request, Model model) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		ServletContext context=session.getServletContext();
		String path=context.getRealPath("/");
		path=path.replaceAll("\\\\", "/");
		
		int sex=request.getParameter("sex").equals("male")? 1 : 0;
		int age=Integer.parseInt(request.getParameter("age"));
		double bmi=Double.parseDouble(request.getParameter("bmi"));
		int hypertension=Integer.parseInt(request.getParameter("hypertension"));
		int heartDisease=Integer.parseInt(request.getParameter("heartDisease"));
		int everMarried=Integer.parseInt(request.getParameter("everMarried"));
		
		int workType0 = 0;
		int workType1 = 0;
		int workType2 = 0;
		int workType3 = 0;
		int workType4 = 0;
		switch (request.getParameter("workType")) {
		case "0":
			workType0 = 1;
			break;
		case "1":
			workType1 = 1;
			break;
		case "2":
			workType2 = 1;
			break;
		case "3":
			workType3 = 1;
			break;
		case "4":
			workType4 = 1;
			break;
		}
//		String workType4=request.getParameter("workType4").toString();
		System.out.println(sex);
		System.out.println(bmi);
		System.out.println(workType0);
		System.out.println(workType1);
		System.out.println(workType2);
		System.out.println(workType3);
		System.out.println(workType4);
		int residenceType=Integer.parseInt(request.getParameter("residenceType"));
		int smoke=Integer.parseInt(request.getParameter("smoke"));
		
		RConnection conn = new RConnection();
		
		conn.voidEval("library(randomForest)");
		conn.voidEval("setwd('" + path + "')");
		conn.voidEval("machine <- readRDS('randomForest_stroke.rds','rb')");
		conn.voidEval("result=as.character(predict(machine,list(sex=" + sex + ",age=" + age + ",bmi=" + bmi + ",hypertension=" + hypertension + ",heart_disease=" + heartDisease + ",ever_married=" + everMarried + ",work_type_0=" + workType0 + ",work_type_1=" + workType1 + ",work_type_2=" + workType2 + ",work_type_3=" + workType3 + ",work_type_4=" + workType4 + ",Residence_type=" + residenceType + ",smoking_status=" + smoke + ")))");

		String result = conn.eval("result").asString();
		
		model.addAttribute("ITEM", result);
		
		conn.close();
	}

	@Override
	public void PredictDementia(HttpServletRequest request, Model model) throws Exception {
	
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		ServletContext context=session.getServletContext();
		String path=context.getRealPath("/");
		path=path.replaceAll("\\\\", "/");
		
		int Age = Integer.parseInt(request.getParameter("Age"));
		int EDUC = Integer.parseInt(request.getParameter("EDUC"));
		int SES = Integer.parseInt(request.getParameter("SES"));
		int MMSE = Integer.parseInt(request.getParameter("MMSE"));
		int SexCode = Integer.parseInt(request.getParameter("SexCode"));
		
		System.out.println(Age);
		System.out.println(EDUC);
		System.out.println(SES);
		System.out.println(MMSE);
		System.out.println(SexCode);
		
		
		RConnection conn = new RConnection();
		
		conn.voidEval("library(randomForest)");
		conn.voidEval("setwd('" + path + "')");
		conn.voidEval("machine <- readRDS('random_dementia.rds','rb')");
		conn.voidEval("result=as.character(predict(machine,list(Age=" + Age + ", EDUC=" + EDUC + ", SES=" + SES + ", MMSE=" + MMSE + ", SexCode=" + SexCode + ")))");

		String result = conn.eval("result").asString();
		
		model.addAttribute("ITEM", result);
		
		conn.close();
	}

	@Override
	public void PredictDementiaReg(HttpServletRequest request, Model model) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		ServletContext context=session.getServletContext();
		String path=context.getRealPath("/");
		path=path.replaceAll("\\\\", "/");
		
		int Age = Integer.parseInt(request.getParameter("Age"));
		int EDUC = Integer.parseInt(request.getParameter("EDUC"));
		int SES = Integer.parseInt(request.getParameter("SES"));
		int MMSE = Integer.parseInt(request.getParameter("MMSE"));
		int SexCode = Integer.parseInt(request.getParameter("SexCode"));
		
		System.out.println(Age+"ghgh");
		System.out.println(EDUC);
		System.out.println(SES);
		System.out.println(MMSE);
		System.out.println(SexCode);
		
		
		RConnection conn = new RConnection();
		
		conn.voidEval("library(randomForest)");
		conn.voidEval("setwd('" + path + "')");
		conn.voidEval("machine <- readRDS('randomRegres4_dementia.rds','rb')");
		conn.voidEval("result=as.character(predict(machine,list(Age=" + Age + ", EDUC=" + EDUC + ", SES=" + SES + ", MMSE=" + MMSE + ", SexCode=" + SexCode + ")))");

		String result = conn.eval("result").asString();
		
		model.addAttribute("ITEM", result);
		
	}


	
	


}
