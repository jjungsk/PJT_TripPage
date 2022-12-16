<template>
  <div class="tab-content mt-2" id="myTabContent">
    <div class="tab-pane fade show active" id="tabpane" role="tabpanel" aria-labelledby="tabpane">
      <div class="map_wrap position-relative d-flex flex-row">
        <div class="button-left">
          <router-link :to="{ name: 'sun' }">
            <i class="ni ni-bold-left"></i>
          </router-link>
        </div>
        <tour-middle-map></tour-middle-map>
        <tour-middle-list></tour-middle-list>
        <div class="button-right">
          <router-link :to="{ name: 'plan' }">
            <i class="ni ni-bold-right"></i>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TourMiddleMap from "./TourMiddleMap.vue";
import TourMiddleList from "./TourMiddleList.vue";

export default {
  name: "TourMiddle",
  components: {
    TourMiddleMap,
    TourMiddleList,
  }
}
</script>

<style scoped>
.button-left {
  position: absolute; 
  top: 50%; 
  left: -15rem; 
  z-index: 2;
}
.button-right {
  position: absolute; 
  top: 50%; 
  right: -20rem; 
  z-index: 2;
}
.ni {
  font-size: 3rem;
  cursor: pointer;
}
</style>