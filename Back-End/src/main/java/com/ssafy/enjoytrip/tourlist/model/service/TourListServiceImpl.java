package com.ssafy.enjoytrip.tourlist.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ssafy.enjoytrip.tourlist.model.DoDto;
import com.ssafy.enjoytrip.tourlist.model.SigunguDto;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;
import com.ssafy.enjoytrip.tourlist.model.mapper.TourListMapper;

@Service
public class TourListServiceImpl implements TourListService {

	private TourListMapper tourListMapper;
	
	private TourListServiceImpl(TourListMapper tourListMapper) {
		this.tourListMapper = tourListMapper;
	}
	
	@Override
	public List<DoDto> sidoList() throws Exception {
		return tourListMapper.sidoList();
	}
	
	@Override
	public List<SigunguDto> gugunList(int areaCode) throws Exception {
		return tourListMapper.gugunList(areaCode);
	}
	
	@Override
	public TourListDto recommend(int contentTypeId) throws Exception {
		return tourListMapper.recommend(contentTypeId);
	}

	@Override
	public List<TourListDto> getData(Map<String, Integer> map) throws Exception {
		return tourListMapper.getData(map);
	}

}
