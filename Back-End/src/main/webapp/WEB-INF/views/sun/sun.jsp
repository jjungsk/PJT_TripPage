<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/common/header.jsp"%>
<link rel="stylesheet" href="${root}/assets/css/map.css" />
<div class="container" style="max-width: 750px; margin-top: 150px">
  <div id="map" style="width: 100%; height: 500px"></div>
  <p>
    <em>*일출시간과 일몰시간을 알고싶은 위치를 지도에서 클릭해주세요!</em>
  </p>
  <div id="clickLatlng"></div>

  <div class="d-flex">
    <p>날짜선택:&nbsp;</p>
    <input type="date" id="dateSelect" />
  </div>
  <div>
    <div class="mt-5 fs-4 mb-5" style="margin-left: 30%">
      <div id="sun-location">위치:</div>
      <div id="sun-sunrise">일출시간:</div>
      <div id="sun-sunset">일몰시간:</div>
    </div>
  </div>
</div>
<script src="${root}/assets/js/sun.js"></script>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84438603ef15ec1f521f260675951d5f&libraries=services"
></script>
<%@include file="/common/footer.jsp"%>
