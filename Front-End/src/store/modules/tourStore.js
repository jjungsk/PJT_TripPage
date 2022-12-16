import { apiGetSidoList, apiGetGugunList, apiGetTourList } from "@/api/tour.js";

const tourStore = {
  namespaced: true,
  state: {
    selectedSido: [],
    selectedGugun: [],
    sidoList: [],
    gugunList: [],
    tourList: [],
  },
  mutations: {
    SET_AREA_CDOE(state, sido) {
      state.selectedSido[0] = sido.name;
      state.selectedSido[1] = sido.areaCode;
    },
    SET_GUGUN_CODE(state, gugun) {
      state.selectedGugun[0] = gugun.name;
      state.selectedGugun[1] = gugun.sigunguCode;
    },
    GET_SIDO_LIST(state, sidoList) {
      state.sidoList = sidoList;
    },
    GET_GUGUN_LIST(state, gugunList) {
      state.gugunList = gugunList;
    },
    GET_TOUR_LIST(state, tourList) {
      state.tourList = tourList;
    }
  },
  actions: {
    async getSidoList({ commit }) {
      await apiGetSidoList(
        ({ data }) => {
          commit("GET_SIDO_LIST", data.sidoList);
        },
        (error) => {
          console.log(error);
        }
      )
    },
    async getGugunList({ commit }, sido) {
      commit("SET_AREA_CDOE", sido);
      // commit("SET_GUGUN_CODE", {"name":"구군"});
      await apiGetGugunList(
        sido.areaCode,
        ({ data }) => {
          commit("GET_GUGUN_LIST", data.gugunList);
        },
        (error) => {
          console.log(error);
        }
      )
    },
    async getTourList({ commit }, info) {
      commit("SET_GUGUN_CODE", info);
      await apiGetTourList(
        info,
        ({ data }) => {
          commit("GET_TOUR_LIST", data.tourList);
        },
        (error) => {
          console.log(error);
        }
      )
    }
  },
};

export default tourStore;
