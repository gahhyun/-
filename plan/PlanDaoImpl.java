package com.ottt.ottt.dao.plan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ottt.ottt.dto.PlanDTO;

@Repository
public class PlanDaoImpl implements PlanDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.ottt.ottt.dao.plan.planMapper.";
	
	
	@Override
	public List<PlanDTO> planList(Integer user_no) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+"planList", user_no);
	}

	@Override
	public PlanDTO selectPlan(Integer plan_no) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+"selectPlan", plan_no);
	}

	@Override
	public int insertPlan(PlanDTO planDTO) throws Exception {
		// TODO Auto-generated method stub
		return session.insert(namespace+"insertPlan", planDTO);
	}

	@Override
	public int updatePlan(PlanDTO planDTO) throws Exception {
		// TODO Auto-generated method stub
		return session.update(namespace+"updatePlan", planDTO);
	}

	@Override
	public int deletePlan(Integer plan_no) throws Exception {
		// TODO Auto-generated method stub
		return session.delete(namespace+"deletePlan", plan_no);
	}



}
