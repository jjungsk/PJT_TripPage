package com.ssafy.enjoytrip.user.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "UserDto (회원정보)", description = "아이디, 비번, 이름 등 을 가진   Domain Class")
public class UserDto {
	
	@ApiModelProperty(value="회원 아이디")
	private String id;
	@ApiModelProperty(value="회원 비밀번호")
	private String password;
	@ApiModelProperty(value="회원 이름")
	private String name;
	@ApiModelProperty(value="회원 이메일")
	private String email;
	@ApiModelProperty(value="회원 전화번호")
	private String tel;
	@ApiModelProperty(value="매니져 유무")
	private int isManager;
	@ApiModelProperty(value="매니져 유무")
	private String saveid;
	
	public UserDto() {
	}

	public UserDto(String id, String password, String name, String email, String tel, int isManager, String saveid) {
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.tel = tel;
		this.isManager = isManager;
		this.saveid = saveid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getIsManager() {
		return isManager;
	}

	public void setIsManager(int isManager) {
		this.isManager = isManager;
	}
	
	public String getSaveid() {
		return saveid;
	}

	public void setSaveid(String saveid) {
		this.saveid = saveid;
	}

	@Override
	public String toString() {
		return "UserDto [id=" + id + ", password=" + password + ", name=" + name + ", email=" + email + ", tel=" + tel
				+ ", isManager=" + isManager + ", saveid=" + saveid + "]";
	}
	
	
	
}
