<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="${root}/assets/css/placeRecommend.css" />
<!-- 중앙 content start -->
<div class="container">
  <!-- title -->
  <div class="container mt-3 p-4 title"></div>

  <div class="px-3 row" style="height: 600px">
    <div class="col-6" style="position: relative">
      <div id="today-title" class="fs-1"></div>
      <div id="today-addr" class="fs-3"></div>
      <div id="today-tel" class="fs-3"></div>
      <img
        id="today-image"
        class="mt-4"
        style="
          border-radius: 5px;
          position: absolute;
          bottom: 0;
          right: 10px;
          max-height: 420px;
          z-index: -1;
        "
        src=""
        alt="이미지"
        width="100%"
      />
    </div>
    <div class="map_wrap col-6">
      <div
        id="map"
        style="width: 100%; height: 600px"
        class="radius_border"
      ></div>
      <div class="custom_zoomcontrol radius_border">
        <span onclick="zoomIn()"
          ><img
            src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
            alt="확대"
        /></span>
        <span onclick="zoomOut()"
          ><img
            src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png"
            alt="축소"
        /></span>
      </div>
    </div>
  </div>
  <div class="d-flex justify-content-center m-5">
    <a
      id="btn-recommend"
      class="btn btn-primary fs-6"
      href="#recommend"
      onclick="getNewData();"
    ></a>
  </div>
</div>

<!-- 중앙 content end -->
<script>
  let key = "${keywordRecommend}"; // 오늘의 관광지, 공연, 맛집
  var map;

  window.onload = function () {
    getTitle();
    makeMap();
    getNewData();
  };

  function getNewData() {
    var act = "${param.act}";
    switch (act) {
      case "mvTodaysTour":
        act = "todaysTour";
        break;
      case "mvTodaysFestival":
        act = "todaysFestival";
        break;
      case "mvTodaysRestaurant":
        act = "todaysRestaurant";
        break;
    }
    fetch("${root}/tourList?act=" + act)
      .then((response) => response.json())
      .then((data) => showPlaceInfo(data));
  }

  function getTitle() {
    let mapTitleDiv = document.querySelector(".title");
    let title = `
        <h2 class="mt-5 pt-3 fw-bold text-center">\${key}</h2>
        `;
    mapTitleDiv.innerHTML = title;

    let buttonDiv = document.querySelector("#btn-recommend");
    let buttonText = `새로운 추천받기`;
    buttonDiv.innerHTML = buttonText;
  }

  function makeMap() {
    var mapContainer = document.getElementById("map"), // 지도를 표시할 div
      mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3, // 지도의 확대 레벨
      };

    // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    map = new kakao.maps.Map(mapContainer, mapOption);
  }

  // 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
  function zoomIn() {
    map.setLevel(map.getLevel() - 1);
  }

  // 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
  function zoomOut() {
    map.setLevel(map.getLevel() + 1);
  }

  function showPlaceInfo(data) {
    // data.title data.zipcode data.mapx data.mapy data.firstimage data.addr1
    let titleDiv = document.querySelector("#today-title");
    let addrDiv = document.querySelector("#today-addr");
    let telDiv = document.querySelector("#today-tel");
    let imageDiv = document.querySelector("#today-image");
    let title = data.title;
    let addr = data.addr1;
    let tel = data.tel;
    let image = data.image;

    titleDiv.innerHTML = title;
    if (addr != "") {
      addrDiv.innerHTML = `주소: ` + addr;
    } else {
      addrDiv.innerHTML = "";
    }
    if (tel != "") {
      telDiv.innerHTML = `전화번호: ` + tel;
    } else {
      telDiv.innerHTML = "";
    }
    imageDiv.setAttribute("src", image);

    if (data.mapy && data.mapx && data.mapy != "0") {
      makeMapMarker(data.mapy, data.mapx);
    }
  }

  function makeMapMarker(lat, lng) {
    // 마커가 표시될 위치입니다
    var markerPosition = new kakao.maps.LatLng(lat, lng);

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
      position: markerPosition,
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
    map.setLevel(3);
    map.setCenter(new kakao.maps.LatLng(lat, lng));
  }
</script>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84438603ef15ec1f521f260675951d5f&libraries=services"
></script>
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
  crossorigin="anonymous"
></script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
