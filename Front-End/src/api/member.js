import { apiInstance } from "./http.js";

const api = apiInstance();

// (1) 카카오 로그인 - 토큰 얻어오기
async function kakaoLogin(params, success, fail) {
  await api.post(`/user/login/kakao`, params).then(success).catch(fail);
}
// (1) 카카오 로그인 - 토큰으로 회원 정보 불러오기
async function kakaoInfo(success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/user/info/kakao`).then(success).catch(fail);
}

// (1) 로그인 - 아이디 & 비밀번호로 일치 확인
async function login(user, success, fail) {
  await api
    .post(`/user/login/default`, JSON.stringify(user))
    .then(success)
    .catch(fail);
}
// (1) 로그인 - 토큰으로 회원 정보 불러오기
async function findById(userid, success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/user/info/default/${userid}`).then(success).catch(fail);
}
// (1) 로그인 - 아이디와 이름으로 비밀번호 찾기
async function findPwd(user, success, fail) {
  await api
    .post(`user/findPass`, JSON.stringify(user))
    .then(success)
    .catch(fail);
}
// (1) 로그인 - 토큰 재발급
async function tokenRegeneration(user, success, fail) {
  api.defaults.headers["refresh-token"] =
    sessionStorage.getItem("refresh-token"); //axios header에 refresh-token 셋팅
  await api.post(`/user/refresh`, user).then(success).catch(fail);
}

// (2) 회원 가입
async function regist(user, success, fail) {
  await api.post(`/user/join`, JSON.stringify(user)).then(success).catch(fail);
}
// (2) 회원 가입 - 아이디 중복 체크
async function check(userid, success, fail) {
  await api.get(`/user/idcheck/${userid}`).then(success).catch(fail);
}

// (3) 회원 정보 - 수정
async function modify(user, success, fail) {
  await api
    .post(`/user/modify`, JSON.stringify(user))
    .then(success)
    .catch(fail);
}
// (3) 회원 정보 - 삭제
async function deleteUserInfo(userid, success, fail) {
  await api.delete(`/user/delete/${userid}`).then(success).catch(fail);
}

// (4) 로그아웃
async function logout(userid, success, fail) {
  await api.get(`/user/logout/default/${userid}`).then(success).catch(fail);
}

// (4) 카카오 로그아웃
async function kakaoLogout(success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/user/logout/kakao`).then(success).catch(fail);
}

export {
  kakaoLogin,
  kakaoInfo,
  kakaoLogout,
  login,
  findById,
  findPwd,
  tokenRegeneration,
  logout,
  check,
  regist,
  modify,
  deleteUserInfo,
};
