package com.ssafy.enjoytrip.notice.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.notice.model.NoticeDto;

@Mapper
public interface NoticeMapper {

	int countArticle(Map<String, String> map) throws SQLException;
	int writeArticle(NoticeDto noticeDto) throws SQLException;
	List<NoticeDto> listArticle(Map<String, String> map) throws SQLException;
	List<NoticeDto> preview(int num) throws SQLException;
	NoticeDto getArticle(int articleNo) throws SQLException;
	void updateHit(int articleNo) throws SQLException;
	void modifyArticle(NoticeDto noticeDto) throws SQLException;
	void deleteArticle(int articleNo) throws SQLException;
	
}
