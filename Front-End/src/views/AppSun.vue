<template>
  <div class="container">
    <div class="header-blank"></div>
    <div id="sun-sections" class="mt-4 d-flex">
      <div id="left-section">
        <hr />
        <div id="sun-enjoy-trip">Enjoy Trip</div>
        <hr />
        <sun-date-picker @change="updateDate"></sun-date-picker>
        <sun-info></sun-info>
      </div>

      <div id="map-section">
        <kakao-map
          class="kmap"
          :options="mapOption"
          markable
          @latlng="updatelatlng"
        ></kakao-map>
        <p>
          <em>*일출시간과 일몰시간을 알고싶은 위치를 지도에서 클릭해주세요!</em>
        </p>
      </div>

      <div id="weather-section">
        <sun-weather></sun-weather>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";
import KakaoMap from "@/components/common/KakaoMap";
import SunDatePicker from "@/components/sun/SunDatePicker";
import SunInfo from "@/components/sun/SunInfo";
import SunWeather from "@/components/sun/SunWeather";

export default {
  name: "AppSun",
  components: {
    KakaoMap,
    SunDatePicker,
    SunInfo,
    SunWeather,
  },
  data() {
    return {
      mapOption: {
        center: {
          lat: 37.5013167,
          lng: 127.039593,
        },
        level: 8,
      },
      params: {
        latitude: 37.5013167,
        longitude: 127.039593,
        date: "",
      },
    };
  },

  methods: {
    ...mapActions("sunStore", ["getSunInfo"]),
    updatelatlng(latlngInfo) {
      this.params.latitude = latlngInfo.lat;
      this.params.longitude = latlngInfo.lng;

      let params = {
        longitude: this.params.longitude,
        latitude: this.params.latitude,
        locdate: this.params.date,
      };
      this.getSunInfo(params);
    },
    updateDate(date) {
      this.params.date = date;

      let params = {
        longitude: this.params.longitude,
        latitude: this.params.latitude,
        locdate: this.params.date,
      };
      this.getSunInfo(params);
    },
  },
};
</script>

<style scoped>
#sun-sections {
  margin-left: 0;
  margin-right: 0;
}
#left-section {
  width: 200px;
}
#map-section {
  flex-grow: 1;
  margin-left: 20px;
  margin-right: 20px;
}
.kmap {
  width: 100%;
  height: 531px;
  margin: auto;
}
#weather-section {
  width: 270px;
}
hr {
  margin-top: 0px;
  margin-bottom: 15px;
}
#sun-enjoy-trip {
  font-family: Parisienne;
  font-size: 20px;
  text-align: center;
  font-weight: bold;
  letter-spacing: 4px;
  margin-bottom: 15px;
}
</style>
