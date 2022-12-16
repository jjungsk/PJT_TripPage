import { sunInstance } from "./http.js";

const sun = sunInstance();

function sunRiseSetInfo(params, success, fail) {
  sun.get(``, { params: params }).then(success).catch(fail);
}

export { sunRiseSetInfo };
