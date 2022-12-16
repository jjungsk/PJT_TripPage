<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!-- cover start -->
<header class="masthead">
	<div
		class="container px-4 px-lg-5 d-flex h-100 align-items-center justify-content-center">
		<div class="d-flex justify-content-center">
			<div class="text-center">
				<h1 class="mx-auto text-uppercase">
					Enjoy<br />Trip
				</h1>
				<h2 class="text-black-50 mx-auto mt-3 mb-5 custom-title">내가 그리는
					나만의 여행</h2>
				<a class="btn btn-primary" href="#tourlist">let's trip</a>
			</div>
		</div>
	</div>
</header>
<!-- cover end -->

<!-- 목적지 근처 정보 start -->
<section class="text-center mt-5" id="tourlist" >
	<div class="container px-4 px-lg-5">
		<!-- Featured Project Row-->
		<div class="row gx-0 mb-4 mb-lg-5 align-items-center menu-box">
			<div class="col-xl-8 col-lg-7">
				<img class="img-fluid mb-3 mb-lg-0 w-100"
					src="${root}/assets/img/airplane.png" alt="..." />
			</div>
			<div class="col-xl-4 col-lg-5">
				<div class="featured-text text-center text-lg-left">
					<h4 class="fw-bold">여행지 목록 보기</h4>
					<p class="text-black-50 mb-0">목적지만 선택하면 주변 정보가 한 눈에</p>
					<a class="btn btn-primary mt-3" href="${root}/tourlist">어디로 떠나시나요?</a>
				</div>
			</div>
		</div>
</section>
<!-- 목적지 근처 정보 end -->

<!-- 일정짜기 start -->
<section class="text-center mt-5" id="#">
	<div class="container px-4 px-lg-5">
		<!-- Featured Project Row-->
		<div class="row gx-0 mb-4 mb-lg-5 align-items-center menu-box">
			<div class="col-xl-4 col-lg-5">
				<div class="featured-text text-center text-lg-left">
					<h4 class="fw-bold">나만의 여행 계획</h4>
					<p class="text-black-50 mb-0">
						나만의 여행 일정을<br> 만들어보세요
					</p>
					<a class="btn btn-primary mt-3" href="${root}/plan">여행을 떠나볼까요?</a>
				</div>
			</div>
			<div class="col-xl-8 col-lg-7">
				<img class="img-fluid mb-3 mb-lg-0 w-100"
					src="${root}/assets/img/weather.jpg" alt="..." />
			</div>
		</div>
</section>
<!-- 일정짜기 end -->

<!-- 일출일몰 정보 start -->
<section class="text-center mt-5" id="#">
	<div class="container px-4 px-lg-5">
		<!-- Featured Project Row-->
		<div class="row gx-0 mb-4 mb-lg-5 align-items-center menu-box">
			<div class="col-xl-8 col-lg-7">
				<img class="img-fluid mb-3 mb-lg-0 w-100" src="${root}/assets/img/sun.jpg"
					alt="..." />
			</div>
			<div class="col-xl-4 col-lg-5">
				<div class="featured-text text-center text-lg-left">
					<h4 class="fw-bold">일출 일몰</h4>
					<p class="text-black-50 mb-0">
						인생샷을 남기고 싶다면?<br> 해가 뜨고 해가 지는 아름다운 여행지
					</p>
					<a class="btn btn-primary mt-3" href="${root}/sun">그 날의 해는?</a>
				</div>
			</div>
		</div>
</section>
<!-- 일출일몰 정보 end -->


<!-- 게시판 공지사항 section start -->
<div class="container w-75">
	<div class="row mt-3 mb-5">
		<div class="col-md-6">
			<div class="d-flex">
				<h3 class="fw-bold mt-5">
					공지사항
					<h6 class="mt-5" style="line-height: 40px">
						<a href="${root}/notice">&nbsp;&nbsp;바로가기</a>
					</h6>
				</h3>
			</div>

			<table class="table table-hover">
				<thead>
					<tr class="text-center">
						<th scope="col">제목</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody id="noticelist">
				</tbody>
			</table>
		</div>
		<div class="col-md-6">
			<div class="d-flex">
				<h3 class="fw-bold mt-5">
					게시판
					<h6 class="mt-5" style="line-height: 40px">
						<a href="${root}/board">&nbsp;&nbsp;바로가기</a>
					</h6>
				</h3>
			</div>
			<table class="table table-hover">
				<thead>
					<tr class="text-center">

						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody id="boardlist">
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- 게시판 공지사항 section end -->

<script>
// 게시판, 공지사항 3개 미리 얻어오기
window.onload = function () {
	fetch("${root}/board/preview")
	.then(response => response.json())
	.then(data => preview(data, "#boardlist"));
	
	fetch("${root}/notice/preview")
	.then(response => response.json())
	.then(data => preview(data, "#noticelist"));
}

function preview(list, id) {
	let bodycontent = ``;

	list.forEach(function(article) {
		bodycontent += `
			<tr class="text-center">
      <td class="text-start">\${article.subject}</td>`;
    if (id == "#boardlist") {
    	bodycontent += `<td>\${article.userId}</td>`;
    }
    bodycontent += `
      <td>\${article.hit}</td>
    </tr>
		`;
	})
	document.querySelector(id).innerHTML = bodycontent;
}
</script>

<%@include file="/WEB-INF/views/common/footer.jsp"%>