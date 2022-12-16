package com.ssafy.enjoytrip.board.controller;

import java.util.List;
import java.util.Map;

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

import com.ssafy.enjoytrip.board.model.BoardDto;
import com.ssafy.enjoytrip.board.model.service.BoardService;

@RestController
@RequestMapping("/board")
public class BoardController{
	
	private final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	private BoardService boardService;

	@Autowired
	public BoardController(BoardService boardService) {
		this.boardService = boardService;
	}
	
	@GetMapping("/preview")
	public ResponseEntity<?> preview() { 
		try {
			List<BoardDto> list = boardService.preview(3); 
			logger.info("{}", list);
			if (list != null && !list.isEmpty()) {
				return new ResponseEntity<List<BoardDto>>(list, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@GetMapping("/list")
	public ResponseEntity<?> list(@RequestParam Map<String, String> param) { 
		logger.info("{}", param);
		try {
			Map<String, Object> list = boardService.listArticle(param);
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
	
	@PostMapping
	public ResponseEntity<?> register(@RequestBody BoardDto boardDto) { 
//		UserDto userDto = (UserDto) session.getAttribute("userinfo");
//		logger.info("{}", userDto);
//		boardDto.setUserId(userDto.getId());
		logger.info("{}", boardDto);
		try {
			int result = boardService.writeArticle(boardDto);
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@PutMapping
	public ResponseEntity<?> modify(@RequestBody BoardDto boardDto) { 
//		UserDto userDto = (UserDto) session.getAttribute("userinfo");
//		boardDto.setUserId(userDto.getId());
//		logger.info("{}", boardDto);
		try {
			boardService.modifyArticle(boardDto);
			return new ResponseEntity<Integer>(1, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@GetMapping("/view/{articleNo}")
	public ResponseEntity<?> view(@PathVariable int articleNo) { 
		logger.info("{}", articleNo);
		try {
			BoardDto boardDto = boardService.getArticle(articleNo);
			boardService.updateHit(articleNo);
			logger.info("{}", boardDto);
			if (boardDto != null) {
				return new ResponseEntity<BoardDto>(boardDto, HttpStatus.OK); 
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
			boardService.deleteArticle(articleNo);
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