package com.springlec.base;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Hello {

	@RequestMapping("/")
	public String hello() {
		System.out.println("Hello World!");
		return "index"; // .jsp 안써도 된다.
	}
}
