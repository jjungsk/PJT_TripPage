import Vue from "vue";
import VueRouter from "vue-router";
import AppMain from "../views/AppMain.vue";
import AppHeader from "@/components/common/AppHeader";
import AppFooter from "@/components/common/AppFooter";

import store from "@/store";

Vue.use(VueRouter);

const onlyAuthUser = async (to, from, next) => {
  const checkUserInfo = store.getters["memberStore/checkUserInfo"];
  next();
  if (checkUserInfo === null) {
    let paramsAlarm = { choose: "wrong", boolean: true };
    let ParamsModal = { choose: "alarm", boolean: true };

    store.dispatch("memberStore/alarmController", paramsAlarm);
    store.dispatch("memberStore/modalController", ParamsModal);
  }
};


// const linkAuthUser = async (to, from, next) => {
//   const checkUserInfo = store.getters["memberStore/checkUserInfo"];

//   if (checkUserInfo === null) {
//     router.push({ name: })
//     alert("관리자만 이용 가능한 페이지입니다.");
//   } else {
//     next();
//   }
// };

const onlyAdminUser = async (to, from, next) => {
  const checkUserInfo = store.getters["memberStore/checkUserInfo"];

  if (checkUserInfo === null || checkUserInfo.isManager == 0) {
    alert("관리자만 이용 가능한 페이지입니다.");
  } else {
    next();
  }
};

const routes = [
  {
    path: "/",
    name: "home",
    components: {
      header: AppHeader,
      default: AppMain,
      footer: AppFooter,
    },
    props: true,
  },
  {
    path: "/board",
    name: "board",
    redirect: "/board/list",
    components: {
      header: AppHeader,
      default: () => import("@/views/AppBoard"),
      footer: AppFooter,
    },
    children: [
      {
        path: "list",
        name: "boardlist",
        component: () => import("@/components/board/BoardList"),
      },
      {
        path: "view/:articleNo",
        name: "boardview",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/board/BoardView"),
      },
      {
        path: "write",
        name: "boardwrite",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/board/BoardWrite"),
      },
      {
        path: "modify",
        name: "boardmodify",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/board/BoardModify"),
      },
    ],
  },
  {
    path: "/notice",
    name: "notice",
    redirect: "/notice/list",
    components: {
      header: AppHeader,
      default: () => import("@/views/AppNotice"),
      footer: AppFooter,
    },
    children: [
      {
        path: "list",
        name: "noticelist",
        component: () => import("@/components/notice/NoticeList"),
      },
      {
        path: "view/:articleNo",
        name: "noticeview",
        component: () => import("@/components/notice/NoticeView"),
      },
      {
        path: "write",
        name: "noticewrite",
        beforeEnter: onlyAdminUser,
        component: () => import("@/components/notice/NoticeWrite"),
      },
      {
        path: "modify",
        name: "noticemodify",
        beforeEnter: onlyAdminUser,
        component: () => import("@/components/notice/NoticeModify"),
      },
    ],
  },
  {
    path: "/plan",
    name: "plan",
    beforeEnter: onlyAuthUser,
    components: {
      header: AppHeader,
      default: () => import("@/views/AppPlan"),
    },
  },
  {
    path: "/sun",
    name: "sun",
    beforeEnter: onlyAuthUser,
    components: {
      header: AppHeader,
      default: () => import("@/views/AppSun"),
      footer: AppFooter,
    },
  },
  {
    path: "/tour",
    name: "tour",
    beforeEnter: onlyAuthUser,
    components: {
      header: AppHeader,
      default: () => import("@/views/AppTour"),
      footer: AppFooter,
    },
  },
  {
    path: "*",
    name: "NotFoundPage",
    redirect: "/",
  },

];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
