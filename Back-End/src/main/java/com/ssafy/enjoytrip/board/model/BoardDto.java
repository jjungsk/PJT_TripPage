package com.ssafy.enjoytrip.board.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "BoardDto (게시판 정보)", description = "게시판 번호, 작성자 id, 제목, 내용 등을 가진 Domain Class")
public class BoardDto {

	@ApiModelProperty(value = "게시판 번호")
	private int articleNo;
	@ApiModelProperty(value = "게시글 작성자 ID")
	private String userId;
	@ApiModelProperty(value = "게시글 작성자 이름")
	private String userName;
	@ApiModelProperty(value = "게시글 제목")
	private String subject;
	@ApiModelProperty(value = "게시글 내용")
	private String content;
	@ApiModelProperty(value = "게시글 조회 수")
	private int hit;
	@ApiModelProperty(value = "게시글 작성 일자")
	private String registerTime;
	
	public int getArticleNo() {
		return articleNo;
	}
	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	
}
