<template>
  <div>
    <b-carousel
      id="carousel-weather"
      :interval="4000"
      indicators
      background="#ababab"
      img-height="531"
    >
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/37d57126d98/seoul/"
          data-label_1="SEOUL"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >SEOUL WEATHER</a
        >
      </b-carousel-slide>
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/36d35127d38/daejeon/"
          data-label_1="DAEJEON"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >DAEJEON WEATHER</a
        >
      </b-carousel-slide>
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/37d75128d88/gangneung-si/"
          data-label_1="GANGNEUNG"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >GANGNEUNG WEATHER</a
        >
      </b-carousel-slide>
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/35d82127d15/jeonju-si/"
          data-label_1="JEONJU"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >JEONJU WEATHER</a
        >
      </b-carousel-slide>
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/35d16126d85/gwangju/"
          data-label_1="GWANGJU"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >GWANGJU WEATHER</a
        >
      </b-carousel-slide>
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/35d87128d60/daegu/"
          data-label_1="DAEGU"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >DAEGU WEATHER</a
        >
      </b-carousel-slide>
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/35d18129d08/busan/"
          data-label_1="BUSAN"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >BUSAN WEATHER</a
        >
      </b-carousel-slide>
      <b-carousel-slide img-blank img-width="270px">
        <a
          class="weatherwidget-io"
          href="https://forecast7.com/en/33d50126d53/jeju-si/"
          data-label_1="JEJU"
          data-label_2="WEATHER"
          data-font="Monaco"
          data-icons="Climacons Animated"
          data-days="7"
          data-theme="weather_one"
          >JEJU WEATHER</a
        >
      </b-carousel-slide>
    </b-carousel>
  </div>
</template>

<script>
import { BCarousel } from "bootstrap-vue/esm/components/carousel/carousel";
import { BCarouselSlide } from "bootstrap-vue/esm/components/carousel/carousel-slide";

export default {
  name: "SunWeather",
  components: {
    BCarousel,
    BCarouselSlide,
  },
  mounted() {
    let id = "weatherwidget-io-js";
    let js;
    let fjs = document.getElementsByTagName("script")[0];
    js = document.createElement("script");
    js.id = id;
    js.src = "https://weatherwidget.io/js/widget.min.js";
    fjs.parentNode.insertBefore(js, fjs);
  },
};
</script>

<style scoped>
#carousel-weather {
  height: 531px;
}
.weatherwidget-io {
  width: 270px;
}
#carousel-weather___BV_indicators_ {
  bottom: -10px;
}
</style>
