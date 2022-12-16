<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/header.jsp"%>
<c:if test="${userinfo.isManager == 0}">
	<script type="text/javascript">
		alert("관리자만 이용 가능한 페이지입니다.");
		location.href = "${root}/index.jsp";
	</script>
</c:if>
<link href="${root}/assets/css/notice.css" rel="stylesheet" />
<!-- 페이지 시작 -->
      <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">
          <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글수정</mark>
          </h2>
        </div>
        <div class="col-lg-8 col-md-10 col-sm-12">
          <form id="form-modify" method="POST" action="${root}/notice">
          	<input type="hidden" name="act" value="modify">
          	<input type="hidden" name="pgno" value="${param.pgno}">
          	<input type="hidden" name="key" value="${param.key}">
          	<input type="hidden" name="word" value="${param.word}">
          	<input type="hidden" name="articleno" value="${notice.articleNo}">
            <div class="mb-3">
              <label for="subject" class="form-label">제목 : </label>
              <input type="text" class="form-control" id="subject" name="subject" value="${notice.subject}" />
            </div>
            <div class="mb-3">
              <label for="content" class="form-label">내용 : </label>
              <textarea class="form-control" id="content" name="content" rows="7">
${notice.content}
              </textarea>
            </div>
            <div class="col-auto text-center">
              <button type="button" id="btn-modify" class="btn btn-outline-primary mb-3">
                글수정
              </button>
              <button type="button" id="btn-list" class="btn btn-outline-danger mb-3">
                목록으로이동...
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <form id="form-param" method="get" action="">
		<input type="hidden" id="act" name="act" value="list"> 
		<input type="hidden" id="pgno" name="pgno" value="${param.pgno}"> 
		<input type="hidden" id="key" name="key" value="${param.key}"> 
		<input type="hidden" id="word" name="word" value="${param.word}">
	</form>
    <script>
      document.querySelector("#btn-modify").addEventListener("click", function () {
        if (!document.querySelector("#subject").value) {
          alert("제목 입력!!");
          return;
        } else if (!document.querySelector("#content").value) {
          alert("내용 입력!!");
          return;
        } else {
          let form = document.querySelector("#form-modify");
          form.setAttribute("action", "${root}/notice");
          form.submit();
        }
      });
      
      document.querySelector("#btn-list").addEventListener("click", function () {
      	if(confirm("취소를 하시면 작성중인 글은 삭제됩니다.\n취소하시겠습니까?")) {
    		  let form = document.querySelector("#form-param");
         	  form.setAttribute("action", "${root}/notice");
            form.submit();
     	    }
        });
    </script>
<!-- 페이지 끝 -->
<%@include file="/common/footer.jsp"%>