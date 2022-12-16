package com.ssafy.enjoytrip.tourlist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.tourlist.model.DoDto;
import com.ssafy.enjoytrip.tourlist.model.SigunguDto;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;
import com.ssafy.enjoytrip.tourlist.model.service.TourListService;

@RestController
@RequestMapping("/tour")
public class TourListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	private Logger logger = LoggerFactory.getLogger(TourListController.class);
	
	private final TourListService tourListService;

	@Autowired
	public TourListController(TourListService tourListService) {
		this.tourListService = tourListService;
	}
	
	@GetMapping("/list") // 초기 시도 list 받아오기
	public ResponseEntity<?> list() {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		List<DoDto> list = null;
		try {
			list = tourListService.sidoList();
			resultMap.put("sidoList", list);
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("message", FAIL);
			status = HttpStatus.ACCEPTED;
		}
		// logger.debug("sidoList : {}", resultMap);
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@GetMapping("/list/{areaCode}") // 시도 정보를 통해 구군 list 받아오기
	private ResponseEntity<?> list(@PathVariable("areaCode") int areaCode) {
		logger.debug("areaCode : {}", areaCode);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		List<SigunguDto> list = null;
		try {
			list = tourListService.gugunList(areaCode);
			resultMap.put("gugunList", list);
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("message", FAIL);
			status = HttpStatus.ACCEPTED;
		}
		// logger.debug("gugunList : {}", resultMap);
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@PostMapping("/getdata")
	private ResponseEntity<?> getData(@RequestBody Map<String, String> data) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		Map<String, Integer> map = new HashMap<>();
		map.put("areaCode", Integer.parseInt(data.get("areaCode")));
		map.put("sigunguCode", Integer.parseInt(data.get("sigunguCode")));
		if (data.containsKey("contentTypeId")) {
			map.put("contentTypeId", Integer.parseInt(data.get("contentTypeId")));
		}
		List<TourListDto> list = null;
		try {
			list = tourListService.getData(map);
			resultMap.put("tourList", list);
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("message", FAIL);
			status = HttpStatus.ACCEPTED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	/*
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String act = request.getParameter("act");

		if ("mvTodaysTour".equals(act)) {
			firstRecommend(request, response, "오늘의 관광지");
		} else if ("todaysTour".equals(act)) {
			recommend(request, response, 12);
		} else if ("mvTodaysFestival".equals(act)) {
			firstRecommend(request, response, "오늘의 행사/공연/축제");
		} else if ("todaysFestival".equals(act)) {
			recommend(request, response, 15);
		} else if ("mvTodaysRestaurant".equals(act)) {
			firstRecommend(request, response, "오늘의 맛집");
		} else if ("todaysRestaurant".equals(act)) {
			recommend(request, response, 39);
		} else if ("mvSun".equals(act)) {
			sun(request, response, "/sun/sun.jsp");
		} else if ("map".equals(act)) {
			getData(request, response);
		} else if ("mvWeather".equals(act)) {
			weather(request, response, "/weather/weather.jsp");
		} else {
			redirect(request, response, "/index.jsp");
		}
	}

	private void list(HttpServletRequest request, HttpServletResponse response) {
		List<DoDto> list = null;

		try {
			list = doService.list();
			ObjectMapper mapper = new ObjectMapper();
			String jsonInString = mapper.writeValueAsString(list);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jsonInString);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void weather(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
		redirect(request, response, path);
		
	}

	private void getData(HttpServletRequest request, HttpServletResponse response) {
		int areaCode = Integer.parseInt(request.getParameter("areaCode"));
		int sigunguCode = Integer.parseInt(request.getParameter("sigunguCode"));
		int contentTypeId = ParameterCheck.notNumberToZero(request.getParameter("contentTypeId"));
		
		Map<String, Integer> map = new HashMap<>();
		map.put("areaCode", areaCode);
		map.put("sigunguCode", sigunguCode);
		map.put("contentTypeId", contentTypeId);
		
		try {
			List<TourListDto> list = tourListService.getData(map);
			ObjectMapper mapper = new ObjectMapper();
			String jsonInString = mapper.writeValueAsString(list);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jsonInString);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	private void sun(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
		redirect(request, response, path);
		
	}

	private void forward(HttpServletRequest request, HttpServletResponse response, String path)
			throws ServletException, IOException {
		RequestDispatcher disp = request.getRequestDispatcher(path);
		disp.forward(request, response);

	}

	private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
		response.sendRedirect(request.getContextPath() + path);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

	private void firstRecommend(HttpServletRequest request, HttpServletResponse response, String key) throws IOException {
		try {
			request.setAttribute("keywordRecommend", key);
			forward(request, response, "/recommend/recommend.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			redirect(request, response, "/index.jsp");
		}

	}

	private void recommend(HttpServletRequest request, HttpServletResponse response, int contentTypeId) {
		TourListDto tourListDto;
		try {
			tourListDto = tourListService.recommend(contentTypeId);
			ObjectMapper mapper = new ObjectMapper();
			String jsonInString = mapper.writeValueAsString(tourListDto);
			response.setContentType("application/json;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jsonInString);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	*/
}
