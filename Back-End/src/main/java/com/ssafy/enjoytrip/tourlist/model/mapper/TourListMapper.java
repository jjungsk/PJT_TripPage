package com.ssafy.enjoytrip.tourlist.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.enjoytrip.tourlist.model.DoDto;
import com.ssafy.enjoytrip.tourlist.model.SigunguDto;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;

@Mapper
public interface TourListMapper {
	
	List<DoDto> sidoList() throws SQLException;
	List<SigunguDto> gugunList(int areaCode) throws SQLException;
	TourListDto recommend(int contentTypeId) throws SQLException;
	List<TourListDto> getData(Map<String, Integer> map) throws SQLException;
	
}

/*
	sql.append("select title, addr1, mapx, mapy, image, tel, zipcode \n");
	sql.append("from tour_list \n");
	sql.append("where area_code = ? and sigungu_code = ? \n");
*/