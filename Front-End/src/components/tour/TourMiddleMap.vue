<template>
  <div id="map-section" style="width: 80%; height: 600px">
    <kakao-map class="kakao-map" plannable></kakao-map>
    <!-- 지도 확대, 축소 컨트롤 div 입니다
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
    </div> -->
  </div>
</template>

<script>
import KakaoMap from "@/components/common/KakaoMap";

export default {
  name: "TourMiddleMap",
  components: {
    KakaoMap,
  },
}
</script>

<style>
.kakao-map {
  width: 100%;
  height: 100%;
}
</style>