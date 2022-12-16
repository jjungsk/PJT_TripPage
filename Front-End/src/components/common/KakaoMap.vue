<template>
  <div id="map" ref="map"></div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  name: "KakaoMap",
  props: {
    options: {
      type: Object,
      default() {
        return {
          center: {
            lat: 33.450701,
            lng: 126.570667,
          },
          level: 3,
        };
      },
    },
    markable: {
      type: Boolean,
      default: false,
      description:
        "Whether a marker is created at the position where user clicked",
    },
    plannable: {
      type: Boolean,
      default: false,
      description:
        "Whether routing and showing a marker using planMarkers and planMarker are possible",
    },
  },
  data() {
    return {
      map: null,
      marker: null,
      mapLine: null,
      markers: [],
    };
  },
  computed: {
    ...mapState("planStore", [
      "planMarker",
      "showLeftRegist",
      "planInfo",
      "planSpotList",
    ]),
  },
  mounted() {
    if (!window.kakao || !window.kakao.maps) {
      // script 태그 객체 생성
      const script = document.createElement("script");
      var vue = this;
      /* global kakao */
      script.onload = () => {
        kakao.maps.load(function () {
          vue.initMap();
          let planNo = vue.$route.query.planNo;
          if (planNo) {
            vue.showPlanInfo(planNo);
          }
        });
      };
      // src 속성을 추가하며 .env.local에 등록한 service 키 활용
      // 동적 로딩을 위해서 autoload=false 추가
      script.src =
        "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=" +
        process.env.VUE_APP_KAKAOMAP_KEY;

      // document의 head에 script 추가
      document.head.appendChild(script);
    } else {
      this.initMap();
    }
  },
  methods: {
    ...mapActions("planStore", ["showPlanInfo"]),
    initMap() {
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(
          this.options.center.lat,
          this.options.center.lng
        ),
        level: this.options.level,
      };
      this.map = new kakao.maps.Map(container, options);

      // 클릭한 위치에 마커 생성
      if (this.markable) {
        // 지도를 클릭한 위치에 표출할 마커입니다
        this.marker = new kakao.maps.Marker({
          // 지도 중심좌표에 마커를 생성합니다
          position: this.map.getCenter(),
        });
        // 지도에 마커를 표시합니다
        this.marker.setMap(this.map);

        var marker = this.marker;
        var self = this;

        // 지도에 클릭 이벤트를 등록합니다
        // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
        kakao.maps.event.addListener(this.map, "click", function (mouseEvent) {
          // 클릭한 위도, 경도 정보를 가져옵니다
          var latlng = mouseEvent.latLng;
          // console.log(latlng);
          // console.log(latlng.getLat());
          // 마커 위치를 클릭한 위치로 옮깁니다
          marker.setPosition(latlng);

          let latlngInfo = {
            lat: latlng.getLat(), // 위도
            lng: latlng.getLng(), // 경도
          };
          self.$emit("latlng", latlngInfo);
        });
      }
    },
    deleteLine() {
      // mapLine 지우기
      if (this.mapLine) {
        this.mapLine.setMap(null);
        this.mapLine = null;
      }
      // dot circle과 distance overlay 지우기
      this.markers.forEach(function (dot) {
        if (dot.circle) {
          dot.circle.setMap(null);
        }
        if (dot.distance) {
          dot.distance.setMap(null);
        }
      });
    },
    drawLine() {
      for (const dot of this.markers) {
        // this.markers.forEach(function(dot, i) {
        let distance = 0;

        if (dot.idx == 0) {
          // 시작점
          this.mapLine = new kakao.maps.Polyline({
            map: this.map, // 선을 표시할 지도입니다
            path: [dot.latlng], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다
            strokeColor: "#db4040", // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: "solid", // 선의 스타일입니다
          });
          distance = 0;
          this.map.panTo(dot.latlng);
        } else {
          // 그려지고 있는 선의 좌표 배열을 얻어옵니다
          let path = this.mapLine.getPath();
          // 좌표 배열에 클릭한 위치를 추가합니다
          path.push(dot.latlng);
          // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
          this.mapLine.setPath(path);
          distance = Math.round(this.mapLine.getLength());
        }

        // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
        let circleOverlay = new kakao.maps.CustomOverlay({
          content: '<span class="dot"></span>',
          position: dot.latlng,
          zIndex: 1,
        });

        // 지도에 표시합니다
        circleOverlay.setMap(this.map);

        if (distance > 0) {
          // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
          let distanceOverlay = new kakao.maps.CustomOverlay({
            content:
              '<div class="dotOverlay">거리 <span class="number">' +
              distance +
              "</span>m</div>",
            position: dot.latlng,
            yAnchor: 1,
            zIndex: 2,
          });
          // 지도에 표시합니다
          distanceOverlay.setMap(this.map);
          dot.distance = distanceOverlay;
        }
        // 배열에 추가합니다
        dot.circle = circleOverlay;
      }
    },
    deleteAndDrawLine(spots) {
      this.deleteLine();
      this.markers = [];
      let i = 0;
      for (const spot of spots) {
        this.markers.push({
          latlng: new kakao.maps.LatLng(spot.mapy, spot.mapx),
          idx: i,
        });
        i += 1;
      }
      this.drawLine();
    },
  },
  watch: {
    options: function () {
      this.initMap();
    },
    planMarker: function () {
      if (this.plannable) {
        if (this.planMarker.lat) {
          let moveLatLng = new kakao.maps.LatLng(
            this.planMarker.lat,
            this.planMarker.lng
          );
          // 지도에 표출할 마커입니다
          this.marker = new kakao.maps.Marker({
            position: moveLatLng,
          });
          // 지도에 마커를 표시합니다
          this.marker.setMap(this.map);
          // 지도 위치 이동
          this.map.panTo(moveLatLng);
        } else {
          if (this.marker) this.marker.setMap(null);
        }
      }
    },
    planInfo: function () {
      if (this.plannable && !this.showLeftRegist) {
        this.deleteAndDrawLine(this.planInfo.planInforms);
      }
    },
    planSpotList: function () {
      if (this.plannable && this.showLeftRegist) {
        this.deleteAndDrawLine(this.planSpotList);
      }
    },
    showLeftRegist: function () {
      if (this.plannable && this.showLeftRegist) {
        this.deleteAndDrawLine(this.planSpotList);
      }
    },
  },
};
</script>

<style>
.dot {
  overflow: hidden;
  float: left;
  width: 12px;
  height: 12px;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png");
}
.dotOverlay {
  position: relative;
  bottom: 10px;
  border-radius: 6px;
  border: 1px solid #ccc;
  border-bottom: 2px solid #ddd;
  float: left;
  font-size: 12px;
  padding: 5px;
  background: #fff;
}
.dotOverlay:nth-of-type(n) {
  border: 0;
  box-shadow: 0px 1px 2px #888;
}
.number {
  font-weight: bold;
  color: #ee6152;
}
.dotOverlay:after {
  content: "";
  position: absolute;
  margin-left: -6px;
  left: 50%;
  bottom: -8px;
  width: 11px;
  height: 8px;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png");
}
.distanceInfo {
  position: relative;
  top: 5px;
  left: 5px;
  list-style: none;
  margin: 0;
}
.distanceInfo .label {
  display: inline-block;
  width: 50px;
}
.distanceInfo:after {
  content: none;
}
</style>
