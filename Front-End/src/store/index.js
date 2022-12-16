import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";
// module import
import memberStore from "@/store/modules/memberStore";
import boardStore from "@/store/modules/boardStore";
import noticeStore from "@/store/modules/noticeStore";
import sunStore from "@/store/modules/sunStore";
import planStore from "@/store/modules/planStore";
import tourStore from "@/store/modules/tourStore";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    memberStore,
    boardStore,
    sunStore,
    planStore,
    noticeStore,
    tourStore,
  },
  plugins: [
    createPersistedState({
      // 브라우저 종료시 제거하기 위해 localStorage가 아닌 sessionStorage로 변경. (default: localStorage)
      storage: sessionStorage,
    }),
  ],
});
