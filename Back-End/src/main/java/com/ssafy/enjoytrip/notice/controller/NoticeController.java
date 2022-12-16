package com.ssafy.enjoytrip.notice.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.notice.model.NoticeDto;
import com.ssafy.enjoytrip.notice.model.service.NoticeService;

@RestController
@RequestMapping("/notice")
public class NoticeController extends HttpServlet {
	private final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	private static final long serialVersionUID = 1L;

	private final NoticeService noticeService;

	@Autowired
	public NoticeController(NoticeService noticeService) {
		this.noticeService = noticeService;
	}
	
	@PostMapping(value="/write")
	public ResponseEntity<?> writeArticle(@RequestBody NoticeDto noticeDto){
		try {
			int result = noticeService.writeArticle(noticeDto);
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@GetMapping("/list")
	public ResponseEntity<?> list(@RequestParam Map<String, String> param) { 
		logger.info("{}", param);
		try {
			Map<String, Object> list = noticeService.listArticle(param);
			logger.info("{}", list);
			if (list != null && !list.isEmpty()) {
				return new ResponseEntity<Map<String, Object>>(list, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		}
	}
	
	@GetMapping("/preview")
	public ResponseEntity<?> preview() { 
		try {
			List<NoticeDto> list = noticeService.preview(3); 
			logger.info("{}", list);
			if (list != null && !list.isEmpty()) {
				return new ResponseEntity<List<NoticeDto>>(list, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@GetMapping("/view/{articleNo}")
	public ResponseEntity<?> view(@PathVariable int articleNo) { 
		logger.info("{}", articleNo);
		try {
			NoticeDto noticeDto = noticeService.getArticle(articleNo);
			noticeService.updateHit(articleNo);
			logger.info("{}", noticeDto);
			if (noticeDto != null) {
				return new ResponseEntity<NoticeDto>(noticeDto, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@DeleteMapping("/view/{articleNo}")
	public ResponseEntity<?> delete(@PathVariable int articleNo) { 
		logger.info("{}", articleNo);
		try {
			noticeService.deleteArticle(articleNo);
			return new ResponseEntity<Integer>(1, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@PutMapping("/modify")
	public ResponseEntity<?> modify(@RequestBody NoticeDto noticeDto) { 
		logger.info("{}", noticeDto);
		try {
			noticeService.modifyArticle(noticeDto);
			return new ResponseEntity<Integer>(1, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	private ResponseEntity<String> exceptionHandling(Exception e) {
		return new ResponseEntity<String>("Error : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
