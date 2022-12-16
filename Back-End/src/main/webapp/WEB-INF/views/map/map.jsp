<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/common/header.jsp"%>
<link rel="stylesheet" href="${root}/assets/css/map.css" />
<!-- 중앙 content start -->
<div class="container my-5">
  <div style="height: 70px"></div>
  <!-- <h2 class="text-center mt-5 mb-3">아파트 매매 정보</h2> -->
  <div class="row col-md-12 justify-content-center mb-2">
    <div class="form-group col-md-2">
      <select class="form-select bg-secondary text-light" id="sido">
        <option value="">시도선택</option>
      </select>
    </div>
    <div class="form-group col-md-2">
      <select class="form-select bg-secondary text-light" id="gugun">
        <option value="">구군선택</option>
      </select>
    </div>
  </div>
  <ul class="nav nav-tabs" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
      <button
        class="nav-link active contenttype"
        id="tab0"
        data-bs-toggle="tab"
        data-bs-target="#tab0"
        type="button"
        role="tab"
        aria-controls="tab0"
        aria-selected="true"
      >
        전체
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab1"
        data-bs-toggle="tab"
        value="12"
        data-bs-target="#tab1"
        type="button"
        role="tab"
        aria-controls="tab1"
        aria-selected="false"
      >
        관광지
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab2"
        data-bs-toggle="tab"
        value="14"
        data-bs-target="#tab2"
        type="button"
        role="tab"
        aria-controls="tab2"
        aria-selected="false"
      >
        문화시설
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab3"
        data-bs-toggle="tab"
        value="15"
        data-bs-target="#tab3"
        type="button"
        role="tab"
        aria-controls="tab3"
        aria-selected="false"
      >
        행사/공연/축제
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab4"
        data-bs-toggle="tab"
        value="25"
        data-bs-target="#tab4"
        type="button"
        role="tab"
        aria-controls="tab4"
        aria-selected="false"
      >
        여행코스
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab5"
        data-bs-toggle="tab"
        value="28"
        data-bs-target="#tab5"
        type="button"
        role="tab"
        aria-controls="tab5"
        aria-selected="false"
      >
        레포츠
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab6"
        data-bs-toggle="tab"
        value="32"
        data-bs-target="#tab6"
        type="button"
        role="tab"
        aria-controls="tab6"
        aria-selected="false"
      >
        숙박
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab7"
        data-bs-toggle="tab"
        value="38"
        data-bs-target="#tab7"
        type="button"
        role="tab"
        aria-controls="tab7"
        aria-selected="false"
      >
        쇼핑
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link contenttype"
        id="tab8"
        data-bs-toggle="tab"
        value="39"
        data-bs-target="#tab8"
        type="button"
        role="tab"
        aria-controls="tab8"
        aria-selected="false"
      >
        음식점
      </button>
    </li>
  </ul>
  <div class="tab-content mt-2" id="myTabContent">
    <div
      class="tab-pane fade show active"
      id="tabpane"
      role="tabpanel"
      aria-labelledby="tabpane"
    >
      <div class="map_wrap">
        <div id="map" style="width: 100%; height: 700px"></div>
        <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
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
  </div>
</div>

<!-- 중앙 content end -->
<script>
  window.onload = function () {
    getDo();
  };

  function getDo() {
    fetch("${root}/do?act=list")
      .then((response) => response.json())
      .then((data) => addOption("sido", data));
  }

  // 시도가 바뀌면 구군정보 얻기.
  document.querySelector("#sido").addEventListener("change", function () {
    if (this[this.selectedIndex].value) {
      let areacode = this[this.selectedIndex].value;
      getSigungu(areacode);
    } else {
      initOption("gugun");
    }
  });

  function getSigungu(areacode) {
    fetch("${root}/sigungu?act=list&areaCode=" + areacode)
      .then((response) => response.json())
      .then((data) => addOption("gugun", data));
  }

  document.querySelector("#gugun").addEventListener("change", function () {
    if (this[this.selectedIndex].value) {
      let sigunguCode = this[this.selectedIndex].value;
      let sido = document.querySelector("#sido");
      let areaCode = sido[sido.selectedIndex].value;
      getData(areaCode, sigunguCode, "");
    }
  });

  function getData(areaCode, sigunguCode, contentTypeId) {
    fetch(
      "${root}/tourList?act=map&areaCode=" +
        areaCode +
        "&sigunguCode=" +
        sigunguCode +
        "&contentTypeId=" +
        contentTypeId
    )
      .then((response) => response.json())
      .then((data) => makeMapMarkers(data));
  }

  document.querySelectorAll(".contenttype").forEach(function (content) {
    content.addEventListener("click", function () {
      if (content.classList.contains("active")) {
        let sido = document.querySelector("#sido");
        let gugun = document.querySelector("#gugun");
        let areaCode = sido[sido.selectedIndex].value;
        let sigunguCode = gugun[gugun.selectedIndex].value;
        let contentTypeId = this.value;
        getData(areaCode, sigunguCode, contentTypeId);
      }
    });
  });
</script>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84438603ef15ec1f521f260675951d5f&libraries=services"
></script>
<script src="${root}/assets/js/getTripData.js"></script>
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
  crossorigin="anonymous"
></script>

<%@include file="/common/footer.jsp"%>
