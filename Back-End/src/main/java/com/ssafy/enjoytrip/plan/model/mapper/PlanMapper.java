package com.ssafy.enjoytrip.plan.model.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.plan.model.PlanDto;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;

@Mapper
public interface PlanMapper {
	// 추천장소 받기
	List<TourListDto> recommend(int num) throws SQLException;
	// 장소 검색
	List<TourListDto> search(String word) throws SQLException;
	// 일정 등록
	int registPlan(PlanDto planDto) throws SQLException;
	// 일정 장소 등록
	int registPlanInfo(PlanDto planDto) throws SQLException;
	// 일정 목록
	List<PlanDto> listPlan() throws SQLException; // 개수 제한 할까(페이지네이션) -> 맵 , 아니면 스크롤
	// 일정 가져오기
	PlanDto getPlan(int planNo) throws SQLException;
	void updateHit(int planNo) throws SQLException;
	// 일정 장소 삭제
	int deletePlanInfos(int planNo) throws SQLException;
	// 일정 삭제
	int deletePlan(int planNo) throws SQLException;
}
