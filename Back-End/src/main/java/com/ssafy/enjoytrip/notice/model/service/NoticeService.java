package com.ssafy.enjoytrip.notice.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.enjoytrip.notice.model.NoticeDto;

public interface NoticeService {

	int countArticle() throws Exception;
	int writeArticle(NoticeDto noticeDto) throws Exception;
	Map<String, Object> listArticle(Map<String, String> map) throws Exception;
	List<NoticeDto> preview(int num) throws Exception;
	NoticeDto getArticle(int articleNo) throws Exception;
	void updateHit(int articleNo) throws Exception;
	void modifyArticle(NoticeDto noticeDto) throws Exception;
	void deleteArticle(int articleNo) throws Exception;
}
