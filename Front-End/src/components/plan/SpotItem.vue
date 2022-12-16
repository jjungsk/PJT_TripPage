<template>
  <the-card class="border-0 card" shadow bodyClasses="px-0 py-0">
    <div class="d-flex" @mouseover="showMarker" @mouseout="deleteMarker">
      <div id="card-image">
        <div v-if="!item.image">
          <i class="ni ni-image"></i>
          <span>&nbsp;NO IMAGE</span>
        </div>
        <img :src="item.image" alt="" v-if="item.image">
      </div>
      <div id="card-content">
        <h6 class="text-primary">{{ item.title }}</h6>
        <button class="btn btn-primary" @click="removeSpot" v-if="type=='select'"><i class="ni ni-fat-remove ni-lg"></i></button>
        <button class="btn btn-primary" @click="addSpot" v-if="!type"><i class="ni ni-fat-add ni-lg"></i></button>
      </div>
    </div>
  </the-card>
</template>

<script>
import { mapMutations } from "vuex";

export default {
  name: "SpotItem",
  props: ['item', 'type', 'idx'],
  methods: {
    ...mapMutations("planStore", ["ADD_PLANSPOT", "REMOVE_PLANSPOT", "SET_PLAN_MARKER", "REMOVE_PLAN_MARKER"]),
    addSpot() {
      this.ADD_PLANSPOT(this.item);
    },
    removeSpot() {
      this.REMOVE_PLANSPOT(this.idx);
    },
    showMarker() {
      let markerData = {
        lat: this.item.mapy,
        lng: this.item.mapx,
      }
      this.SET_PLAN_MARKER(markerData);
    },
    deleteMarker() {
      this.REMOVE_PLAN_MARKER();
    },
  },
}
</script>

<style scoped>
h6 {
  overflow: hidden;
	text-overflow: ellipsis;
	word-wrap: break-word;
	display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;

  padding-left: 4px;
  padding-top: 2px;
}
.card {
  height: 100px;
}
#card-image {
  width: 50%;
  height: 100px;
  overflow: hidden;
  background-color: rgba(238, 221, 248, 0.5);
}
#card-image div {
  text-align: center;
  line-height: 100px;
}
#card-image img {
  width: 100%;
  height: 100%;
  display: block;
}
#card-content {
  width: 50%;
  height: 100px;
  position: relative;
}
#card-content button {
  position: absolute;
  bottom: 2px;
  right: 2px;
  padding: 5px 5px 3px 5px;
}
</style>