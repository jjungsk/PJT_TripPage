<template>
  <div id="sun-info">
    <div>해당지역: {{ sunRiseSetState.location }}</div>
    <div>
      일출시간: {{ sunRiseSetState.sunRiseHour }}시
      {{ sunRiseSetState.sunRiseMinutes }}분
    </div>
    <div>
      일몰시간: {{ sunRiseSetState.sunSetHour }}시
      {{ sunRiseSetState.sunSetMinutes }}분
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "SunInfo",
  computed: { ...mapState("sunStore", ["sunRiseSetState"]) },
};
</script>

<style scoped>
#sun-info {
  margin-left: 2px;
  padding-top: 10px;
  font-size: 18px;
  font-weight: bold;
  font-family: sans-serif;
}
#sun-info div {
  padding-bottom: 3px;
}
</style>
