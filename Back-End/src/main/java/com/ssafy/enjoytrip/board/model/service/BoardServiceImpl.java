package com.ssafy.enjoytrip.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.board.model.BoardDto;
import com.ssafy.enjoytrip.board.model.mapper.BoardMapper;
import com.ssafy.enjoytrip.util.SizeConstant;

@Service
public class BoardServiceImpl implements BoardService {

	private BoardMapper boardMapper;

	@Autowired
	private BoardServiceImpl(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}

	@Override
	public int countArticle() throws Exception {
		return boardMapper.countArticle(null);
	}

	@Override
	public Map<String, Object> listArticle(Map<String, String> map) throws Exception {
		int pgno = Integer.parseInt(map.get("pgno"));
		int spl = SizeConstant.ARTICLENUM_PER_PAGE;
		int start = (pgno - 1) * spl;
		map.put("start", start + "");
		map.put("spl", spl + "");
		if (map.get("key") != null && map.get("key").equals("userid")) {
			map.put("key", "user_id");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", boardMapper.listArticle(map));
		Map<String, Integer> paginationInfo = new HashMap<String, Integer>();
		paginationInfo.put("currentPage", pgno);
		paginationInfo.put("dataPerPage", spl);
		paginationInfo.put("pageCount", SizeConstant.PAGE_PER_PAGINATION);
		paginationInfo.put("totalData", boardMapper.countArticle(map));
		returnMap.put("paginationInfo", paginationInfo);
		
		return returnMap;
	}

	@Override
	public List<BoardDto> preview(int num) throws Exception {
		return boardMapper.preview(num);
	}

	@Override
	public int writeArticle(BoardDto boardDto) throws Exception {
//		String subject = boardDto.getSubject(); // pagination test (글 여러개 삽입)
//		for (int i = 0; i < 103; i++) {
//			boardDto.setSubject(subject + i);
//			boardMapper.writeArticle(boardDto);
//		}
		return boardMapper.writeArticle(boardDto);
	}

	@Override
	public BoardDto getArticle(int articleNo) throws Exception {
		return boardMapper.getArticle(articleNo);
	}

	@Override
	public void updateHit(int articleNo) throws Exception {
		boardMapper.updateHit(articleNo);
	}

	@Override
	public void deleteArticle(int articleNo) throws Exception {
		boardMapper.deleteArticle(articleNo);
	}

	@Override
	public void modifyArticle(BoardDto boardDto) throws Exception {
		boardMapper.modifyArticle(boardDto);
	}

}
