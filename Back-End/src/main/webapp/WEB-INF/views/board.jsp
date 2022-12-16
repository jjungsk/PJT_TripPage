<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link href="${root}/assets/css/notice.css" rel="stylesheet" />
<!-- 게시판 start -->
<section class="container px-4 px-lg-5 mt-5 pt-5 justify-content-center">
  <div class="row justify-content-center">
    <div class="col-md-10 col-12">
      <h2 class="my-3 py-3 shadow p-3 mb-5 bg-white rounded text-center">
        <p class="fw-bold">게시판</p>
      </h2>
    </div>
    
    <!-- 글목록 시작 -->
 	<div id="section-list" class="col-md-10 col-sm-12">
	    <div>
	      <div class="row align-self-center mb-2">
	        <div class="col-md-5">
	          <button
	            type="button"
	            id="btn-mv-register"
	            class="btn btn-primary mb-3"
	            style="line-height: 10px"
	          >
	            글쓰기
	          </button>
	        </div>
	        <div class="col-md-7">
	          <form class="d-flex" id="form-search" method="get" action="">
	            <input type="hidden" id="current-page" name="pgno" value="1" />
	            <select
	              class="form-select form-select-sm ms-5 me-1 w-50"
	              id="key"
	              name="key"
	              aria-label="검색조건"
	            >
	              <option value="" selected>검색조건</option>
	              <option value="subject">제목</option>
	              <option value="userid">작성자</option>
	            </select>
	            <div class="input-group input-group-sm">
	              <input
	                type="text"
	                class="form-control"
	                name="word"
	                id="word"
	                placeholder="검색어..."
	              />
	              <button id="btn-search" class="btn btn-dark" type="button">
	                검색
	              </button>
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
	        <tbody id="board-tbody">
	        </tbody>
	      </table>
	    </div>
	    <div class="row">
	      <ul class="pagination justify-content-center" id="board-pagination">
	      </ul>
	    </div>
    </div>
    <!-- 글목록 끝 -->
    
    <!-- 글쓰기&글수정 시작 -->
    <div id="section-write" class="col-md-10 col-sm-12" style="display: none;">
          <form id="form-register" method="POST" action="">
            <div class="mb-3">
              <label for="subject" class="form-label">제목 : </label>
              <input
                type="text"
                class="form-control"
                id="write-subject"
                name="subject"
                placeholder="제목..."
              />
            </div>
            <div class="mb-3">
              <label for="content" class="form-label">내용 : </label>
              <textarea class="form-control" id="write-content" name="content" rows="10"></textarea>
            </div>
            <div id="modify-article-no" style="display: none;"></div>
            <div class="col-auto text-center">
              <button type="button" id="btn-register" class="btn btn-outline-primary mb-3">
                글작성
              </button>
              <button type="button" id="btn-modify" class="btn btn-outline-primary mb-3">
                글수정
              </button>
              <button type="button" class="btn btn-outline-danger mb-3 btn-mv-list">
                글목록
              </button>
            </div>
          </form>
    </div>
    <!-- 글쓰기&글수정 끝 -->
    
    <!-- 글보기 시작 -->
    <div id="section-view" class="col-md-10 col-sm-12" style="display: none;">
	    <div class="row my-4">
	      <h2 class="text-center text-secondary" id="view-subject"></h2>
	    </div>
	    <div class="row">
	      <div class="col-md-8">
	        <div class="clearfix align-content-center">
	          <img
	            class="avatar me-2 float-md-start bg-light p-2"
	            src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
	          />
	          <p>
	            <span class="fw-bold" id="view-user-id"></span> <br />
	            <span class="text-secondary fw-light" id="view-register-time">
	            </span>
	          </p>
	        </div>
	      </div>
	      <div class="col-md-4 align-self-center text-end" id="view-hit">
	      </div>
	      <div class="divider mb-3"></div>
	      <div class="text-secondary" id="view-content"></div>
	      <div class="divider mt-3 mb-3"></div>
	      <div id="view-article-no" style="display: none;"></div>
	      <div class="d-flex justify-content-end">
	        <button
	          type="button"
	          class="btn btn-outline-primary mb-3 me-2 btn-mv-list"
	        >
	          글목록
	        </button>
	        <div class="btn-writer-show" style="display: none;">
	          <button
	            type="button"
	            id="btn-mv-modify"
	            class="btn btn-outline-success mb-3 ms-1"
	          >
	            글수정
	          </button>
	          <button
	            type="button"
	            id="btn-delete"
	            class="btn btn-outline-danger mb-3 ms-1"
	          >
	            글삭제
	          </button>
	          </div>
	      </div>
	    </div>
    </div>
    <!-- 글보기 끝 -->
    
  </div>
  
  <script>
  	window.onload = function() {
     	getTarget(1);
     };
     
     // 글쓰기 화면으로 이동
     document.querySelector("#btn-mv-register").addEventListener("click", function () {
  	   document.getElementById("section-list").style.display = "none";
  	   document.getElementById("section-write").style.display = "";
  	   document.getElementById("btn-register").style.display = "";
  	   document.getElementById("btn-modify").style.display = "none";
       document.querySelector("#write-subject").value = "";
	   document.querySelector("#write-content").value = "";
     });
     
     // 글수정 화면으로 이동
     document.querySelector("#btn-mv-modify").addEventListener("click", function () {
   	   document.getElementById("section-view").style.display = "none";
   	   document.getElementById("section-write").style.display = "";
   	   document.getElementById("btn-register").style.display = "none";
   	   document.getElementById("btn-modify").style.display = "";
   	   document.querySelector("#write-subject").value = document.getElementById("view-subject").innerHTML;
   	   document.querySelector("#write-content").value = document.getElementById("view-content").innerHTML;
   	   document.querySelector("#modify-article-no").innerHTML = document.getElementById("view-article-no").innerHTML;
      });
     
     // 글목록으로 이동 (버튼)
     document.querySelectorAll(".btn-mv-list").forEach(btn => {
  	   btn.addEventListener("click", function () {
  	   windowList();
  	   getTarget(document.querySelector("#current-page").value);
     })});
     
     
     // 목록 화면으로 이동 (함수)
     function windowList() {
  	   document.getElementById("section-write").style.display = "none";
  	   document.getElementById("section-view").style.display = "none";
  	   document.getElementById("section-list").style.display = "";
     }
     
     // 글보기
     function mvView(articleno) {
      	fetch(`${root}/board/view/\${articleno}`)
      	.then(response => response.json())
      	.then(data => {
      		document.getElementById("view-article-no").innerHTML = data.articleNo;
      		document.getElementById("view-subject").innerHTML = data.subject;
      		document.getElementById("view-user-id").innerHTML = "작성자 : " + data.userId;
      		document.getElementById("view-register-time").innerHTML = data.registerTime;
      		document.getElementById("view-hit").innerHTML = "조회수 : " + data.hit;
      		document.getElementById("view-content").innerHTML = data.content;
      		if (sessionStorage.getItem("userId") == data.userId) {
    	     	document.querySelectorAll(".btn-writer-show").forEach(function(el) {
    	     		el.style.display = "";
    	     	})
        	 } else {
        		 document.querySelectorAll(".btn-writer-show").forEach(function(el) {
     	     		el.style.display = "none";
     	     	})
        	 }
    	    document.getElementById("section-list").style.display = "none";
      		document.getElementById("section-view").style.display = "";
      	});
     } 
     

     let loginHandler = function(e) {
    	 if (e.userId == document.getElementById("view-user-id").innerHTML.substr(6)) {
	     	document.querySelectorAll(".btn-writer-show").forEach(function(el) {
	     		el.style.display = "";
	     	})
    	 } else {
    		 document.querySelectorAll(".btn-writer-show").forEach(function(el) {
 	     		el.style.display = "none";
 	     	})
    	 }
     }   	
     document.addEventListener("login", loginHandler, false);
      
       // 조건에 맞는 글목록 불러오기
       document.querySelector("#btn-search").addEventListener("click", function () {
         getTarget(1);
       });
       
       // 글쓰기
       document.querySelector("#btn-register").addEventListener("click", function () {
    	   let subject = document.querySelector("#write-subject").value;
    	   let content = document.querySelector("#write-content").value;
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
	        fetch(`${root}/board/`, config)
	          .then((response) => response.text())
	          .then((data) => {
	        	  if(data == '1') {
	        		  windowList();
	        		  document.querySelector('#key').value = "";
	        		  document.querySelector('#word').value = "";
	           	   	  getTarget(1);
	        	  } else {
	        		  alert("등록에 실패하였습니다.");
	        	  }
	          });
       });
       
       // 글수정
       document.querySelector("#btn-modify").addEventListener("click", function () {
    	   let subject = document.querySelector("#write-subject").value;
    	   let content = document.querySelector("#write-content").value;
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
	        fetch(`${root}/board/`, config)
	          .then((response) => response.text())
	          .then((data) => {
	        	  if(data == '1') {
	        		  windowList();
	           	   	  getTarget(document.querySelector("#current-page").value);
	        	  } else {
	        		  alert("수정에 실패하였습니다.");
	        	  }
	          });
       });
       
       // 글삭제
       document.querySelector("#btn-delete").addEventListener("click", function () {
    	   if (confirm("정말 삭제하시겠습니까?")) {
    		   let articleNo = document.getElementById("view-article-no").innerHTML;
    	        let config = {
    	          method: "DELETE",
    	        };
    	        fetch(`${root}/board/view/\${articleNo}`, config)
    	          .then((response) => response.text())
    	          .then((data) => {
    	        	  if(data == '1') {
    	        		  windowList();
    	        		  document.querySelector('#key').value = "";
    	        		  document.querySelector('#word').value = "";
    	           	   	  getTarget(1);
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
           
       	fetch("${root}/board/list?" + new URLSearchParams(listInfo))
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
    	document.querySelector("#board-tbody").innerHTML = bodycontent;
    }
    
    // pagination
    function paging(pagingInfo) {
       	let currentPage = pagingInfo.currentPage;
       	const dataPerPage = pagingInfo.dataPerPage;
       	const pageCount = pagingInfo.pageCount;
       	const totalData = pagingInfo.totalData;

       	const totalPage = Math.ceil(totalData / dataPerPage);
       	const pageGroup = Math.ceil(currentPage / pageCount);

       	let first = (pageGroup - 1) * pageCount + 1;
       	let last = pageGroup * pageCount;
       	if (last > totalPage) last = totalPage;
       	// let first = last - (pageCount - 1);
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

       	document.querySelector("#board-pagination").innerHTML = pageContent;
       };
  </script>
</section>
<!-- 게시판 end -->
<%@include file="/WEB-INF/views/common/footer.jsp"%>
