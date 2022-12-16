<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/common/header.jsp"%>
<link href="${root}/assets/css/myNook.css" rel="stylesheet" />
<!-- map start -->
<section class="container">
  <div class="container mt-3 p-4 title"></div>
  <div class="map_wrap container ps-5 pe-5">
    <div id="map" style="width: 80%; height: 80%; overflow: hidden"></div>
    <div id="menu_wrap" class="bg_white">
      <div class="option">
        <div class="input-content"></div>
      </div>
      <hr />
      <ul id="placesList"></ul>
      <div id="pagination"></div>
    </div>
  </div>
</section>

<!-- map end -->
<script>
  window.onload = function () {
    let inputDiv = document.querySelector(".input-content");
    let mapTitleDiv = document.querySelector(".title");
    let input = `
        <form onsubmit="searchPlaces(); return false;">
        키워드 :
        <input type="text" value="${search}" id="keyword" size="15" />
        <button type="submit">검색하기</button>
      </form>
        `;

    let title = `
        <h2 class="mt-5 pt-3 fw-bold text-center">"${search}" 리스트</h2>
        `;
    inputDiv.innerHTML = input;
    mapTitleDiv.innerHTML = title;
    searchPlaces();
  };
</script>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=15e34ea56598634c0d72e93ce83e2a0f&libraries=services,clusterer,drawing"
></script>
<script src="${root}/assets/js/myNook.js"></script>
<%@include file="/common/footer.jsp"%>
