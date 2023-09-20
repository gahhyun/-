package com.ottt.ottt.dao.plan;

import java.util.List;

import com.ottt.ottt.dto.PlanDTO;

public interface PlanDao {
	
	List<PlanDTO> planList(Integer user_no) throws Exception;
	PlanDTO selectPlan(Integer plan_no) throws Exception;
	int insertPlan(PlanDTO planDTO) throws Exception;
	int updatePlan(PlanDTO planDTO) throws Exception;
	int deletePlan(Integer plan_no) throws Exception;

}
