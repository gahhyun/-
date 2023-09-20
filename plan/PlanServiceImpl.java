package com.ottt.ottt.service.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ottt.ottt.dao.plan.PlanDaoImpl;
import com.ottt.ottt.dto.PlanDTO;

@Service
public class PlanServiceImpl implements PlanService{
	
	@Autowired
	PlanDaoImpl planDao;

	@Override
	public List<PlanDTO> planList(Integer user_no) throws Exception {
		// TODO Auto-generated method stub
		return planDao.planList(user_no);
	}
	
	@Override
	public PlanDTO selectPlan(Integer plan_no) throws Exception {
		// TODO Auto-generated method stub
		return planDao.selectPlan(plan_no);
	}

	@Override
	public int insertPlan(PlanDTO planDTO) throws Exception {
		// TODO Auto-generated method stub
		return planDao.insertPlan(planDTO);
	}

	@Override
	public int updatePlan(PlanDTO planDTO) throws Exception {
		// TODO Auto-generated method stub
		return planDao.updatePlan(planDTO);
	}

	@Override
	public int deletePlan(Integer plan_no) throws Exception {
		// TODO Auto-generated method stub
		return planDao.deletePlan(plan_no);
	}



}
