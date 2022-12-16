package com.ssafy.enjoytrip.plan.model.service;

import java.util.List;

import com.ssafy.enjoytrip.plan.model.PlanDto;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;


public interface PlanService {
	
	// 추천장소 받기
	List<TourListDto> recommend(int num) throws Exception;
	// 장소 검색
	List<TourListDto> search(String word) throws Exception;
	// 일정 등록
	int registPlan(PlanDto planDto) throws Exception;
	// 일정 목록
	List<PlanDto> listPlan() throws Exception; // 개수 제한 할까(페이지네이션) -> 맵 , 아니면 스크롤
	// 일정 가져오기
	PlanDto getPlan(int planNo) throws Exception;
	// 일정 삭제
	int deletePlan(int planNo) throws Exception;
}
