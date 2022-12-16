<template>
  <div>
    <div class="header-blank"></div>
    <div id="plan-sections" class="d-flex">
      <div id="left-section">
        <left-plan-regist v-show="showLeftRegist"></left-plan-regist>
        <left-plan-view v-if="showLeftView"></left-plan-view>
      </div>

      <div id="map-section">
        <kakao-map class="kmap" plannable :options="mapOption"></kakao-map>
      </div>

      <div id="right-section">
        <label id="right-searchbar" class="row">
          <input
            type="text"
            class="form-control"
            placeholder="검색어를 입력하세요"
            v-model="searchword"
            @keyup.enter="search"
          />
          <button @click="search">
            <i class="fa fa-search"></i>
          </button>
        </label>
        <div id="options-plan" class="d-flex">
          <input
            type="radio"
            name="options-plan"
            id="option-plan-recommend"
            checked
          />
          <label
            class="btn btn-secondary"
            for="option-plan-recommend"
            @click="recommend"
            >장소 추천</label
          >
          <input type="radio" name="options-plan" id="option-plan-list" />
          <label
            class="btn btn-secondary"
            for="option-plan-list"
            @click="showPlanList"
            >일정 목록</label
          >
        </div>
        <right-recommend v-if="showRightRecommend"></right-recommend>
        <right-search-list
          :word="searchwordSend"
          v-if="showRightSearch"
        ></right-search-list>
        <right-plan-list v-if="showRightPlan"></right-plan-list>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import KakaoMap from "@/components/common/KakaoMap";
import LeftPlanRegist from "@/components/plan/LeftPlanRegist";
import LeftPlanView from "@/components/plan/LeftPlanView";
import RightRecommend from "@/components/plan/RightRecommend";
import RightSearchList from "@/components/plan/RightSearchList";
import RightPlanList from "@/components/plan/RightPlanList";

export default {
  name: "AppPlan",
  components: {
    KakaoMap,
    LeftPlanRegist,
    LeftPlanView,
    RightRecommend,
    RightSearchList,
    RightPlanList,
  },
  data() {
    return {
      searchword: "",
      searchwordSend: "",
      // showLeftRegist: false,
      // showLeftView: true,
      showRightRecommend: true,
      showRightSearch: false,
      showRightPlan: false,
      mapOption: {
        center: {
          lat: 37.5013167,
          lng: 127.039593,
        },
        level: 8,
      },
    };
  },
  created() {
    let planNo = this.$route.query.planNo;
    if (planNo) {
      this.showPlanList();
      // this.showPlanInfo(planNo);
    }
  },
  computed: {
    ...mapState("planStore", ["showLeftRegist", "showLeftView"]),
  },
  methods: {
    ...mapActions("planStore", ["showPlanInfo"]),
    search() {
      if (!this.searchword) {
        alert("검색어를 입력해주세요.");
        return;
      }
      this.searchwordSend = this.searchword;
      this.showRightRecommend = false;
      this.showRightPlan = false;
      this.showRightSearch = true;
    },
    recommend() {
      this.showRightPlan = false;
      this.showRightSearch = false;
      this.showRightRecommend = true;
    },
    showPlanList() {
      this.showRightRecommend = false;
      this.showRightSearch = false;
      this.showRightPlan = true;
    },
  },
};
</script>

<style scoped>
#right-searchbar {
  position: relative;
}
#right-searchbar button {
  position: absolute;
  top: 10px;
  right: 5px;
  background-color: transparent;
  border-width: 0px;
}
#right-searchbar button:hover {
  cursor: pointer;
}
#right-searchbar button:focus {
  outline: 0;
}
#plan-sections {
  height: calc(100vh - 89px);
}
#left-section {
  width: 220px;
}
#map-section {
  flex-grow: 1;
}
#right-section {
  width: 250px;
}
.kmap {
  width: 100%;
  height: 100%;
}

input,
textarea {
  border-radius: 0;
}
[type="radio"] {
  appearance: none;
}
#options-plan label {
  width: 50%;
  margin-right: 0;
}
</style>
