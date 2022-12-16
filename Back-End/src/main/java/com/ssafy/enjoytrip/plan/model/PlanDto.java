package com.ssafy.enjoytrip.plan.model;

import java.util.List;

import com.ssafy.enjoytrip.tourlist.model.TourListDto;

public class PlanDto {

	int planNo;
	String userId;
	String planSubject;
	String planContent;
	int hit;
	String registerTime;
	List<TourListDto> planInforms;
	
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPlanSubject() {
		return planSubject;
	}
	public void setPlanSubject(String planSubject) {
		this.planSubject = planSubject;
	}
	public String getPlanContent() {
		return planContent;
	}
	public void setPlanContent(String planContent) {
		this.planContent = planContent;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
	}
	public List<TourListDto> getPlanInforms() {
		return planInforms;
	}
	public void setPlanInforms(List<TourListDto> planInforms) {
		this.planInforms = planInforms;
	}
	
}
