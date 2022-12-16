package com.ssafy.enjoytrip;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@Controller
//@ControllerAdvice
public class ExceptionControllerAdvice implements ErrorController {

	private final Logger logger = LoggerFactory.getLogger(ExceptionControllerAdvice.class);

//	@ExceptionHandler(Exception.class)
	@GetMapping("/error")
	public String handleError(Model model) {
//		logger.error("Exception 발생 : {}", ex.getMessage());
		model.addAttribute("msg", "처리중 에러 발생!!!");
		return "error/error";
	}

//	@ExceptionHandler(NoHandlerFoundException.class)
//	@ResponseStatus(value = HttpStatus.NOT_FOUND)
//	public String handle404(NoHandlerFoundException ex, Model model) {
//		logger.error("404 발생 : {}", "404 page not found");
//		model.addAttribute("msg", "해당 페이지를 찾을 수 없습니다!!!");
//		return "error/error";
//	}

}