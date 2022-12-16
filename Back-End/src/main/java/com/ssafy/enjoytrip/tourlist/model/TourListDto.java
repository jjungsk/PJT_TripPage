package com.ssafy.enjoytrip.tourlist.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value="ToutListDto (관광지 정보)", description = "관광지 id, code, title 을 가진 Domain Class")
public class TourListDto {
	
	@ApiModelProperty(value = "관광지 id")
	private int idx;
	@ApiModelProperty(value = "관광지 지역 Code")
	private int areaCode;
	@ApiModelProperty(value = "관광지 시군구 Code")
	private int sigunguCode;
	@ApiModelProperty(value = "관광지 이름")
	private String title;
	@ApiModelProperty(value = "관광지 주소 1")
	private String addr1;
	@ApiModelProperty(value = "관광지 주소 2")
	private String addr2;
	@ApiModelProperty(value = "관광지 contentType Id")
	private int contentTypeId;
	@ApiModelProperty(value = "관광지 content Id")
	private int contentId;
	@ApiModelProperty(value = "관광지 x좌표")
	private double mapx;
	@ApiModelProperty(value = "관광지 y좌표")
	private double mapy;
	@ApiModelProperty(value = "관광지 대표 이미지")
	private String image;
	@ApiModelProperty(value = "관광지 전화번호")
	private String tel;
	@ApiModelProperty(value = "관광지 zip Code")
	private String zipcode;
	@ApiModelProperty(value = "관광지 설명")
	private String desc;
	

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public int getContentTypeId() {
		return contentTypeId;
	}
	public void setContentTypeId(int contentTypeId) {
		this.contentTypeId = contentTypeId;
	}
	public int getContentId() {
		return contentId;
	}
	public void setContentId(int contentId) {
		this.contentId = contentId;
	}
	public double getMapx() {
		return mapx;
	}
	public void setMapx(double mapx) {
		this.mapx = mapx;
	}
	public double getMapy() {
		return mapy;
	}
	public void setMapy(double mapy) {
		this.mapy = mapy;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	
}
