<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/common/headerNoLogin.jsp"%>

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
            <button
              type="button"
              id="btn-mv-register"
              class="btn btn-primary mb-3"
              style="height: 10px; line-height: 10px"
            >
              글쓰기
            </button>
          </c:if>
        </div>
        <div class="col-md-7">
          <form class="d-flex" id="form-search" method="get" action="">
            <input type="hidden" name="act" value="list" />
            <input type="hidden" name="pgno" value="1" />
            <select
              class="form-select form-select-sm ms-5 me-1 w-50"
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
        <tbody id="notice-tbody">
          <c:forEach var="notice" items="${notices}">
            <tr class="text-center">
              <th scope="row">${notice.articleNo}</th>
              <td class="text-start">
                <a
                  href="#"
                  class="article-title link-dark"
                  data-no="${notice.articleNo}"
                  style="text-decoration: none"
                >
                  ${notice.subject}
                </a>
              </td>
              <td>${notice.userId}</td>
              <td>${notice.hit}</td>
              <td>${notice.registerTime}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
    <div class="row">
      <ul class="pagination justify-content-center" id="notice-pagination">
        <li class="page-item">
          <a class="page-link" href="#">이전</a>
        </li>
        <li class="page-item active"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item"><a class="page-link" href="#">4</a></li>
        <li class="page-item"><a class="page-link" href="#">5</a></li>
        <li class="page-item"><a class="page-link" href="#">다음</a></li>
      </ul>
    </div>
  </div>
  <form id="form-no-param" method="get" action="${root}/notice">
    <input type="hidden" id="act" name="act" value="view" />
    <input type="hidden" id="pgno" name="pgno" value="${param.pgno}" />
    <input type="hidden" id="key" name="key" value="${param.key}" />
    <input type="hidden" id="word" name="word" value="${param.word}" />
    <input type="hidden" id="articleno" name="articleno" value="" />
  </form>
  <script>
       var pageno;
       let titles = document.querySelectorAll(".article-title");
       titles.forEach(function (title) {
         title.addEventListener("click", function () {
       	  mvView(this.getAttribute("data-no"));
         });
       });

       function mvView(articleno) {
           document.querySelector("#articleno").value = articleno;
           document.querySelector("#pgno").value = pageno;
           document.querySelector("#form-no-param").submit();
        }

       <c:if test="${userinfo != null && userinfo.isManager != 0}">
       document.querySelector("#btn-mv-register").addEventListener("click", function () {
         location.href = "${root}/notice?act=mvwrite&pgno="+pageno+"&key="+"${param.key}"+"&word="+"${param.word}";
       });
       </c:if>

       document.querySelector("#btn-search").addEventListener("click", function () {
     	  let form = document.querySelector("#form-search");
           form.setAttribute("action", "${root}/notice?act=");
           form.submit();
       });


     //pagination
       window.onload = function() {
       	paging(${param.pgno});
       };

       function paging(currentPage) {
       	pageno = currentPage;
       	const dataPerPage = ${dataPerPage};
       	const pageCount = ${pageCount};
       	const totalData = ${totalData};


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

       	document.querySelector("#notice-pagination").innerHTML = pageContent;
       };


    function getTarget(page) {
    	fetch("${root}/notice?act=listcontent&pgno="+page)
    	.then(response => response.json())
    	.then(data => showList(data.list));
    	paging(page);
    }

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
  </script>
</section>
<!-- 공지사항 end -->
<%@include file="/common/footer.jsp"%>
