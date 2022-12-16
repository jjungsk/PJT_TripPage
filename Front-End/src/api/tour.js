import { apiInstance } from "./http.js";

const api = apiInstance();

// (1) 시도 코드 얻어오기
async function apiGetSidoList(success, fail) {
  await api.get(`/tour/list`).then(success).catch(fail);
}
// (2) 시도코드를 바탕으로 구군 코드 얻어오기
async function apiGetGugunList(data, success, fail) {
  await api.get(`/tour/list/${data}`).then(success).catch(fail);
}

// (3) 투어 정보 구하기
async function apiGetTourList(data, success, fail) {
  await api.post(`/tour/getdata`, data).then(success).catch(fail);
}

export { apiGetSidoList, apiGetGugunList, apiGetTourList };