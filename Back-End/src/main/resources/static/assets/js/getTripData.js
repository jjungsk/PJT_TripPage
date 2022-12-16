var container = document.getElementById("map"); //지도를 담을 영역의 DOM 레퍼런스
var options = {
  //지도를 생성할 때 필요한 기본 옵션
  center: new kakao.maps.LatLng(36.910701, 127.770667), //지도의 중심좌표.
  level: 12, //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
var markers = [];
var positions = [];

function makeMapMarkers(data) {
  let sido = document.querySelector("#sido");
  let gugun = document.querySelector("#gugun");
  let areaCode = sido[sido.selectedIndex].value;
  let sigunguCode = gugun[gugun.selectedIndex].value;

  // ****** 여러개 마커에 이벤트 등록하기1 ******
  markers.forEach(function (mark) {
    mark.setMap(null);
  });
  markers = [];

  positions = [];
  data.forEach(function (data, idx) {
    //data.addr1 data.firstimage data.mapx data.mapy data.tel data.title data.zipcode data.contenttypeid
    let addr = data.addr1;
    let image = data.image;
    let mapx = data.mapx;
    let mapy = data.mapy;
    let tel = data.tel;
    let title = data.title;
    let zipcode = data.zipcode;
    positions.push({
      content: `<div class="wrap">
        <div class="info">
          <div class="title">${title}</div>
          <div class="body">
            <div class="img">
              <img src="${image}" width="73" height="70">
            </div>
            <div class="desc">
              <div class="ellipsis">${addr}</div>
              <div class="ellipsis">(우) ${zipcode}</div>
              <div class="ellipsis">(전화번호) ${tel}</div>
            </div>
          </div>
        </div>
      </div>`,
      latlng: new kakao.maps.LatLng(mapy, mapx),
    });
  });

  for (var i = 0; i < positions.length; i++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: positions[i].latlng, // 마커의 위치
    });

    if (areaCode && sigunguCode && i == 0) {
      map.setLevel(7);
      map.setCenter(positions[i].latlng);
    }

    markers.push(marker);

    // 마커 위에 커스텀오버레이를 표시합니다
    // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
    let overlay = new kakao.maps.CustomOverlay({
      content: positions[i].content,
      map: map,
      position: marker.getPosition(),
    });
    overlay.setMap(null);

    // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
    kakao.maps.event.addListener(marker, "mouseover", function () {
      overlay.setMap(map);
    });

    kakao.maps.event.addListener(marker, "mouseout", function () {
      overlay.setMap(null);
    });
  }
}

function addOption(selid, data) {
  let opt = ``;
  initOption(selid);
  switch (selid) {
    case "sido":
      opt += `<option value="">시도선택</option>`;
      data.forEach(function (dos) {
        opt += `
                <option value="${dos.areaCode}">${dos.name}</option>
                `;
      });
      break;
    case "gugun":
      opt += `<option value="">구군선택</option>`;
      data.forEach(function (sigungu) {
        opt += `
                <option value="${sigungu.sigunguCode}">${sigungu.name}</option>
                `;
      });
      break;
  }
  document.querySelector(`#${selid}`).innerHTML = opt;
}

function initOption(selid) {
  let options = document.querySelector(`#${selid}`);
  options.length = 1;
}

// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
  map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
  map.setLevel(map.getLevel() + 1);
}

// 해당 목록 위치로 이동
function mapMove(el) {

	let xPos = el.getAttribute("data-mapx");
	let yPos = el.getAttribute("data-mapy");
	
    let moveLatLon = new kakao.maps.LatLng(yPos, xPos);
    map.setLevel(3);

    map.panTo(moveLatLon);  

}
