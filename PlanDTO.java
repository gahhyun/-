package com.ottt.ottt.dto;

import java.util.Date;

import lombok.Data;

@Data
public class PlanDTO {
	
	private Integer plan_no;
	private Date plan_date;
	private Integer user_no;
	private String plan_content;

}
