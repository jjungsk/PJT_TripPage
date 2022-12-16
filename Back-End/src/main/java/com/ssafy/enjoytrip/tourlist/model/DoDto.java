package com.ssafy.enjoytrip.tourlist.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "DoDto (해야할 일 정보)", description = "지역 코드, 지역 이름 을 가진 Domain Class")public class DoDto {
	
	@ApiModelProperty(value = "지역 코드")
	int areaCode;
	@ApiModelProperty(value = "지역 이름")
	String name;

	public int getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(int areaCode) {
		this.areaCode = areaCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
