package com.ottt.ottt.controller.plan;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/plan/")
public class PlanController {
	
	@GetMapping("/planList")
	public String planList() {
		return "plan/planList";
	}

}
