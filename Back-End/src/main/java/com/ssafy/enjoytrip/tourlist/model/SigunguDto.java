package com.ssafy.enjoytrip.tourlist.model;

import org.springframework.web.bind.annotation.ModelAttribute;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "SigunguDto (시군구 정보)", description = "area, sigungu, name 을 가진   Domain Class")
public class SigunguDto {
	
	@ApiModelProperty(value = "지역 코드")
	int areaCode;
	@ApiModelProperty(value = "시구군 코드")
	int sigunguCode;
	@ApiModelProperty(value = "지역 이름")
	String name;
	
	public int getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(int areaCode) {
		this.areaCode = areaCode;
	}
	public int getSigunguCode() {
		return sigunguCode;
	}
	public void setSigunguCode(int sigunguCode) {
		this.sigunguCode = sigunguCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
