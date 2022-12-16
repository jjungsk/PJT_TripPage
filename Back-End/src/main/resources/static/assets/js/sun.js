var map;
var longitude;
var latitude;
var locdate;

window.onload = function () {
  makeMap();
};

let dateSelect = document.querySelector("#dateSelect");
dateSelect.addEventListener("change", function () {
  locdate = this.value.replace(/-/g, "");
  //   console.log(locdate);
  areaBasedListRequest();
});

function makeMap() {
  var mapContainer = document.getElementById("map"), // 지도를 표시할 div
    mapOption = {
      center: new kakao.maps.LatLng(37.5012743, 127.039585), // 지도의 중심좌표
      level: 5, // 지도의 확대 레벨
    };

  longitude = 12704;
  latitude = 3750;
  map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

  // 지도를 클릭한 위치에 표출할 마커입니다
  var marker = new kakao.maps.Marker({
    // 지도 중심좌표에 마커를 생성합니다
    position: map.getCenter(),
  });
  // 지도에 마커를 표시합니다
  marker.setMap(map);

  // 지도에 클릭 이벤트를 등록합니다
  // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
  kakao.maps.event.addListener(map, "click", function (mouseEvent) {
    // 클릭한 위도, 경도 정보를 가져옵니다
    var latlng = mouseEvent.latLng;

    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);

    //longitude = Math.round(latlng.getLng() * 100);
    //latitude = Math.round(latlng.getLat() * 100);
    // 위도 경도 도분초로 변환
    let longitudeDo = parseInt(latlng.getLng());
    let longitudeBun = parseInt((latlng.getLng() - longitudeDo) * 60);
    longitude = longitudeDo * 100 + longitudeBun;
    
    let latitudeDo = parseInt(latlng.getLat());
    let latitudeBun = parseInt((latlng.getLat() - latitudeDo) * 60);
    latitude = latitudeDo * 100 + latitudeBun;
    
    if (locdate) {
      areaBasedListRequest();
    }
  });
}

function areaBasedListRequest() {
  const url = "http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo";
  const serviceKey =
    "/tvOdXcUqw/7t0iJ2jKSzaid2LcODBl7dtjI5Bz/lv80GZaeaKeduuJKeVie/fX0LvEFP/ldrFIEkbKOcq9KnQ==";
  let params =
    "longitude=" +
    longitude +
    "&latitude=" +
    latitude +
    "&locdate=" +
    locdate +
    "&dnYn=N&ServiceKey=" +
    serviceKey;

  fetch(`${url}?${params}`)
    .then((response) => response.text())
    .then((data) => {
      showSunInfo(data);
    });
}

function showSunInfo(data) {
  let parser = new DOMParser();
  const xml = parser.parseFromString(data, "application/xml");
  let item = xml.querySelector("item");

  let locationDiv = document.querySelector("#sun-location");
  let sunriseDiv = document.querySelector("#sun-sunrise");
  let sunsetDiv = document.querySelector("#sun-sunset");

  let sunriseTime = item.querySelector("sunrise").textContent;
  let sunriseHour = sunriseTime.substring(0, 2);
  let sunriseMinutes = sunriseTime.substring(2, 4);
  let sunsetTime = item.querySelector("sunset").textContent;
  let sunsetHour = sunsetTime.substring(0, 2);
  let sunsetMinutes = sunsetTime.substring(2, 4);

  locationDiv.innerHTML = "위치: " + item.querySelector("location").textContent;
  sunriseDiv.innerHTML = "일출시간: " + sunriseHour + "시 " + sunriseMinutes + "분";
  sunsetDiv.innerHTML = "일몰시간: " + sunsetHour + "시 " + sunsetMinutes + "분";
}
