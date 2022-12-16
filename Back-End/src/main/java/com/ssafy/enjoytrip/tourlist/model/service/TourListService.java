package com.ssafy.enjoytrip.tourlist.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.enjoytrip.tourlist.model.DoDto;
import com.ssafy.enjoytrip.tourlist.model.SigunguDto;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;

public interface TourListService {
	
	List<DoDto> sidoList() throws Exception;
	List<SigunguDto> gugunList(int areaCode) throws Exception;
	TourListDto recommend(int contentTypeId) throws Exception;
	List<TourListDto> getData(Map<String, Integer> map) throws Exception;
	
}
