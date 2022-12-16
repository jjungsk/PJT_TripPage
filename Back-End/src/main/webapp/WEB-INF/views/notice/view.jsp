<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/common/header.jsp"%>
<link href="${root}/assets/css/notice.css" rel="stylesheet" />
<!-- 페이지 시작 -->
<div class="container px-4 px-lg-5 mt-5 pt-5 mb-5 row justify-content-center">
  <div class="col-lg-8 col-md-10 col-sm-12">
    <div class="row my-4">
      <h2 class="text-center text-secondary">${notice.subject}</h2>
    </div>
    <div class="row">
      <div class="col-md-8">
        <div class="clearfix align-content-center">
          <img
            class="avatar me-2 float-md-start bg-light p-2"
            src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
          />
          <p>
            <span class="fw-bold">작성자 ${notice.userId}</span> <br />
            <span class="text-secondary fw-light">
              ${notice.registerTime}
            </span>
          </p>
        </div>
      </div>
      <div class="col-md-4 align-self-center text-end">
        조회수 : ${notice.hit}
      </div>
      <div class="divider mb-3"></div>
      <div class="text-secondary">${notice.content}</div>
      <div class="divider mt-3 mb-3"></div>
      <div class="d-flex justify-content-end">
        <button
          type="button"
          id="btn-list"
          class="btn btn-outline-primary mb-3"
        >
          글목록
        </button>
        <c:if test="${notice.userId eq userinfo.id}">
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
        </c:if>
      </div>
    </div>
  </div>
</div>
<form id="form-param" method="get" action="">
  <input type="hidden" id="act" name="act" value="" />
  <input type="hidden" id="pgno" name="pgno" value="${param.pgno}" />
  <input type="hidden" id="key" name="key" value="${param.key}" />
  <input type="hidden" id="word" name="word" value="${param.word}" />
</form>
<form id="form-no-param" method="get" action="${root}/notice">
  <input type="hidden" id="nact" name="act" value="" />
  <input type="hidden" id="npgno" name="pgno" value="${param.pgno}" />
  <input type="hidden" id="nkey" name="key" value="${param.key}" />
  <input type="hidden" id="nword" name="word" value="${param.word}" />
  <input
    type="hidden"
    id="articleno"
    name="articleno"
    value="${notice.articleNo}"
  />
</form>
<script>
  document.querySelector("#btn-list").addEventListener("click", function () {
    let form = document.querySelector("#form-param");
    document.querySelector("#act").value = "list";
    form.setAttribute("action", "${root}/notice");
    form.submit();
  });

  document
    .querySelector("#btn-mv-modify")
    .addEventListener("click", function () {
      let form = document.querySelector("#form-no-param");
      document.querySelector("#nact").value = "mvmodify";
      form.setAttribute("action", "${root}/notice");
      form.submit();
    });

  document.querySelector("#btn-delete").addEventListener("click", function () {
    if (confirm("정말 삭제하시겠습니까?")) {
      let form = document.querySelector("#form-no-param");
      document.querySelector("#nact").value = "delete";
      form.setAttribute("action", "${root}/notice");
      form.submit();
    }
  });
</script>
<!-- 페이지 끝 -->
<%@include file="/common/footer.jsp"%>
