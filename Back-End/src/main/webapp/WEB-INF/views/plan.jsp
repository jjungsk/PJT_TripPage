<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="${root}/assets/css/plan.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- 일정 start -->
<section id="plan-section" class="d-flex flex-row">
	<!-- 좌측 일정 목록 시작 -->
	<div id="plan-list" class="mx-1">
		<div id="plan-list-inner">
			<div class="mb-2">
	          <label for="subject" class="form-label plan-regist">제목 : </label>
	          <input
	            type="text"
	            class="form-control plan-regist"
	            id="write-subject"
	            name="subject"
	            placeholder="일정 제목"
	          />
	          <h4 class="text-center text-secondary plan-view" id="view-title" style="display: none;">타이틀</h4>
	        </div>
	        <div class="mb-2">
	          <label for="content" class="form-label plan-regist">내용 : </label>
	          <textarea class="form-control plan-regist" id="write-content" name="content" rows="5"></textarea>
	          <div class="text-secondary plan-view" id="view-content" style="display: none;">일정 내용입니다.</div>
	        </div>
			
			<div id="left-list">
				<div class="mb-2">
					<div class="text-center plan-regist">선택목록 </div>
					<div class="text-center plan-view" style="display: none;">장소목록 </div>
				</div>
				<div class="mt-2">
					<ul id="left-select-spots-list" class="plan-regist"></ul>
					<ul id="left-spots-list" class="plan-view" style="display: none;"></ul>
				</div>
			</div>
			
			<div class="text-center">
				<button type="button" id="btn-plan-register" class="btn btn-primary plan-regist" onclick="planRegist()">
		                일정 등록
		        </button>
		        <button type="button" id="btn-mv-plan-register" class="btn btn-primary plan-view" onclick="showPlanRegist()" style="display: none;">
		                일정 등록하러 가기
		        </button>
			</div>
		</div>
	</div>
	<!-- 좌측 일정 목록 끝 -->
	<!-- 가운데 지도 시작 -->
	<div id="plan-map">
		<div id="map" style="width:100%; height:100vh;"></div>
	</div>
	<!-- 가운데 지도 끝 -->
	<!-- 우측 장소 검색 시작 -->
	<div id="plan-search">
		<div id="plan-searchbar" class="input-group input-group-sm">
          <input
            type="text"
            class="form-control"
            id="plan-word"
            placeholder="검색어를 입력하세요."
          />
          <button id="btn-plan-search" class="btn" type="button" onclick="search()">
            <span class="material-symbols-outlined">
				search
			</span>
          </button>
        </div>
        
        <div id="options-plan" class="d-flex">
	        <input type="radio" class="btn-check" name="options-plan" id="option-plan-recommend" autocomplete="off" checked onclick="getRecommends()">
			<label class="btn btn-secondary" for="option-plan-recommend">장소 추천</label>
			<input type="radio" class="btn-check" name="options-plan" id="option-plan-list" autocomplete="off" onclick="getPlans()">
			<label class="btn btn-secondary" for="option-plan-list">일정 목록</label>
        </div>
		
		<div id="right-list">
			<div class="text-center mt-2">
				<span id="search-title">추천 장소</span>
				<span id="search-count"></span>
			</div>
			<div class="mt-2">
				<ul id="spots-list">
				</ul>
			</div>
		</div>
		
		
	</div>
	<!-- 우측 장소 검색 끝 -->
</section>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84438603ef15ec1f521f260675951d5f"
></script>
<!--   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84438603ef15ec1f521f260675951d5f&libraries=services" -->
<script>
	window.onload = function() {
		getRecommends();
		showPlanRegist();
	};

	// 추천장소 얻어오기
	function getRecommends() {
		fetch(`${root}/plan/recommend`)
      	.then(response => response.json())
      	.then(data => {
    	    showList(data, 'recommend');
      	});
	}
	
	// 일정목록 가져오기
	function getPlans() {
		fetch(`${root}/plan/list`)
      	.then(response => response.json())
      	.then(data => {
    	    showList(data, 'listPlan');
      	});
	}
	
	// 일정 보기
	function viewPlan(el) {
		let planNo = el.parentNode.parentNode.parentNode.getAttribute("data-plan-no");
		fetch(`${root}/plan/` + planNo)
      	.then(response => response.json())
      	.then(data => {
    	    showPlan(data);
    	    getPlans();
      	});
	}
	
	// 장소 검색
	function search() {
		let word = document.querySelector("#plan-word").value;
		if (!word) {
       		alert("검색어를 입력해주세요.");
       		return;
       	}
		fetch(`${root}/plan/search?word=` + word)
      	.then(response => response.json())
      	.then(data => {
    	    showList(data, 'search');
      	});
	}
	
	document.querySelector("#plan-word").addEventListener('keyup', function(e) {
		if (e.keyCode == 13) {
			search();
		}
	})
	
	// 일정 등록
	function planRegist() {
		// planSubject planContent planInforms(contentId(등록할떈 이거만 보내기), mapx, mapy, image, title)
		let planSubject = document.querySelector("#write-subject").value;
 	    let planContent = document.querySelector("#write-content").value;
 	    if (!planSubject) {
       		alert("제목을 입력해주세요.");
       		return;
       	} else if (!planContent) {
       		alert("내용을 입력해주세요.");
       		return;
       	}
 	    
 	    let spots = document.querySelector("#left-select-spots-list").children;
 	   	if (spots.length == 0) {
      		alert("장소를 추가해주세요.");
      		return;
      	}
 	   	
 	   	planInforms = [];
 	    [].slice.call(spots).forEach( function(child) {
 	   			planInforms.push({"contentId":child.getAttribute("data-content-id")});
 	   		}
 	   	)
 	    
 	    let registerInfo = {
    		planSubject: planSubject,
    		planContent: planContent,
    		planInforms: planInforms
        };
 	   	
        let config = {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(registerInfo),
        };
        fetch(`${root}/plan/regist`, config)
          .then((response) => response.text())
          .then((data) => {
        	  if(data == '1') {
        		  alert("일정을 등록하였습니다.");
        		  //viewPlan하기 plan-no 어떻게 가져오지?
        		  document.querySelector("#view-title").innerHTML = planSubject;
        		  document.querySelector("#view-content").innerHTML = planContent;
				  document.querySelector("#left-spots-list").innerHTML = document.querySelector("#left-select-spots-list").innerHTML;
				  // 하위 button 태그 지우기
				  document.querySelectorAll("#left-spots-list button").forEach(function(btnEl) {
					  btnEl.remove();
				  });
				  document.querySelector("#write-subject").value = '';
				  document.querySelector("#write-content").value = '';
				  document.querySelector("#left-select-spots-list").innerHTML = '';
        		  document.querySelectorAll(".plan-view").forEach(function(el) {
       				el.style.display = "";
       			})
       			document.querySelectorAll(".plan-regist").forEach(function(el) {
       				el.style.display = "none";
       			})
       			
        	  } else {
        		  alert("등록에 실패하였습니다.");
        	  }
        });
	}
	
	// 좌측 일정정보 보여주기
	function showPlan(data) {
		document.querySelector("#view-title").innerHTML = data.planSubject;
		document.querySelector("#view-content").innerHTML = data.planContent;
		
		let bodycontent = ``;
		data.planInforms.forEach(function(spot) {
			bodycontent += `
				<li class="spot-card mb-2" data-content-id="\${spot.contentId}" data-mapx="\${spot.mapx}" data-mapy="\${spot.mapy}">
					<div class="card">
					  <div class="card-img-wrap">
						  <div class="card-img"><img class="card-img-top" src="\${spot.image}" alt="Card image"></div>
					  </div>
					  <div class="card-body">
					      <div class="card-title">\${spot.title}</div>
					  </div>
					</div>
				</li>
			`;
		})
		document.querySelector("#left-spots-list").innerHTML = bodycontent;
		
		document.querySelectorAll(".plan-view").forEach(function(el) {
			el.style.display = "";
		})
		document.querySelectorAll(".plan-regist").forEach(function(el) {
			el.style.display = "none";
		})
	}
	
	// 일정등록화면 보여주기
	function showPlanRegist() {
		//document.querySelector("#write-subject").value = '';
		//document.querySelector("#write-content").value = '';
		document.querySelector("#left-spots-list").innerHTML = '';
		document.querySelectorAll(".plan-view").forEach(function(el) {
			el.style.display = "none";
		})
		document.querySelectorAll(".plan-regist").forEach(function(el) {
			el.style.display = "";
		})
		showMapLine();
	}
	
	// 우측 장소결과 보여주기
	function showList(list, inst) {
		let searchTitle = document.querySelector("#search-title");
		if (inst == 'recommend') {
			searchTitle.innerHTML = '추천 장소';
		} else if (inst == 'search') {
			searchTitle.innerHTML = '검색 결과';
			document.querySelector("#search-count").innerHTML = '(' + list.length + '건)';
		} else if (inst == 'listPlan') {
			searchTitle.innerHTML = "";
			document.querySelector("#search-count").innerHTML = "";
		}
		
    	let bodycontent = ``;
    	if (inst == 'listPlan') {
    		list.forEach(function(plan) {
    			console.log(plan.planInforms[0].image);
    			if (plan.planInforms[0].image == 0) {
    				plan.planInforms[0].image = "${root}/assets/img/no-image-found.png";
    			}
    			
	    		bodycontent += `
	    			<li class="spot-card mb-2" data-plan-no="\${plan.planNo}" data-user-id="\${plan.userId}">
						<div class="card">
						  <div class="card-img-wrap">
							  <div class="card-img"><img class="card-img-top" src="\${plan.planInforms[0].image}" alt="Card image"></div>
							  <div class="card-img-text d-flex">
						          <div class="material-symbol-location-on material-symbols-outlined" style="font-size: 16px;">
									location_on
								  </div><div>\${plan.hit}</div>
					          </div>
						  </div>
						  <div class="card-body">
						      <div class="card-title">\${plan.planSubject}</div>
							  <button class="btn-card-add" type="button" onclick="viewPlan(this)">
					            <div class="material-symbols-outlined">
								expand_content
								</div>
					          </button>
						  </div>
						</div>
					</li>
	    		`;
	    	})
    	} else {
	    	list.forEach(function(spot) {
    			console.log(spot.image);
    			if (spot.image == 0) {
    				spot.image = "${root}/assets/img/no-image-found.png";
    			}
	    		bodycontent += `
	    			<li class="spot-card mb-2" data-content-id="\${spot.contentId}" data-mapx="\${spot.mapx}" data-mapy="\${spot.mapy}" onmouseover="panTo(this)" onmouseout="removeMarker()">
						<div class="card">
						  <div class="card-img-wrap">
							  <div class="card-img"><img class="card-img-top" src="\${spot.image}" alt="Card image"></div>
						  </div>
						  <div class="card-body">
						      <div class="card-title">\${spot.title}</div>
							  <button class="btn-card-add" type="button" onclick="addSpot(this)">
					            <div class="material-symbols-outlined">
								add
								</div>
					          </button>
						  </div>
						</div>
					</li>
	    		`;
	    	})
    	}
    	
    	document.querySelector("#spots-list").innerHTML = bodycontent;
    }
	
	// 좌측 선택목록에 장소 추가
	function addSpot(el) { // contentid mapx mapy title image
		let title = el.parentNode.children[0].innerHTML;
		let image = el.parentNode.parentNode.children[0].children[0].children[0].getAttribute("src");
		let liEle = el.parentNode.parentNode.parentNode;
		let contentId = liEle.getAttribute("data-content-id");
		let mapx = liEle.getAttribute("data-mapx");
		let mapy = liEle.getAttribute("data-mapy");
		let bodycontent = document.querySelector("#left-select-spots-list").innerHTML;
		bodycontent += `
			<li class="spot-card mb-2" data-content-id="\${contentId}" data-mapx="\${mapx}" data-mapy="\${mapy}">
				<div class="card">
				  <div class="card-img-wrap">
					  <div class="card-img"><img class="card-img-top" src="\${image}" alt="Card image"></div>
				  </div>
				  <div class="card-body">
				      <div class="card-title">\${title}</div>
					  <button class="btn-card-add" type="button" onclick="minusSpot(this)">
			            <div class="material-symbols-outlined">
						delete
						</div>
			          </button>
				  </div>
				</div>
			</li>
		`;
		document.querySelector("#left-select-spots-list").innerHTML = bodycontent;
		addLine(mapx, mapy);
	}
	
	// 좌측 선택목록에 장소 제거
	function minusSpot(el) {
		let liEle = el.parentNode.parentNode.parentNode; 
		removeLine(liEle.getAttribute("data-mapx"), liEle.getAttribute("data-mapy"));
		liEle.remove();
	}

	
	// 지도
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 5 // 지도의 확대 레벨
	};
	
	//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	//마커 배열
	var marker;
	
	// 지도 중심좌표 부드럽게 이동시키기 + 마커 표시
	function panTo(el) {
		let lat = el.getAttribute("data-mapy");
		let lng = el.getAttribute("data-mapx");
		
	    // 이동할 위도 경도 위치를 생성합니다 
	    let moveLatLon = new kakao.maps.LatLng(lat, lng);
	    
	    // 마커 생성
	    marker = new kakao.maps.Marker({
	        position: moveLatLon
	    });
	    marker.setMap(map);
	    
	    // 지도 중심을 부드럽게 이동시킵니다
	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    map.panTo(moveLatLon);            
	}
	
	// 모든 마커 지우기
	function removeMarker() {
		marker.setMap(null);
	}
	
	// 지도에 경로 그리기
	let drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
	let mapLine; // 마우스로 클릭한 좌표로 그려질 선 객체입니다
	let dots = []; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
	
	function addLine(lng, lat) {
		deleteMapLine();
		deleteDotOverlays();
		let latlng = new kakao.maps.LatLng(lat, lng);
		dots.push({latlng: latlng});
		drawLine();
	}
	
	function removeLine(lng, lat) {
		deleteMapLine();
		deleteDotOverlays();
		dots.forEach(function(dot, i) {
			if (lat == dot.latlng.Ma && lng == dot.latlng.La) {
				dots.splice(i, 1);
			}
		})
		drawLine();
	}
	
	function showMapLine() {
		deleteMapLine();
		deleteDotOverlays();
		dots = [];
		
		[...document.getElementById('left-select-spots-list').children].forEach(function(liEle) {
			let latlng = new kakao.maps.LatLng(liEle.getAttribute('data-mapy'), liEle.getAttribute('data-mapx'));
			dots.push({latlng: latlng});
		})
		
		drawLine();
	}
	
	function drawLine() {
		dots.forEach(function(dot, i) {
			let distance = 0;
			
			if (i == 0) {
				mapLine = new kakao.maps.Polyline({
		            map: map, // 선을 표시할 지도입니다 
		            path: [dot.latlng], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
		            strokeWeight: 3, // 선의 두께입니다 
		            strokeColor: '#db4040', // 선의 색깔입니다
		            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		            strokeStyle: 'solid' // 선의 스타일입니다
		        });
		    	
				distance = 0;
				
			} else {
				// 그려지고 있는 선의 좌표 배열을 얻어옵니다
		        let path = mapLine.getPath();

		        // 좌표 배열에 클릭한 위치를 추가합니다
		        path.push(dot.latlng);
		        
		        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
		        mapLine.setPath(path);

		        distance = Math.round(mapLine.getLength());
			}
			
			// 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
		    let circleOverlay = new kakao.maps.CustomOverlay({
		        content: '<span class="dot"></span>',
		        position: dot.latlng,
		        zIndex: 1
		    });

		    // 지도에 표시합니다
		    circleOverlay.setMap(map);
			
		    if (distance > 0) {
		        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
		        let distanceOverlay = new kakao.maps.CustomOverlay({
		            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
		            position: dot.latlng,
		            yAnchor: 1,
		            zIndex: 2
		        });

		        // 지도에 표시합니다
		        distanceOverlay.setMap(map);
			    dot.distance = distanceOverlay;
		    }

		    // 배열에 추가합니다
		    dot.circle = circleOverlay;
		})
	}
	
	function deleteMapLine() {
		if (mapLine) {
			mapLine.setMap(null);
			mapLine = null;
		}
	}
	
	function deleteDotOverlays() {
		dots.forEach(function(dot) {
			if (dot.circle) {
				dot.circle.setMap(null);
			}
			if (dot.distance) {
				dot.distance.setMap(null);
			}
		})
	}
	

</script>
<%-- <script src="${root}/assets/js/plan.js"></script> --%>
<!-- 일정 end -->
<%@include file="/WEB-INF/views/common/footer.jsp"%>