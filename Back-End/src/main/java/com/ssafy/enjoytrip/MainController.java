package com.ssafy.enjoytrip;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	@GetMapping("/board") // 게시판
	public String board() {
		return "board";
	}
	
	@GetMapping("/notice") // 공지사항
	public String notice() {
		return "notice";
	}
	
	@GetMapping("/admin") // 관리자 페이지
	public String admin() {
		return "admin";
	}
	
	@GetMapping("/sun") // 일출일몰 + 날씨
	public String sun() {
		return "sun";
	}
	
	@GetMapping("/plan") // 여행 일정 짜기
	public String plan() {
		return "plan";
	}
	
	@GetMapping("/tourlist") // 여행지 목록
	public String tourlist() {
		return "tourlist";
	}
	
//	@GetMapping("/error")
//	public String handleException(Model model) {
////		logger.error("Exception 발생 : {}", ex.getMessage());
//		model.addAttribute("msg", "처리중 에러 발생!!!");
//		return "error/error";
//	}
	
}
