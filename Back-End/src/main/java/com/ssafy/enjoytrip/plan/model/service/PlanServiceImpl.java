package com.ssafy.enjoytrip.plan.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.enjoytrip.plan.model.PlanDto;
import com.ssafy.enjoytrip.plan.model.mapper.PlanMapper;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;

@Service
public class PlanServiceImpl implements PlanService {
	
	@Autowired
	private PlanMapper planMapper;

	@Override
	public List<TourListDto> recommend(int num) throws Exception {
		return planMapper.recommend(num);
	}

	@Override
	public List<TourListDto> search(String word) throws Exception {
		return planMapper.search(word);
	}

	@Override
	@Transactional
	public int registPlan(PlanDto planDto) throws Exception {
		planMapper.registPlan(planDto);
		planMapper.registPlanInfo(planDto);
		return 1;
	}

	@Override
	public List<PlanDto> listPlan() throws Exception {
		return planMapper.listPlan();
	}

	@Override
	public PlanDto getPlan(int planNo) throws Exception {
		planMapper.updateHit(planNo);
		return planMapper.getPlan(planNo);
	}

	@Override
	@Transactional
	public int deletePlan(int planNo) throws Exception {
		planMapper.deletePlanInfos(planNo);
		planMapper.deletePlan(planNo);
		return 1;
	}

}
