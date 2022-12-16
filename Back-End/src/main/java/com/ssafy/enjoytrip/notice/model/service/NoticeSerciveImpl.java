package com.ssafy.enjoytrip.notice.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.notice.model.NoticeDto;
import com.ssafy.enjoytrip.notice.model.mapper.NoticeMapper;
import com.ssafy.enjoytrip.util.SizeConstant;

@Service
public class NoticeSerciveImpl implements NoticeService {

	private NoticeMapper noticeMapper;
	
	private NoticeSerciveImpl (NoticeMapper noticeMapper) {
		this.noticeMapper = noticeMapper;
	}
	
	@Override
	public int countArticle() throws Exception {
		return noticeMapper.countArticle(null);
	}


	@Override
	public Map<String, Object> listArticle(Map<String, String> map) throws Exception {
		int pgno = Integer.parseInt(map.get("pgno")); // 현재 페이지
		int spl = SizeConstant.ARTICLENUM_PER_PAGE; // 10 페이지
		int start = (pgno - 1) * spl; // limit start
		map.put("start", start + "");
		map.put("spl", spl + "");
		
		if (map.get("key") != null && map.get("key").equals("userid")) {
			map.put("key", "user_id");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", noticeMapper.listArticle(map)); // 현재 페이지의 article 정보
		Map<String, Integer> paginationInfo = new HashMap<String, Integer>();
		paginationInfo.put("currentPage", pgno);
		paginationInfo.put("dataPerPage", spl);
		paginationInfo.put("pageCount", SizeConstant.PAGE_PER_PAGINATION); // 몇페이지로 구성 되어 있는지
		paginationInfo.put("totalData", noticeMapper.countArticle(map));
		returnMap.put("paginationInfo", paginationInfo);
		
		return returnMap;
	}

	@Override
	public List<NoticeDto> preview(int num) throws Exception {
		return noticeMapper.preview(num);
	}

	@Override
	public int writeArticle(NoticeDto noticeDto) throws Exception {
		return noticeMapper.writeArticle(noticeDto);
	}
	
	@Override
	public NoticeDto getArticle(int articleNo) throws Exception {
		return noticeMapper.getArticle(articleNo);
	}

	@Override
	public void updateHit(int articleNo) throws Exception {
		noticeMapper.updateHit(articleNo);
	}

	@Override
	public void deleteArticle(int articleNo) throws Exception {
		noticeMapper.deleteArticle(articleNo);
	}

	@Override
	public void modifyArticle(NoticeDto noticeDto) throws Exception {
		noticeMapper.modifyArticle(noticeDto);
	}


}
