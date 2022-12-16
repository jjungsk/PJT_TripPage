<template>
  <div class="mt-5">
    <div style="height: 70px"></div>
    <div class="row col-md-12 justify-content-center mb-2">
      <base-dropdown class="form-group col-md-2 mr-2">
        <base-button slot="title" type="primary" class="dropdown-toggle">
          {{ sidoBtn }}
        </base-button>
        <button
          class="btn dropdown-item"
          v-for="(sido, index) in sidoList"
          :key="sido.areaCode"
          :index="index"
          @click="getGugunList(sido), (sidoBtn = sido.name)"
        >
          {{ sido.name }}
        </button>
      </base-dropdown>
      <base-dropdown>
        <base-button slot="title" type="primary" class="dropdown-toggle">
          {{ gugunBtn }}
        </base-button>
        <div
          class="container scroll"
          data-spy="scroll"
          style="height: 500px; overflow-y: auto; overflow-x: hidden"
        >
          <button
            class="btn dropdown-item"
            v-for="(gugun, index) in gugunList"
            :key="gugun.gunguCode"
            :index="index"
            @click="getTourList(gugun), (gugunBtn = gugun.name)"
          >
            {{ gugun.name }}
          </button>
        </div>
      </base-dropdown>
    </div>
    <ul class="nav nav-tabs" id="myTab" role="tablist">
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab0"
          data-bs-toggle="tab"
          data-bs-target="#tab0"
          type="button"
          role="tab"
          aria-controls="tab0"
          aria-selected="true"
          @click="
            getTourList({
              areaCode: selectedSido[1],
              sigunguCode: selectedGugun[1],
            })
          "
        >
          전체
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab1"
          data-bs-toggle="tab"
          value="12"
          data-bs-target="#tab1"
          type="button"
          role="tab"
          aria-controls="tab1"
          aria-selected="false"
          @click="getList(12)"
        >
          관광지
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab2"
          data-bs-toggle="tab"
          value="14"
          data-bs-target="#tab2"
          type="button"
          role="tab"
          aria-controls="tab2"
          aria-selected="false"
          @click="getList(14)"
        >
          문화시설
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab3"
          data-bs-toggle="tab"
          value="15"
          data-bs-target="#tab3"
          type="button"
          role="tab"
          aria-controls="tab3"
          aria-selected="false"
          @click="getList(15)"
        >
          행사/공연/축제
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab4"
          data-bs-toggle="tab"
          value="25"
          data-bs-target="#tab4"
          type="button"
          role="tab"
          aria-controls="tab4"
          aria-selected="false"
          @click="getList(25)"
        >
          여행코스
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab5"
          data-bs-toggle="tab"
          value="28"
          data-bs-target="#tab5"
          type="button"
          role="tab"
          aria-controls="tab5"
          aria-selected="false"
          @click="getList(28)"
        >
          레포츠
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab6"
          data-bs-toggle="tab"
          value="32"
          data-bs-target="#tab6"
          type="button"
          role="tab"
          aria-controls="tab6"
          aria-selected="false"
          @click="getList(32)"
        >
          숙박
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab7"
          data-bs-toggle="tab"
          value="38"
          data-bs-target="#tab7"
          type="button"
          role="tab"
          aria-controls="tab7"
          aria-selected="false"
          @click="getList(38)"
        >
          쇼핑
        </button>
      </li>
      <li class="nav-item" role="presentation">
        <button
          class="nav-link contenttype btn mr-1"
          id="tab8"
          data-bs-toggle="tab"
          value="39"
          data-bs-target="#tab8"
          type="button"
          role="tab"
          aria-controls="tab8"
          aria-selected="false"
          @click="getList(39)"
        >
          음식점
        </button>
      </li>
    </ul>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import BaseDropdown from "../TemplateComponents/BaseDropdown.vue";
const tourStore = "tourStore";

export default {
  name: "TourHeader",
  components: {
    BaseDropdown,
  },
  data() {
    return {
      sidoBtn: "시도",
      gugunBtn: "구군",
      contentBtn: "",
    };
  },
  methods: {
    ...mapActions(tourStore, ["getSidoList", "getGugunList", "getTourList"]),
    async getList(contentTypeId) {
      await this.getTourList({
        areaCode: this.selectedSido[1],
        sigunguCode: this.selectedGugun[1],
        contentTypeId: contentTypeId,
      });
    },
  },
  computed: {
    ...mapState(tourStore, [
      "selectedSido",
      "selectedGugun",
      "sidoList",
      "gugunList",
      "tourList",
    ]),
  },
  watch: {},
  created() {
    this.getSidoList();
    // this.$store.selectedSido = ["시도", 0];
    // this.$store.selectedGugun = ["구군", 0];
  },
};
</script>

<style scoped>
.scroll::-webkit-scrollbar {
  width: 12px;
}
</style>
