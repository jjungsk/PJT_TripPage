import jwtDecode from "jwt-decode";
import router from "@/router";
import {
  kakaoLogin,
  kakaoInfo,
  login,
  findById,
  findPwd,
  tokenRegeneration,
  logout,
  check,
  regist,
  modify,
  deleteUserInfo,
  kakaoLogout,
} from "@/api/member";

const memberStore = {
  namespaced: true,
  state: {
    userInfo: null,
    isLogin: false, // (1) 로그인
    isValidToken: false,
    isLoginError: false,
    isFindError: false, // (1) 로그인 - 비밀번호 찾기
    userPassword: null, // (1) 로그인 - 비밀번호 찾기 결과
    isRegist: false, // (2) 회원 가입
    isIdCheck: false, // (2) 회원 가입 - 아이디 중복 체크
    isModify: false, // (3) 회원 정보 - 수정
    isDelete: false, // (3) 회원 정보 - 삭제

    modal: {
      login: false, // (1) 로그인 - 메인
      find: false, // (1) 로그인 - 비밀번호 찾기
      registinform: false, // (2~3) 회원가입 & 회원정보 - 모달창
      alarm: false, // (5) 알람창
    },
    alarm: {
      login: false, // (1) 로그인 - 메인
      find: false, // (1) 로그인 - 비밀번호 찾기
      regist: false, // (2) 회원가입 - 메인
      manager: false, // (2) 회원가입 - 매니져
      modify: false, // (3) 회원정보 - 수정
      delete: false, // (3) 회원정보 - 삭제
      logout: false, // (4) 로그아웃 - 메인
      wrong: {
        // (5) 로그아웃 - 잘못된 페이지
        type: Boolean,
        default: false,
      },
    },
  },
  getters: {
    checkUserInfo: function (state) {
      return state.userInfo;
    },
    checkToken: function (state) {
      return state.isValidToken;
    },
  },
  mutations: {
    SET_IS_LOGIN: (state, isLogin) => {
      state.isLogin = isLogin;
    },
    SET_IS_LOGIN_ERROR: (state, isLoginError) => {
      state.isLoginError = isLoginError;
    },
    SET_IS_VALID_TOKEN: (state, isValidToken) => {
      state.isValidToken = isValidToken;
    },
    SET_IS_FIND_ERROR: (state, isFindError) => {
      state.isFindError = isFindError;
    },
    SET_FIND_PASSWORD: (state, userPassword) => {
      state.userPassword = userPassword;
    },
    SET_USER_INFO: (state, userInfo) => {
      state.isLogin = true;
      state.userInfo = userInfo;
    },
    SET_USER_ID_CHECK: (state, isIdCheck) => {
      state.isIdCheck = isIdCheck;
    },
    SET_IS_USER_REGIST: (state, isRegist) => {
      state.isRegist = isRegist;
    },
    SET_IS_USER_MODIFY: (state, isModify) => {
      state.isModify = isModify;
    },
    SET_IS_USER_DELETE: (state, isDelete) => {
      state.isDelete = isDelete;
    },

    // Modal
    // IS_MODAL_CONTROLLER(state, { choose, boolean }) {

    // },
    IS_MODAL_LOGIN: (state, boolean) => {
      state.modal.login = boolean;
    },
    IS_MODAL_FIND: (state, boolean) => {
      state.modal.find = boolean;
    },
    IS_MODAL_REGISTINFORM: (state, boolean) => {
      state.modal.registinform = boolean;
    },
    IS_MODAL_ALARM: (state, boolean) => {
      state.modal.alarm = boolean;
    },

    // Modal - Alarm
    IS_ALARM_LOGIN: (state, boolean) => {
      state.alarm.login = boolean;
    },
    IS_ALARM_FIND: (state, boolean) => {
      state.alarm.find = boolean;
    },
    IS_ALARM_REGIST: (state, boolean) => {
      state.alarm.regist = boolean;
    },
    IS_ALARM_MANAGER: (state, boolean) => {
      state.alarm.manager = boolean;
    },
    IS_ALARM_MODIFY: (state, boolean) => {
      state.alarm.modify = boolean;
    },
    IS_ALARM_DELETE: (state, boolean) => {
      state.alarm.delete = boolean;
    },
    IS_ALARM_LOGOUT: (state, boolean) => {
      state.alarm.logout = boolean;
    },
    IS_ALARM_WRONG: (state, boolean) => {
      state.alarm.wrong = boolean;
    },
  },
  actions: {
    // modalController
    async modalController({ commit }, { choose, boolean }) {
      const CHOOSEN = choose.toUpperCase();
      commit(`IS_MODAL_${CHOOSEN}`, boolean);
    },
    // alarmController
    alarmController({ state, commit }, { choose, boolean }) {
      if (choose == "all") {
        for (let key in state.alarm) {
          const CHOOSEN = key.toUpperCase();
          commit(`IS_ALARM_${CHOOSEN}`, boolean);
        }
      } else {
        const CHOOSEN = choose.toUpperCase();
        commit(`IS_ALARM_${CHOOSEN}`, boolean);
      }
    },

    // (1) 로그인 - 아이디 & 비밀번호 db와 일치하는지 체크
    async userConfirm({ commit }, params) {
      let success = ({ data }) => {
        if (data.message === "success") {
          let accessToken = data["access-token"];
          let refreshToken = data["refresh-token"];
          // console.log("login success token created!!!! >> ", accessToken, refreshToken);
          commit("SET_IS_LOGIN", true);
          commit("SET_IS_LOGIN_ERROR", false);
          commit("SET_IS_VALID_TOKEN", true);
          sessionStorage.setItem("access-token", accessToken);
          sessionStorage.setItem("refresh-token", refreshToken);
          sessionStorage.setItem("service", data.service);
        } else {
          commit("SET_IS_LOGIN", false);
          commit("SET_IS_LOGIN_ERROR", true);
          commit("SET_IS_VALID_TOKEN", false);
        }
      };
      let fail = (error) => {
        console.log(error);
      };
      if (params.service == "default") {
        await login(params, success, fail);
      } else if (params.service == "kakao") {
        await kakaoLogin(params, success, fail);
      }
    },
    // (1) 로그인 - access-token 으로 해당 유저의 정보 가져오기
    // async getUserInfo({ commit, dispatch }, token) {
    async getUserInfo({ commit }, token) {
      let service = sessionStorage.getItem("service");
      let success = ({ data }) => {
        if (data.message === "success") {
          commit("SET_USER_INFO", data.userInfo);
        } else {
          console.log("유저 정보 없음");
        }
      };
      let fail = async (error) => {
        console.log("getUserInfo() error code [토큰 만료되어 사용 불가능.] ::: ", error.response.status);
        commit("SET_IS_VALID_TOKEN", false);
        // await dispatch("tokenRegeneration");
      };

      if (service == "default") {
        let decodeToken = jwtDecode(token);
        await findById(decodeToken.userid, success, fail);
      } else if (service == "kakao") {
        await kakaoInfo(success, fail);
      }
    },
    // (1) 로그인 - token 재발급
    async tokenRegeneration({ commit, state }) {
      console.log("토큰 재발급 >> 기존 토큰 정보 : {}", sessionStorage.getItem("access-token"));
      await tokenRegeneration(
        JSON.stringify(state.userInfo),
        ({ data }) => {
          if (data.message === "success") {
            let accessToken = data["access-token"];
            console.log("재발급 완료 >> 새로운 토큰 : {}", accessToken);
            sessionStorage.setItem("access-token", accessToken);
            commit("SET_IS_VALID_TOKEN", true);
          }
        },
        async (error) => {
          // HttpStatus.UNAUTHORIZE(401) : RefreshToken 기간 만료 >> 다시 로그인!!!!
          if (error.response.status === 401) {
            console.log("갱신 실패");
            // 다시 로그인 전 DB에 저장된 RefreshToken 제거.
            await logout(
              state.userInfo.userid,
              ({ data }) => {
                if (data.message === "success") {
                  console.log("리프레시 토큰 제거 성공");
                } else {
                  console.log("리프레시 토큰 제거 실패");
                }
                alert("RefreshToken 기간 만료!!! 다시 로그인해 주세요.");
                commit("SET_IS_LOGIN", false);
                commit("SET_USER_INFO", null);
                commit("SET_IS_VALID_TOKEN", false);
                router.push({ name: "login" });
              },
              (error) => {
                console.log(error);
                commit("SET_IS_LOGIN", false);
                commit("SET_USER_INFO", null);
              }
            );
          }
        }
      );
    },
    // (1) 로그인 - 비밀번호 찾기
    async findUserInfo({ commit }, user) {
      await findPwd(
        user,
        ({ data }) => {
          if (data.message === "success") {
            commit("SET_IS_FIND_ERROR", true);
            commit("SET_FIND_PASSWORD", data.pass);
          } else {
            commit("SET_IS_FIND_ERROR", false);
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },

    // (2) 회원 가입 - 메인
    async userRegist({ commit }, user) {
      await regist(user, ({ data }) => {
        if (data == 1) {
          commit("SET_IS_USER_REGIST", true);
        } else {
          commit("SET_IS_USER_REGIST", false);
        }
      });
    },
    // (2) 회원 가입 - 중복 아이디 체크
    async userIdCheck({ commit }, userid) {
      await check(userid, ({ data }) => {
        if (data == 1) {
          // id가 죽복 된다면
          commit("SET_USER_ID_CHECK", true);
        } else {
          // id가 중복되지 않다면
          commit("SET_USER_ID_CHECK", false);
        }
      });
    },

    // (3) 회원정보 - 수정
    async userModify({ commit }, user) {
      await modify(
        user,
        ({ data }) => {
          if (data.message === "success") {
            commit("SET_IS_USER_MODIFY", true);
            commit("SET_USER_INFO", data.userInfo);
          } else {
            commit("SET_IS_USER_MODIFY", false);
            console.log("회원 정보 수정 실패");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    // (3) - 회원 정보 - 탈퇴
    async userDelete({ commit }, userid) {
      await deleteUserInfo(
        userid,
        ({ data }) => {
          console.log(data);
          if (data.message === "success") {
            commit("SET_IS_USER_DELETE", true);
            commit("SET_USER_INFO", null);
          } else {
            commit("SET_IS_USER_DELETE", false);
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },

    // (4) 로그아웃 - 메인
    async userLogout({ commit }, userid) {
      let service = sessionStorage.getItem("service");
      let success = ({ data }) => {
        if (data.message === "success") {
          commit("SET_IS_LOGIN", false);
          commit("SET_USER_INFO", null);
          commit("SET_IS_VALID_TOKEN", false);
          sessionStorage.removeItem("access-token"); //저장된 토큰 없애기
          sessionStorage.removeItem("refresh-token"); //저장된 토큰 없애기
        } else {
          console.log("유저 정보 없음");
        }
      };
      let fail = (error) => {
        console.log(error);
      };

      if (service == "default") {
        await logout(userid, success, fail);
      } else if (service == "kakao") {
        await kakaoLogout(success, fail);
      }
    },
  },
};

export default memberStore;
