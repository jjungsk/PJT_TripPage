package com.ssafy.enjoytrip.notice.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "NoticeDto (공지사항 정보)", description = "공지 정보(문서 번호, 아이디, 제목, 내용)을 가진 Domain Class")
public class NoticeDto {
	
	@ApiModelProperty(value = "공지 번호")
	private int articleNo;
	@ApiModelProperty(value = "작성자 id")
	private String userId;
	@ApiModelProperty(value = "작성자 이름")
	private String userName;
	@ApiModelProperty(value = "공지 제목")
	private String subject;
	@ApiModelProperty(value = "공지 내용")
	private String content;
	@ApiModelProperty(value = "공지 조회수")
	private int hit;
	@ApiModelProperty(value = "공지 작성 일자")
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
