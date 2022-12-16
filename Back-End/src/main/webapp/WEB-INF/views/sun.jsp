<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/WEB-INF/views/common/header.jsp"%>
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

<div id="weather" class="container">
  <!-- 서울 -->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/37d57126d98/seoul/"
    data-label_1="SEOUL"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-days="7"
    data-theme="weather_one"
    >SEOUL WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>
  <!-- 대전 충청도 -->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/36d35127d38/daejeon/"
    data-label_1="DAEJEON"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-theme="weather_one"
    >DAEJEON WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>
  <!-- 강릉 강원도 -->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/37d75128d88/gangneung-si/"
    data-label_1="GANGNEUNG"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-theme="weather_one"
    >GANGNEUNG WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>

  <!-- 전주 전라북도 -->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/35d82127d15/jeonju-si/"
    data-label_1="JEONJU"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-theme="weather_one"
    >JEONJU WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>
  <!-- 광주 전라남도 -->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/35d16126d85/gwangju/"
    data-label_1="GWANGJU"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-theme="weather_one"
    >GWANGJU WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>
  <!-- 대구 경상북도 -->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/35d87128d60/daegu/"
    data-label_1="DAEGU"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-days="7"
    data-theme="weather_one"
    >DAEGU WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>
  <!-- 부산 경상남도-->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/35d18129d08/busan/"
    data-label_1="BUSAN"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-theme="weather_one"
    >BUSAN WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>
  <!-- 제주도 -->
  <a
    class="weatherwidget-io"
    href="https://forecast7.com/en/33d50126d53/jeju-si/"
    data-label_1="JEJU"
    data-label_2="WEATHER"
    data-font="Arial"
    data-icons="Climacons Animated"
    data-theme="weather_one"
    >JEJU WEATHER</a
  >
  <script>
    !(function (d, s, id) {
      var js,
        fjs = d.getElementsByTagName(s)[0];
      if (!d.getElementById(id)) {
        js = d.createElement(s);
        js.id = id;
        js.src = "https://weatherwidget.io/js/widget.min.js";
        fjs.parentNode.insertBefore(js, fjs);
      }
    })(document, "script", "weatherwidget-io-js");
  </script>
</div>


<script src="${root}/assets/js/sun.js"></script>
<script
  type="text/javascript"
  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84438603ef15ec1f521f260675951d5f&libraries=services"
></script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
