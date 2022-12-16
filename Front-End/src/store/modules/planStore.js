import { viewPlan } from "@/api/plan";

const planStore = {
  namespaced: true,
  state: {
    showLeftRegist: true,
    showLeftView: false,
    planInfo: {},
    planSpotList: [],
    planNum: 0,
    planMarker: {},
  },
  mutations: {
    CLEAR_PLAN(state) {
      state.planSpotList = [];
    },
    ADD_PLANSPOT(state, spot) {
      state.planSpotList.push(spot);
    },
    REMOVE_PLANSPOT(state, spotidx) {
      state.planSpotList.splice(spotidx, 1);
    },
    CHANGE_PLANNUM(state) {
      state.planNum += 1;
    },
    SHOW_LEFT_REGIST(state) {
      state.showLeftRegist = true;
      state.showLeftView = false;
    },
    SHOW_LEFT_VIEW(state) {
      state.showLeftRegist = false;
      state.showLeftView = true;
    },
    SET_PLAN_INFO(state, data) {
      state.planInfo = data;
    },
    SET_PLAN_MARKER(state, data) {
      state.planMarker = data;
    },
    REMOVE_PLAN_MARKER(state) {
      state.planMarker = {};
    },
  },
  actions: {
    showPlanInfo({ commit }, planNo) {
      viewPlan(
        planNo,
        ({ data }) => {
          commit("SET_PLAN_INFO", data);
          commit("SHOW_LEFT_VIEW", data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
  },
};

export default planStore;
