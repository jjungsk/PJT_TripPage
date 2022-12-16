import { apiInstance } from "./http.js";

const api = apiInstance();

function previewArticle(success, fail) {
  api.get(`/board/preview`).then(success).catch(fail);
}

function listArticle(param, success, fail) {
  api.get(`/board/list`, { params: param }).then(success).catch(fail);
}

function viewArticle(articleNo, success, fail) {
  api.get(`/board/view/${articleNo}`).then(success).catch(fail);
}

function writeArticle(article, success, fail) {
  api.post(`/board`, JSON.stringify(article)).then(success).catch(fail);
}

function modifyArticle(article, success, fail) {
  api.put(`/board`, JSON.stringify(article)).then(success).catch(fail);
}

function deleteArticle(articleNo, success, fail) {
  api.delete(`/board/view/${articleNo}`).then(success).catch(fail);
}

export { previewArticle, listArticle, writeArticle, viewArticle, modifyArticle, deleteArticle };
