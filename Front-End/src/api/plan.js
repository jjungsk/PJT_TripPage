import { apiInstance } from "./http.js";

const api = apiInstance();

function recommend(success, fail) {
  api.get(`/plan/recommend`).then(success).catch(fail);
}

function search(word, success, fail) {
  api.get(`/plan/search?word=${word}`).then(success).catch(fail);
}

function writePlan(plan, success, fail) {
  api.post(`/plan/regist`, JSON.stringify(plan)).then(success).catch(fail);
}

function listPlan(success, fail) {
  api.get(`/plan/list`).then(success).catch(fail);
}

function viewPlan(planNo, success, fail) {
  api.get(`/plan/${planNo}`).then(success).catch(fail);
}

function deletePlan(planNo, success, fail) {
  api.delete(`/plan/${planNo}`).then(success).catch(fail);
}

export { recommend, search, writePlan, listPlan, viewPlan, deletePlan };
