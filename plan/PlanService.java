package com.ottt.ottt.service.plan;

import com.ottt.ottt.dto.PlanDTO;

public interface PlanService {
	
	PlanDTO selectPlan(Integer plan_no) throws Exception;
	int insertPlan(PlanDTO planDTO) throws Exception;
	int updatePlan(PlanDTO planDTO) throws Exception;
	int deletePlan(Integer plan_no) throws Exception;

}
