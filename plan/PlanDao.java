package com.ottt.ottt.dao.plan;

import com.ottt.ottt.dto.PlanDTO;

public interface PlanDao {
	
	PlanDTO selectPlan(Integer plan_no) throws Exception;
	int insertPlan(PlanDTO planDTO) throws Exception;
	int updatePlan(PlanDTO planDTO) throws Exception;
	int deletePlan(Integer plan_no) throws Exception;

}
