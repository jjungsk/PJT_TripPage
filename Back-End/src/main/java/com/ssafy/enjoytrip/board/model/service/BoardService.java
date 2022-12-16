package com.ssafy.enjoytrip.board.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.enjoytrip.board.model.BoardDto;

public interface BoardService {

	int countArticle() throws Exception;
	int writeArticle(BoardDto boardDto) throws Exception;
	Map<String, Object> listArticle(Map<String, String> map) throws Exception;
	List<BoardDto> preview(int num) throws Exception;
	BoardDto getArticle(int articleNo) throws Exception;
	void updateHit(int articleNo) throws Exception;
	void modifyArticle(BoardDto boardDto) throws Exception;
	void deleteArticle(int articleNo) throws Exception;
	
}
