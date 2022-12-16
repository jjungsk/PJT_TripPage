import { apiInstance } from "./http.js";

const api = apiInstance();

function previewNotice(success, fail) {
  api.get(`/notice/preview`).then(success).catch(fail);
}

function listNotice(param, success, fail) {
  api.get(`/notice/list`, { params: param }).then(success).catch(fail);
}

function viewNotice(articleNo, success, fail) {
  api.get(`/notice/view/${articleNo}`).then(success).catch(fail);
}

function writeNotice(article, success, fail) {
  api.post(`/notice/write`, JSON.stringify(article)).then(success).catch(fail);
}

function modifyNotice(article, success, fail) {
  api.put(`/notice/modify`, JSON.stringify(article)).then(success).catch(fail);
}

function deleteNotice(articleNo, success, fail) {
  api.delete(`/notice/view/${articleNo}`).then(success).catch(fail);
}

export { previewNotice, listNotice, writeNotice, viewNotice, modifyNotice, deleteNotice };
