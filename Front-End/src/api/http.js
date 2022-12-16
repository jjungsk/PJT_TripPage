import axios from "axios";

// local vue api axios instance
function apiInstance() {
  const instance = axios.create({
    baseURL: process.env.VUE_APP_API_BASE_URL,
    headers: {
      "Content-Type": "application/json;charset=utf-8",
    },
  });
  return instance;
}

// sun-riseset-info-service api axios instance
function sunInstance() {
  const instance = axios.create({
    baseURL: process.env.VUE_APP_API_RISESET_URL,
  });
  return instance;
}

export { apiInstance, sunInstance };
