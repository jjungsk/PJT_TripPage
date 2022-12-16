import { sunRiseSetInfo } from "@/api/sun";

const sunStore = {
  namespaced: true,
  state: {
    sunRiseSetState: {
      location: "",
      sunRiseHour: 0,
      sunRiseMinutes: 0,
      sunSetHour: 0,
      sunSetMinutes: 0,
    },
  },
  getters: {},
  mutations: {
    SET_SUN_INFO(state, data) {
      state.sunRiseSetState.location = data.location;
      state.sunRiseSetState.sunRiseHour = data.sunrise.substring(0, 2);
      state.sunRiseSetState.sunRiseMinutes = data.sunrise.substring(2, 4);
      state.sunRiseSetState.sunSetHour = data.sunset.substring(0, 2);
      state.sunRiseSetState.sunSetMinutes = data.sunset.substring(2, 4);
    },
  },
  actions: {
    getSunInfo: ({ commit }, params) => {
      if (params.locdate) {
        let longitudeDo = parseInt(params.longitude);
        let longitudeBun = parseInt((params.longitude - longitudeDo) * 60);
        params.longitude = longitudeDo * 100 + longitudeBun;

        let latitudeDo = parseInt(params.latitude);
        let latitudeBun = parseInt((params.latitude - latitudeDo) * 60);
        params.latitude = latitudeDo * 100 + latitudeBun;

        params.locdate = params.locdate.replace(/-/g, "");
        params.dnYn = "N";
        params.ServiceKey = process.env.VUE_APP_API_RISESET_KEY;

        sunRiseSetInfo(
          params,
          ({ data }) => {
            commit("SET_SUN_INFO", data.response.body.items.item);
          },
          (error) => {
            console.log(error);
          }
        );
      }
    },
  },
};

export default sunStore;
