<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ include
file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet" href="${root}/assets/css/map.css" />
<!-- 중앙 content start -->
<div class="container my-5">
  <div style="height: 70px"></div>
  <!-- <h2 class="text-center mt-5 mb-3">text</h2> -->
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
    <div class="tab-pane fade show active" id="tabpane" role="tabpanel" aria-labelledby="tabpane">
      <div class="map_wrap position-relative d-flex flex-row">
        <!-- 실제 출력되는 map의 div 입니다. -->
        <div class="" id="map" style="width: 60%; height: 600px"></div>
        <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
        <div class="custom_zoomcontrol radius_border position-absolute top-0 start-0">
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
        <!-- tour list 출력 부분 Start -->
        <div class="" id="tour-list-inform" style="width: 35%; height: 600px; margin-left: 10px">
          <div
            class="scrollspy-tour tour-section"
            data-bs-spy="scroll"
            data-bs-target="#lex"
            id="work"
            data-offset="20"
            style="height: 600px; overflow: auto"
          >
            <table class="table table-striped table-hover">
              <thead>
                <tr class="text-center">
                  <th>Location</th>
                  <th>Tel</th>
                </tr>
              </thead>
              <tbody id="trip-info-list"></tbody>
            </table>
          </div>
        </div>
        <!-- tour list 출력 부분 End -->
      </div>
    </div>
  </div>
</div>
<!-- 중앙 content end -->

<!-- Detail 여행 정보 Modal Start -->
<div
  class="modal fade"
  id="detailModal"
  tabindex="-1"
  role="dialog"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  aria-labelledby="detailModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <!-- fetch를 통해 받아오는 정보 -->
      <div id="detail-modal-body" class="modal-body"></div>
    </div>
  </div>
</div>
<!-- Detail 여행 정보 Modal End -->

<script>
  window.onload = function () {
    // default
    getDo();
  };

  function getDo() {
    fetch("${root}/tourlist/list")
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
    fetch(`${root}/tourlist/list/\${areacode}`)
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
    fetch("${root}/tourlist/getdata", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        areaCode: areaCode,
        sigunguCode: sigunguCode,
        contentTypeId,
        contentTypeId,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        makeTourList(data);
        makeMapMarkers(data);
      });
  }

  // 글목록 보여주기
  function makeTourList(list) {
    let bodycontent = ``;
    list.forEach(function (article) {
      let tel = article.tel;
      if (tel == 0) tel = "No Number";
      bodycontent += `
			<tr class="text-center">
				<th class="tourButton" id="" scope="row" style="font-size: 16px; cursor:pointer;" 
				data-mapx="\${article.mapx}" data-mapy="\${article.mapy}"
				data-desc="\${article.desc}" data-img="\${article.image}">\${article.title}</th>
				<td style="font-size: 12px">
					<a href="tel:\${tel}">\${tel}</a>
				</td>
			</tr>
		`;
    });

    document.querySelector("#trip-info-list").innerHTML = bodycontent;

    // 클릭, 더블클릭 구별
    var timer;
    var tBtns = document.querySelectorAll(".tourButton");

    tBtns.forEach(function (tBtn) {
      tBtn.onclick = function (tBtn) {
        if (timer) clearTimeout(timer);
        timer = setTimeout(function () {
          mapMove(tBtn.target);
        }, 250);
      };

      tBtn.ondblclick = function (tBtn) {
        clearTimeout(timer);
        tourDetail(tBtn.target);
      };
    });
  }

  // 해당 목록 위치로 이동 -> getTripData.js (map 함수 일괄 처리)

  // 목록 상세정보 불러오기
  function tourDetail(el) {
    var modal = new bootstrap.Modal(document.getElementById("detailModal"), {
      backdrop: true,
      keyboard: false,
    });
    modal.show();

    let title = el.innerHTML;
    let desc = el.getAttribute("data-desc");
    let image = el.getAttribute("data-img");

    // 관광지 정보 이미지가 없다면 default image 불러오기
    if (image == 0) {
      image = "${root}/assets/img/GolDaeng.png";
    }

    let initdelet = document.querySelector("#detail-modal-delete");
    if (initdelet != null) {
      initDetail();
    }

    let bod = `
    		<div id="#detail-modal-delete">
				<div class="form-title text-center">
					<h4>상세 정보</h4>
				</div>
				<h1 id="detail-title" class="display-6">${"${title}"}</h1>
				<img id="detail-img" src="${"${image}"}" class="img-fluid" alt="...">
				<p id="detail-content" class="lead">
					${"${desc}"}
				</p>
			</div>
    		  `;

    document.querySelector("#detail-modal-body").innerHTML = bod;
  }

  // 상세정보 내용 초기화
  function initDetail() {
    let deletedetail = document.querySelector("#detail-modal-delete");
    deletedetail.remove();
  }

  // contenttype 으로 관광지 정보 데이터 받아오기
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

<%@include file="/WEB-INF/views/common/footer.jsp"%>
