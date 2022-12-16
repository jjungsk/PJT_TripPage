package com.ssafy.enjoytrip.plan.controller;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.enjoytrip.plan.model.PlanDto;
import com.ssafy.enjoytrip.plan.model.service.PlanService;
import com.ssafy.enjoytrip.tourlist.model.TourListDto;

@RestController
@RequestMapping("/plan")
public class PlanController {
	
	private final Logger logger = LoggerFactory.getLogger(PlanController.class);

	@Autowired
	PlanService planService;
	
	@GetMapping("/recommend")
	public ResponseEntity<?> recommend() { 
		try {
			List<TourListDto> list = planService.recommend(4); 
			logger.info("{}", list);
			if (list != null && !list.isEmpty()) {
				return new ResponseEntity<List<TourListDto>>(list, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@GetMapping("/search")
	public ResponseEntity<?> search(@RequestParam String word) { 
		logger.info("{}", word);
		try {
			List<TourListDto> list = planService.search(word);
			logger.info("{}", list);
			if (list != null && !list.isEmpty()) {
				return new ResponseEntity<List<TourListDto>>(list, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@PostMapping("/regist")
	public ResponseEntity<?> regist(@RequestBody PlanDto planDto) {  
		logger.info("{}", planDto);
		try {
			int result = planService.registPlan(planDto);
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@GetMapping("/list")
	public ResponseEntity<?> list() { 
		try {
			List<PlanDto> list = planService.listPlan();
			logger.info("{}", list);
			if (list != null && !list.isEmpty()) {
				return new ResponseEntity<List<PlanDto>>(list, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@GetMapping("/{planNo}")
	public ResponseEntity<?> view(@PathVariable int planNo) { 
		try {
			PlanDto planDto = planService.getPlan(planNo);
			logger.info("{}", planDto);
			if (planDto != null) {
				return new ResponseEntity<PlanDto>(planDto, HttpStatus.OK); 
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	@DeleteMapping("/{planNo}")
	public ResponseEntity<?> delete(@PathVariable int planNo) { 
		try {
			int result = planService.deletePlan(planNo);
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return exceptionHandling(e);
		} 
	}
	
	private ResponseEntity<String> exceptionHandling(Exception e) {
		return new ResponseEntity<String>("Error : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
