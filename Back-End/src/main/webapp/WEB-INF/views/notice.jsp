<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link href="${root}/assets/css/notice.css" rel="stylesheet" />
<!-- 공지사항 start -->
<section class="container px-4 px-lg-5 mt-5 pt-5 justify-content-center">
	<div class="row justify-content-center">
		<div class="col-md-10 col-12">
			<h2 class="my-3 py-3 shadow p-3 mb-5 bg-white rounded text-center">
				<p class="fw-bold">공지사항</p>
			</h2>
		</div>
		<div class="col-md-10 col-sm-12">
			<div class="row align-self-center mb-2">
				<div class="col-md-5">
					<c:if test="${userinfo != null && userinfo.isManager != 0}">
						<button type="button" id="btn-admin-mv-register"
							data-bs-toggle="modal" data-bs-target=""
							class="btn btn-primary mb-3" style="line-height: 10px">글쓰기</button>
					</c:if>
				</div>
				<div class="col-md-7">
					<form class="d-flex" id="form-search" method="get" action="">
						<input type="hidden" id="current-page" name="pgno" value="1" /> <select
							class="form-select form-select-sm ms-5 me-1 w-50" id="key"
							name="key" aria-label="검색조건">
							<option value="" selected>검색조건</option>
							<option value="subject">제목</option>
							<option value="userid">작성자</option>
						</select>
						<div class="input-group input-group-sm">
							<input type="text" class="form-control" id="word" name="word"
								placeholder="검색어..." />
							<button id="btn-search" class="btn btn-dark" type="button">
								검색</button>
						</div>
					</form>
				</div>
			</div>
			<table class="table table-hover">
				<thead>
					<tr class="text-center">
						<th scope="col">글번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">조회수</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody id="notice-tbody">
				</tbody>
			</table>
		</div>
		<div class="row">
			<ul class="pagination justify-content-center" id="notice-pagination">
			</ul>
		</div>
	</div>
	<%-- 	<form id="form-no-param" method="get" action="${root}/notice">
		<input type="hidden" id="act" name="act" value="view" /> <input
			type="hidden" id="pgno" name="pgno" value="${param.pgno}" /> <input
			type="hidden" id="key" name="key" value="${param.key}" /> <input
			type="hidden" id="word" name="word" value="${param.word}" /> <input
			type="hidden" id="articleno" name="articleno" value="" />
	</form> --%>

	<!-- 관리자 글쓰기 modal start -->
	<div class="modal fade" id="admin-write-modal"
		data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">글쓰기</h4>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form id="admin-write-form" method="post" action="">
						<div class="mb-3">
							<label for="subject" class="form-label">제목 : </label> <input
								type="text" class="form-control" id="admin-write-subject"
								name="subject" placeholder="제목..." />
						</div>
						<div class="mb-3">
							<label for="content" class="form-label">내용 : </label>
							<textarea class="form-control" id="admin-write-content"
								name="content" rows="10"></textarea>
						</div>
					</form>
				</div>
				<!-- Modal footer -->
				<div id="modify-article-no" style="display: none;"></div>
				<div class="modal-footer col-auto text-center">
					<button type="button" id="btn-admin-register"
						class="btn btn-outline-primary mb-3">글작성</button>
					<button type="button" id="btn-admin-modify"
						class="btn btn-outline-primary mb-3">글수정</button>
					<button type="button" class="btn btn-outline-dark mb-3"
						id="btn-notice-info-cancel" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 관리자 글쓰기 modal end -->

	<!-- 글 상세보기 modal start -->
	<div class="modal fade" id="articleViewModal" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title text-center text-secondary"
						id="admin-view-subject"></h4>
				</div>
				<!-- Modal body -->
				<div class="modal-body col-md-12">
					<div class="">
						<div class="col-md-8 clearfix align-content-center">
							<img class="avatar me-2 float-md-start bg-light p-2"
								src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg" />
							<p>
								<span class="fw-bold" id="admin-view-user-id"></span> <br /> <span
									class="text-secondary fw-light" id="admin-view-register-time">
								</span>
							</p>
							<div class="col-md-4 text-end" id="admin-view-hit"></div>
						</div>
					</div>
				</div>
				<div class="divider mb-3"></div>
				<div class="text-secondary" id="admin-view-content" style="height: auto; margin-left: 10px"></div>
				<div class="divider mt-3 mb-3"></div>
				<div id="admin-view-article-no" style="display: none;"></div>
				<div class="d-flex justify-content-end"></div>
				<!-- Modal footer -->
				<div id="autho-admin-only" class="modal-footer col-auto text-center" style="display: ">
					<button type="button"
						class="btn btn-outline-primary mb-3 me-2 btn-mv-list"
						id="btn-admin-mvlist" data-bs-dismiss="">글목록</button>
					<button type="button" id="btn-admin-mv-modify"
						class="btn btn-outline-primary mb-3" data-dismiss="modal">글수정</button>
					<button type="button" id="btn-admin-delete"
						class="btn btn-outline-danger mb-3 ms-1">글삭제</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 글 상세보기 modal end -->

	<script>
		// 첫 페이지 정보 가져오기
	  	window.onload = function() {
	     	getTarget(1);
	     };
	
	    // 관리자 글쓰기
	    document.querySelector("#btn-admin-register").addEventListener("click", function () {
			let subject = document.querySelector("#admin-write-subject").value;
		 	let content = document.querySelector("#admin-write-content").value;
		 	if (!subject) {
		 		alert("제목을 입력해주세요.");
		 		return;
		 	} else if (!content) {
		 		alert("내용을 입력해주세요.");
		 		return;
		 	}
		 	
		 	let registerInfo = {
		    	subject: subject,
		    	content: content,
		  	};
		  	let config = {
		    	method: "POST",
		    	headers: { "Content-Type": "application/json" },
		    	body: JSON.stringify(registerInfo),
		  	};
		  	fetch(`${root}/notice/write`, config)
		    	.then((response) => response.text())
		    	.then((data) => {
		  	  		if(data == '1') {
		  		  	// windowList();
		  		  	document.querySelector('#key').value = "";
		  		  	document.querySelector('#word').value = "";
		     	   	// getTarget(1);
		  	  		} else {
		  				alert("등록에 실패하였습니다.");
		  	  		}
		  	  		location.reload();
			  	  	let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('admin-write-modal'));
	    	    	modal.hide();
		    	});
			});
	    
	       	// 조건에 맞는 글목록 불러오기
	       	document.querySelector("#btn-search").addEventListener("click", function () {
	        	getTarget(1);
	       	});
	    
		     // 글 상세 보기
		     function mvView(articleno) {
		         
		      	fetch(`${root}/notice/view/\${articleno}`)
		      	.then(response => response.json())
		      	.then(data => {
		      		
		      		document.getElementById("admin-view-article-no").innerHTML = data.articleNo;
		      		document.getElementById("admin-view-subject").innerHTML = data.subject;
		      		document.getElementById("admin-view-user-id").innerHTML = "작성자 : " + data.userId;
		      		document.getElementById("admin-view-register-time").innerHTML = data.registerTime;
		      		document.getElementById("admin-view-hit").innerHTML = "조회수 : " + data.hit;
		      		document.getElementById("admin-view-content").innerHTML = data.content;
		      		
		      		// userid 가 admin인 경우만 notice 글삭제 & 글수정 권한을 갖는다
		      		let currentuserid = document.querySelector("#info-id").value;
		      		if (currentuserid == data.userId) {
		      			document.querySelector("#btn-admin-mv-modify").style.display = "";
		      			document.querySelector("#btn-admin-delete").style.display = "";
		      		} else {
		      			document.querySelector("#btn-admin-mv-modify").style.display = "none";
		      			document.querySelector("#btn-admin-delete").style.display = "none";
		      		}
		    	    
		      		let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('articleViewModal'));
		      		modal.show();
		      	});
		     }
		     
		     // Move -> 글 목록으로
		     document.querySelector("#btn-admin-mvlist").addEventListener("click", function () {
		      		getTarget(document.querySelector("#current-page").value); // 조회수 업데이트
		      		
		      		let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('articleViewModal'));
		      		modal.hide();
			      });
		     
		     // Move -> 글쓰기 화면으로
		     document.querySelector("#btn-admin-mv-register").addEventListener("click", function () {
	      		let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('admin-write-modal'));
	      		modal.show();
        	    document.getElementById("btn-admin-register").style.display = "";
           	    document.getElementById("btn-admin-modify").style.display = "none";
                document.querySelector("#admin-write-subject").value = "";
         	    document.querySelector("#admin-write-content").value = "";
		      });
		     
		     // Move -> 글수정 화면으로
		     document.querySelector("#btn-admin-mv-modify").addEventListener("click", function () {
		     	let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('articleViewModal'));
		      	modal.hide();
	      		modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('admin-write-modal'));
	      		modal.show();
        	    document.getElementById("btn-admin-register").style.display = "none";
           	    document.getElementById("btn-admin-modify").style.display = "";
		   	    document.querySelector("#admin-write-subject").value = document.getElementById("admin-view-subject").innerHTML;
		   	    document.querySelector("#admin-write-content").value = document.getElementById("admin-view-content").innerHTML;
		   	    document.querySelector("#modify-article-no").innerHTML = document.getElementById("admin-view-article-no").innerHTML;
		      });
		     
		  	   // 글수정
		       document.querySelector("#btn-admin-modify").addEventListener("click", function () {
		    	   let subject = document.querySelector("#admin-write-subject").value;
		    	   let content = document.querySelector("#admin-write-content").value;
		    	   let articleNo = document.querySelector("#modify-article-no").innerHTML;
		    	   
		    	   if (!subject) {
			       		alert("제목을 입력해주세요.");
			       		return;
			       	} else if (!content) {
			       		alert("내용을 입력해주세요.");
			       		return;
			       	}
		    	   let modifyInfo = {
			          subject: subject,
			          content: content,
			          articleNo: articleNo
			        };
			        let config = {
			          method: "PUT",
			          headers: { "Content-Type": "application/json" },
			          body: JSON.stringify(modifyInfo),
			        };
			        fetch(`${root}/notice/modify`, config)
			          .then((response) => response.text())
			          .then((data) => {
			        	  if(data == '1') {
			        		  // windowList();
			           	   	  getTarget(document.querySelector("#current-page").value);
			        	  } else {
			        		  alert("수정에 실패하였습니다.");
			        	  }
			        	// location.reload();
			      		let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('admin-write-modal'));
			      		modal.hide();
			          });
		       });
		       
		       // 글삭제
		       document.querySelector("#btn-admin-delete").addEventListener("click", function () {
		    	   if (confirm("정말 삭제하시겠습니까?")) {
		    		   let articleNo = document.getElementById("admin-view-article-no").innerHTML;
		    	        let config = {
		    	          method: "DELETE",
		    	        };
		    	        fetch(`${root}/notice/view/\${articleNo}`, config)
		    	          .then((response) => response.text())
		    	          .then((data) => {
		    	        	  if(data == '1') {
		    	        		  // windowList();
		    	        		  document.querySelector('#key').value = "";
		    	        		  document.querySelector('#word').value = "";
		    	           	   	  getTarget(1);
		  			      		  let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('articleViewModal'));
		  			      		  modal.hide();
		    	        	  } else {
		    	        		  alert("삭제 실패하였습니다.");
		    	        	  }
		   	            });
		    	   }
		       });
	    
	       // 페이지에 맞는 글목록과 페이지네이션 처리
	       function getTarget(page) {
	    	   document.querySelector("#current-page").value = page;
	           let key = document.querySelector('#key').value;
	           let word = document.querySelector('#word').value;
	             
	           let listInfo = {
	           	pgno: page,
	           	key: key,
	           	word: word
	           }
	           
	       	fetch("${root}/notice/list?" + new URLSearchParams(listInfo))
	       	.then(response => response.json())
	       	.then(data => {
	       		showList(data.list);
	       		paging(data.paginationInfo);
	       	});
	       }
	       
	       // 글목록 보여주기
	       function showList(list) {
	       	let bodycontent = ``;
	       	list.forEach(function(article) {
	       		bodycontent += `
	       			<tr class="text-center">
	       		      <th scope="row">\${article.articleNo}</th>
	       		      <td class="text-start">
	       		        <a
	       		          href="#"
	       		          onclick="mvView(\${article.articleNo})"
	       		          class="article-title link-dark"
	       		          data-no="\${article.articleNo}"
	       		          style="text-decoration: none"
	       		        >
	       		            \${article.subject}
	       		        </a>
	       		      </td>
	       		      <td>\${article.userId}</td>
	       		      <td>\${article.hit}</td>
	       		      <td>\${article.registerTime}</td>
	       		    </tr>
	       		`;
	       	})
	       	document.querySelector("#notice-tbody").innerHTML = bodycontent;
	       }
	   
	       // pagination
	       function paging(pagingInfo) {
	          	let currentPage = pagingInfo.currentPage;
	          	const dataPerPage = pagingInfo.dataPerPage;
	          	const pageCount = pagingInfo.pageCount;
	          	const totalData = pagingInfo.totalData;

	          	const totalPage = Math.ceil(totalData / dataPerPage); // 총 몇페이지로 이루어져 있는지
	          	const pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹

	          	let first = (pageGroup - 1) * pageCount + 1;
	          	let last = pageGroup * pageCount;
	          	if (last > totalPage) last = totalPage;
	          	
	          	const next = last + 1;
	          	const prev = first - 1;

	          	if (totalPage < 1) first = last;

	          	let pageContent = ``;
	          	if (first > pageCount) {
	          		pageContent += `
	          			<li class="page-item">
	                      	<a class="page-link" onclick="getTarget(\${prev})">이전</a>
	                    	</li>
	          		`;
	          	}
	          	for (let idx = first; idx <= last; idx++) {
	          		if (currentPage == idx) {
	          			pageContent += `
	          				<li class="page-item active"><a class="page-link" onclick="getTarget(\${idx})">\${idx}</a></li>
	          			`;
	          		} else if (idx > 0) {
	          			pageContent += `
	          				<li class="page-item"><a class="page-link" onclick="getTarget(\${idx})">\${idx}</a></li>
	          			`;
	          		}
	          	}
	          	if (next > pageCount && last < totalPage) {
	          		pageContent += `
	          			<li class="page-item"><a class="page-link" onclick="getTarget(\${next})">다음</a></li>
	          		`;
	          	}

	          	document.querySelector("#notice-pagination").innerHTML = pageContent;
	          };

  </script>
</section>
<!-- 공지사항 end -->
<%@include file="/WEB-INF/views/common/footer.jsp"%>
