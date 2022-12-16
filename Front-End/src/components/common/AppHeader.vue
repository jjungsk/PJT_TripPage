<template>
  <header class="header-global">
    <!-- Main NavBar Start -->
    <base-nav
      class="navbar-main"
      id="navbar-header"
      transparent
      :type="bgstate"
      effect="light"
      expand
    >
      <!-- EnjoyTrip Main Logo -->
      <router-link slot="brand" class="navbar-brand mr-lg-5" to="/">
        <img
          src="/img/trip/logo_color_symbol_2.png"
          alt="logo"
          style="height: 3em"
        />
        <font size="4em">Enjoy Trip</font>
        <!-- <div v-if></div> -->
      </router-link>

      <!-- Hambuger Menu Logo Close Button -->
      <div class="row" slot="content-header" slot-scope="{ closeMenu }">
        <div class="col-6 collapse-brand">
          <router-link slot="brand" class="navbar-brand mr-lg-5" to="/">
            <img src="/img/trip/logo_color_symbol_2.png" />
            <font size="4em" color="skyblue">Enjoy Trip</font>
          </router-link>
        </div>
        <div class="col-6 collapse-close">
          <close-button @click="closeMenu"></close-button>
        </div>
      </div>

      <!-- Navbar Left Component - Page & Board Start-->
      <ul class="navbar-nav navbar-nav-hover align-items-lg-center">
        <base-dropdown class="nav-item" menu-classes="dropdown-menu-xl">
          <a
            slot="title"
            href="#"
            class="nav-link"
            data-toggle="dropdown"
            role="button"
          >
            <i class="ni ni-bullet-list-67"></i>
            <span class="nav-link-inner--text">Page</span>
          </a>
          <div class="dropdown-menu-inner">
            <router-link
              :to="{ name: 'sun' }"
              class="media d-flex align-items-center"
            >
              <div
                class="icon icon-shape bg-gradient-warning rounded-circle text-white"
              >
                <i class="ni ni-atom"></i>
              </div>
              <div class="media-body ml-3">
                <h6 class="heading text-warning mb-md-1">일출 일몰</h6>
                <p class="description d-none d-md-inline-block mb-0">
                  인생샷을 남기고 싶다면? <br />
                  해가 뜨고 해가 지는 아름다운 여행지
                </p>
              </div>
            </router-link>
            <router-link
              :to="{ name: 'tour' }"
              class="media d-flex align-items-center"
            >
              <div
                class="icon icon-shape bg-gradient-warning rounded-circle text-white"
              >
                <i class="ni ni-map-big"></i>
              </div>
              <div class="media-body ml-3">
                <h5 class="heading text-warning mb-md-1">여행지 목록</h5>
                <p class="description d-none d-md-inline-block mb-0">
                  목적지만 선택하면 주변 정보가 한 눈에 <br />
                  다양한 여행지 목록을 확인하세요
                </p>
              </div>
            </router-link>
            <router-link
              :to="{ name: 'plan' }"
              class="media d-flex align-items-center"
            >
              <div
                class="icon icon-shape bg-gradient-warning rounded-circle text-white"
              >
                <i class="ni ni-compass-04"></i>
              </div>
              <div class="media-body ml-3">
                <h5 class="heading text-warning mb-md-1">여행 계획</h5>
                <p class="description d-none d-md-inline-block mb-0">
                  추천 여행지 부터 가고 싶은 여행지 까지<br />
                  나만의 여행 일정을 만들어보세요
                </p>
              </div>
            </router-link>
          </div>
        </base-dropdown>
        <base-dropdown tag="li" class="nav-item">
          <a
            slot="title"
            href="#"
            class="nav-link"
            data-toggle="dropdown"
            role="button"
          >
            <i class="ni ni-bullet-list-67"></i>
            <span class="nav-link-inner--text">Board</span>
          </a>
          <div
            @click="moveNotice"
            class="dropdown-item media d-flex align-items-center mb-0 cursor"
          >
            <div
              class="icon-shape bg-gradient-warning rounded-circle text-white"
            >
              <i class="ni ni-notification-70"></i>
            </div>
            <div class="media-body ml-3 mt-3">
              <p class="fs-3">공지사항</p>
            </div>
          </div>
          <div
            @click="moveBoard"
            class="dropdown-item media d-flex align-items-center cursor"
          >
            <div
              class="icon-shape bg-gradient-warning rounded-circle text-white"
            >
              <i class="ni ni-chat-round"></i>
            </div>
            <div class="media-body ml-3 mt-3">
              <p class="fs-3">게시판</p>
            </div>
          </div>
        </base-dropdown>
      </ul>
      <!-- Navbar Left Component - Page & Board End -->

      <!-- Navbar Right Component - Login Start -->
      <ul class="navbar-nav align-items-lg-center ml-lg-auto">
        <li
          class="mr-3 username-id"
          variant="primary"
          v-if="userInfo"
          style="color: white; font-weight: "
        >
          {{ userInfo.name }}({{ userInfo.id }})
        </li>
        <li class="nav-item" v-if="userInfo == null">
          <a
            class="nav-link nav-link-icon"
            style="cursor: pointer"
            target="_blank"
            rel="noopener"
            data-toggle="tooltip"
            @click="modalChange('login', true), getCookieValue('enjoy_id')"
          >
            <i class="ni ni-button-power"></i>
            <span class="nav-link-inner--text d-lg">Log-In</span>
          </a>
        </li>
        <li class="nav-item" v-if="userInfo">
          <a
            class="nav-link nav-link-icon"
            style="cursor: pointer"
            target="_blank"
            rel="noopener"
            data-toggle="tooltip"
          >
            <i class="ni ni-button-power"></i>
            <span
              class="nav-link-inner--text d-lg"
              @click.prevent="onClickLogout"
              >Log-Out</span
            >
          </a>
        </li>
        <li class="nav-item" v-if="userInfo == null">
          <a
            class="nav-link nav-link-icon"
            style="cursor: pointer"
            target="_blank"
            rel="noopener"
            data-toggle="tooltip"
            @click="modalChange('registinform', true), initUser()"
          >
            <i class="ni ni-single-copy-04"></i>
            <span class="nav-link-inner--text d-lg">Register</span>
          </a>
        </li>
        <li class="nav-item" v-if="userInfo">
          <a
            class="nav-link nav-link-icon"
            style="cursor: pointer"
            target="_blank"
            rel="noopener"
            data-toggle="tooltip"
            @click="modalChange('registinform', true), getUser()"
          >
            <i class="ni ni-single-02"></i>
            <span class="nav-link-inner--text d-lg">Info.</span>
          </a>
        </li>
      </ul>
      <!-- Navbar Right Component - Login End -->
    </base-nav>
    <!-- Main NavBar End -->

    <!-- Modal-Login Start -->
    <modal
      :show.sync="modal.login"
      body-classes="p-2"
      modal-classes="modal-dialog-centered modal-sm"
      @close="closeModal('login', false)"
    >
      <h6 slot="header"></h6>
      <the-card
        type="secondary"
        shadow
        header-classes="bg-white pb-5"
        body-classes="px-lg-5 py-lg-5"
        class="border-0"
      >
        <template>
          <div class="text-muted text-center mb-3">
            <h2>Login</h2>
          </div>
        </template>
        <template>
          <form role="form" id="login-form">
            <div class="alert alert-danger" role="alert" v-if="isLoginError">
              아이디 또는 비밀번호를 확인하세요.
            </div>
            <base-input
              alternative
              type="text"
              class="mb-3"
              placeholder="ID"
              addon-left-icon="ni ni-check-bold"
              v-model="user.id"
            >
            </base-input>
            <base-input
              alternative
              type="password"
              placeholder="Password"
              addon-left-icon="ni ni-lock-circle-open"
              v-model="user.password"
              @keyup.enter="confirm"
            >
            </base-input>
            <base-checkbox @input="saveId" :checked="isChecked == true">
              Remember me
            </base-checkbox>
            <div class="btn-wrapper text-center mt-4">
              <base-button type="neutral" @click="kakaoConfirm()">
                Kakao
              </base-button>
            </div>
            <div class="text-center text-muted mb-2">
              <small>Or sign in with credentials</small>
            </div>
            <div class="text-center">
              <base-button type="button" class="my-4" @click="confirm()"
                >로그인</base-button
              >
              <base-button
                type="button"
                class="my-4"
                @click="modalChange('login', false), modalChange('find', true)"
                >비밀번호 찾기</base-button
              >
            </div>
          </form>
        </template>
      </the-card>
    </modal>
    <!-- Modal-Login End -->

    <!-- Modal-Find-Password Start -->
    <modal
      :show.sync="modal.find"
      body-classes="p-2"
      modal-classes="modal-dialog-centered modal-sm"
      @close="closeModal('find', false)"
    >
      <h6 slot="header"></h6>
      <the-card
        type="secondary"
        shadow
        header-classes="bg-white pb-5"
        body-classes="px-lg-5 py-lg-5"
        class="border-0"
      >
        <template>
          <div class="text-muted text-center mb-3">
            <h2>Find</h2>
          </div>
        </template>
        <template>
          <form role="form" id="find-form">
            <div class="alert alert-danger" role="alert" v-if="isFindChecked">
              아이디 또는 이름을 확인하세요.
            </div>
            <base-input
              alternative
              type="text"
              class="mb-3"
              placeholder="ID"
              addon-left-icon="ni ni-check-bold"
              v-model="user.id"
            >
            </base-input>
            <base-input
              alternative
              type="text"
              placeholder="Name"
              addon-left-icon="ni ni-ruler-pencil"
              v-model="user.name"
            >
            </base-input>
            <div class="text-center">
              <base-button type="button" class="my-4" @click="findPwd"
                >찾기</base-button
              >
            </div>
          </form>
        </template>
      </the-card>
    </modal>
    <!-- Modal-Find-Password End -->

    <!-- Modal-Register-Info Start -->
    <modal
      :show.sync="modal.registinform"
      body-classes="p-2"
      modal-classes="modal-dialog-centered modal-sm"
      @close="closeModal('registinform', false)"
    >
      <h6 slot="header"></h6>
      <the-card
        type="secondary"
        shadow
        header-classes="bg-white pb-5"
        body-classes="px-lg-5 py-lg-5"
        class="border-0"
      >
        <template>
          <div class="text-muted text-center mb-3">
            <h2 v-if="!userInfo">Sign-Up</h2>
            <h2 v-if="userInfo">Info.</h2>
          </div>
        </template>
        <template>
          <form role="form" id="register-form">
            <div
              class="alert alert-danger"
              role="alert"
              v-if="!userInfo && isIdCheck"
            >
              중복된 아이디
            </div>
            <div
              class="alert alert-danger"
              role="alert"
              v-if="!userInfo && isIdLength"
            >
              최소 6글자 이상의 아이디 입력이 필요합니다
            </div>
            <base-input
              alternative
              class="mb-3"
              placeholder="ID"
              addon-left-icon="ni ni-check-bold"
              v-model="registerinfo.id"
              :disabled="userInfo"
              :leftIconClasses="icongrayClass"
              v-on:keyup="idcheck"
              @blur="idLength"
            >
            </base-input>
            <base-input
              alternative
              type="password"
              placeholder="Password"
              addon-left-icon="ni ni-lock-circle-open"
              v-model="registerinfo.password"
            >
            </base-input>
            <div class="alert alert-danger" role="alert" v-if="isConPwd">
              비밀번호가 일치하지 않습니다
            </div>
            <base-input
              alternative
              type="password"
              placeholder="Confirm Password"
              addon-left-icon="ni ni-lock-circle-open"
              v-if="!userInfo"
              v-model="registerinfo.userConPwd"
              @blur="confirmPWd"
            >
            </base-input>
            <base-input
              alternative
              placeholder="Name"
              addon-left-icon="ni ni-ruler-pencil"
              :leftIconClasses="icongrayClass"
              v-model="registerinfo.name"
              :disabled="userInfo"
            >
            </base-input>
            <base-input
              alternative
              class="mb-3"
              placeholder="Email"
              addon-left-icon="ni ni-email-83"
              v-model="registerinfo.email"
            >
            </base-input>
            <base-input
              alternative
              class="mb-3"
              placeholder="Tel"
              addon-left-icon="ni ni-mobile-button"
              v-model="registerinfo.tel"
            >
            </base-input>
            <base-checkbox @input="checkedBoxManager" v-if="!userInfo">
              Are you a manager?
            </base-checkbox>
            <div class="mt-2" v-if="isManagerChecked">
              <base-input
                alternative
                type="password"
                class="mb-3"
                placeholder="Enter the manager number"
                addon-left-icon="ni ni-lock-circle-open"
                v-model="managerInputNumber"
              >
              </base-input>
            </div>
            <div class="text-center">
              <div v-if="!userInfo">
                <base-button
                  type="sumbit"
                  class="my-4"
                  @click="registUser"
                  :disabled="
                    registerinfo.password.length < 1 ||
                    registerinfo.userConPwd.length < 1 ||
                    registerinfo.name.length < 1 ||
                    registerinfo.email.length < 1 ||
                    registerinfo.tel.length < 1 ||
                    isIdCheck ||
                    isConPwd ||
                    isIdLength
                  "
                  >회원 가입</base-button
                >
              </div>
              <div v-if="userInfo && defaultUser">
                <base-button
                  type="sumbit"
                  class="my-4"
                  @click="modifyUser"
                  :disabled="
                    registerinfo.password.length < 1 ||
                    registerinfo.email.length < 1 ||
                    registerinfo.tel.length < 1
                  "
                  >회원정보 수정</base-button
                >
                <base-button type="button" class="my-4" @click="deleteUser"
                  >회원 탈퇴</base-button
                >
                <!-- <base-button
                  type="button"
                  class="my-4"
                  @click="modals.register = false"
                  >취소</base-button
                > -->
              </div>
            </div>
          </form>
        </template>
      </the-card>
    </modal>
    <!-- Modal-Register-Info End -->

    <!-- Modal-알람창 Start -->
    <modal
      :show.sync="modal.alarm"
      gradient="danger"
      modal-classes="modal-danger modal-dialog-centered"
      @close="
        modalChange('alarm', false),
          modalChange('login', alarm.wrong),
          alarmChange('all', false)
      "
      id="modal-alarm"
    >
      <h6 slot="header" class="modal-title" id="modal-title-notification">
        알림창
      </h6>

      <div class="py-1 text-center">
        <i class="ni ni-bell-55 ni-3x mb-4"></i>
        <h4 class="text-white" v-if="alarm.login == true">
          {{ userInfo.name }}님 환영합니다
        </h4>
        <h2 class="text-white" v-if="alarm.regist == true">회원가입 성공</h2>
        <h2 class="text-white" v-if="alarm.manager == true">
          매니져 번호가 틀립니다
        </h2>
        <h2 class="text-white" v-if="alarm.find == true">
          회원님의 비밀번호<br />{{ userPassword }}
        </h2>
        <h2 class="text-white" v-if="alarm.modify == true">정보수정 완료</h2>
        <h2 class="text-white" v-if="alarm.delete == true">회원탈퇴 완료</h2>
        <h4 class="text-white" v-if="alarm.logout == true">
          로그아웃 되었습니다
        </h4>
        <h4 class="text-white" v-if="alarm.wrong == true">
          로그인 후 이용 가능 페이지
        </h4>
      </div>
    </modal>
    <!-- Modal-알람창 End -->
  </header>
</template>
<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";
const memberStore = "memberStore";

import BaseNav from "@/components/TemplateComponents/BaseNav";
import CloseButton from "@/components/TemplateComponents/CloseButton";
import Modal from "@/components/TemplateComponents/Modal.vue";
import BaseCheckbox from "@/components/TemplateComponents/BaseCheckbox.vue";
import BaseButton from "@/components/TemplateComponents/BaseButton.vue";

export default {
  props: {
    bgstate: {
      type: String,
      default: "",
    },
  },
  components: {
    BaseNav,
    CloseButton,
    Modal,
    BaseCheckbox,
    BaseButton,
  },
  data() {
    return {
      // (1) 로그인 정보
      user: {
        id: null,
        password: null,
        name: null,
        saveid: null,
      },
      // (2) 회원 가입 && (3) 회원 정보
      registerinfo: {
        id: null,
        password: "",
        userConPwd: "",
        name: "",
        email: "",
        tel: "",
        isManager: "",
      },
      cookieId: null, // (1) 로그인 - saveid 체크 여부 확인 -> "1" == checked, "0" == unchecked
      isChecked: false, // (1) 로그인 - 아이디 저장 체크
      isFindChecked: false, // (1) 로그인 - 비밀번호 찾기 : boolean
      isIdLength: false, // (2) 회원 가입 - 아이디 길이 6글자 이상인지 확인
      isConPwd: false, // (2) 회원 가입 - 비밀번호 동일 여부 확인
      isManagerChecked: false, // (2) 회원 가입 - manager 체크박스 체크 여부
      managerInputNumber: null, // (2) 회원 가입 - manager 번호 확인
      icongrayClass: "",
    };
  },
  computed: {
    ...mapState(memberStore, [
      "isLogin",
      "isLoginError",
      "userInfo",
      "userPassword",
      "isFindError",
      "isIdCheck",
      "isRegist",
      "isModify",
      "isDelete",
      // *************
      "modal",
      "alarm",
    ]),
    ...mapGetters(["checkUserInfo"]),
    defaultUser() {
      if (sessionStorage.getItem("service") == "default") {
        return true;
      } else {
        return false;
      }
    },
    ...mapState("boardStore", [
      "key",
      "word",
      "pgno",
      "totalData",
      "dataPerPage",
      "articles",
    ]),
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo", "findUserInfo"]), // (1) 로그인 & 비밀번호 찾기 함수
    ...mapActions(memberStore, ["userIdCheck", "userRegist"]), // (2) 회원가입 함수
    ...mapActions(memberStore, ["userModify", "userDelete"]), // (3) 회원정보 수정 & 탈퇴 함수
    ...mapActions(memberStore, ["userLogout"]), // (4) 로그아웃 함수
    ...mapActions(memberStore, ["modalController", "alarmController"]),
    ...mapMutations(memberStore, ["IS_ALARM_LOGIN", "SET_USER_INFO"]),
    ...mapMutations(["boardStore/CLEAR_KEYWORD"]),
    ...mapMutations(["noticeStore/CLEAR_KEYWORD"]),

    moveNotice() {
      this["noticeStore/CLEAR_KEYWORD"]();
      this.$router.push({ name: "notice" });
    },
    moveBoard() {
      this["boardStore/CLEAR_KEYWORD"]();
      this.$router.push({ name: "board" });
    },

    // 함수
    async modalChange(choose, boolean) {
      await this.modalController({ choose, boolean });
    },
    async alarmChange(choose, boolean) {
      await this.alarmController({ choose, boolean });
    },
    async closeModal(choose, boolean) {
      await this.modalController({ choose, boolean });
      if (!this.userInfo && this.$route.name != "home") {
        this.$router.push("/");
      }
    },

    kakaoConfirm() {
      let REST_API_KEY = `${process.env.VUE_APP_KAKAO_REST_KEY}`;
      let REDIRECT_URI = document.location.href.split("?")[0]; // state param 써서 파라미터 되돌아오게 만들기
      // if (REDIRECT_URI.charAt(REDIRECT_URI.length - 1) == "/")
      //   REDIRECT_URI = REDIRECT_URI.slice(0, -1);
      let href = `https://kauth.kakao.com/oauth/authorize?client_id=${REST_API_KEY}&redirect_uri=${REDIRECT_URI}&response_type=code&state=kakao`;
      if (this.$route.query.planNo) {
        let planNo = this.$route.query.planNo;
        location.href = href + `planNo${planNo}`;
      } else {
        location.href = href;
      }
    },

    // (1) 로그인 - 메인 : db 체크 & saveid 쿠키 설정 & 로그인 정보 불러오기
    async confirm() {
      let param = this.user;
      param.service = "default";
      await this.userConfirm(param); // 로그인 - 아이디&비밀번호 db와 일치하는지 체크 함수
      let token = sessionStorage.getItem("access-token"); // sessionStorage에서 "access-token" 가져오기
      // console.log("1. confirm() token >> " + token);
      if (this.isLogin) {
        await this.getUserInfo(token); // 로그인 - 1차 db와 일치한다면 token으로 해당 유저 정보 가져오기
        // 쿠키 설정
        if (this.isChecked) {
          this.$cookies.set("enjoy_id", this.user.id);
        } else {
          this.$cookies.remove("enjoy_id");
          this.cookieId = null;
          //모든 쿠키 다 지우기
          // this.$cookies.keys().forEach(cookie => this.$cookies.remove(cookie));
        }
        // 로그인 모달창 닫기
        this.modalChange("login", false);
        this.alarmChange("all", false);
        this.alarmChange("login", true);
        this.modalChange("alarm", true);

        this.user.id = null;
        this.user.password = null;
      }
    },
    // (1) 로그인 - saveid check : 체크 여부 확인
    saveId(data) {
      if (data == true) {
        this.isChecked = true;
        this.user.saveid = "1";
      } else {
        this.isChecked = false;
        this.user.saveid = "0";
      }
    },
    // (1) 로그인 - cookie 저장된 아이디 불러오기 : 체크 되었다면 쿠기에 저장된 아이디 불러오기
    getCookieValue(key) {
      // cookie에 저장된 userId 불러오기
      let cookieKey = key + "=";
      let result = "";
      const cookieArr = document.cookie.split(";");

      for (let i = 0; i < cookieArr.length; i++) {
        if (cookieArr[i][0] === " ") {
          cookieArr[i] = cookieArr[i].substring(1);
        }

        if (cookieArr[i].indexOf(cookieKey) === 0) {
          this.user.id = cookieArr[i].slice(
            cookieKey.length,
            cookieArr[i].length
          );
          this.isChecked = true;
          return this.user.id;
        }
      }
      return result;
    },
    // (1) 로그인 - 비밀번호 찾기
    async findPwd() {
      await this.findUserInfo(this.user);
      if (this.isFindError) {
        // 비밀번호 찾기 성공
        this.modalChange("find", false);
        // this.modals.find = false;
        this.isFindChecked = false;

        this.alarmChange("all", false);
        this.alarmChange("find", true);
        this.modalChange("alarm", true);
      } else {
        // 비밀번호 찾기 실패
        this.isFindChecked = true;
      }
    },

    // (2) 회원 가입 - 메인
    async registUser() {
      var managerNumber = "1111"; // 매니져 번호 설정

      if (this.isManagerChecked) {
        // 매니져 체크가 되어 있다면
        if (this.managerInputNumber == managerNumber) {
          // 매니져 번호가 맞다면
          this.registerinfo.isManager = "1";
          this.alarmChange("manager", false);
          await this.userRegist(this.registerinfo);
          this.modalChange("registinform", false);
          this.alarmChange("all", false);
          this.alarmChange("regist", true);
        } else {
          // 매니져 번호가 틀리다면
          this.alarmChange("all", false);
          this.alarmChange("manager", true);
        }
        this.modalChange("alarm", true);
      } else {
        // 일반 유저 회원 가입 이라면
        await this.userRegist(this.registerinfo);
        this.modalChange("registinform", false);
        this.alarmChange("all", false);
        this.alarmChange("regist", true);
        this.modalChange("alarm", true);
      }
    },
    // (2) 회원 가입 - 아이디 중복 검사
    async idcheck() {
      await this.userIdCheck(this.registerinfo.id);
    },
    // (2) 회원 가입 - 비밀번호 중복 체크 검사
    confirmPWd() {
      if (this.registerinfo.password == this.registerinfo.userConPwd) {
        this.isConPwd = false;
      } else {
        this.isConPwd = true;
      }
    },
    // (2) 회원 가입 - 아이디 길이 제한 검사 (최소 6글자 이상으로 설정)
    idLength() {
      if (this.registerinfo.id.length < 6) {
        this.isIdLength = true;
      } else {
        this.isIdLength = false;
      }
    },
    getUser() {
      this.registerinfo.id = this.userInfo.id;
      this.registerinfo.name = this.userInfo.name;
      this.registerinfo.email = this.userInfo.email;
      this.registerinfo.tel = this.userInfo.tel;
      this.registerinfo.password = "";
    },
    // (2) 회원 가입 - manager 체크 박스 여부
    checkedBoxManager(data) {
      if (data == true) {
        this.isManagerChecked = true;
        // this.user.saveid = "1";
      } else {
        this.isManagerChecked = false;
        // this.user.saveid = "0";
      }
    },
    // (2) 회원 가입 - data 초기화 : 회원 가입전 저장된 registerinfo data 초기화
    initUser() {
      this.registerinfo.id = "";
      this.registerinfo.name = "";
      this.registerinfo.email = "";
      this.registerinfo.tel = "";
      this.registerinfo.password = "";
      this.registerinfo.confirmPWd = "";
    },

    // (3) 회원 정보 - 수정
    async modifyUser() {
      await this.userModify(this.registerinfo);
      if (this.isModify) {
        this.modalChange("registinform", false);
        this.alarmChange("all", false);
        this.alarmChange("modify", true);
        this.modalChange("alarm", true);
      }
    },
    // (3) 회원 정보 - 삭제 탈퇴
    async deleteUser() {
      await this.userDelete(this.userInfo.id);
      if (this.isDelete) {
        // 저장된 토큰 및 쿠키 삭제
        sessionStorage.removeItem("access-token");
        sessionStorage.removeItem("refresh-token");
        this.$cookies.remove("enjoy_id");
        // 모달창 전환
        this.modalChange("registinform", false);
        this.alarmChange("all", false);
        this.alarmChange("delete", true);
        this.modalChange("alarm", true);
      }
    },

    // (4) 로그 아웃 - 메인
    onClickLogout() {
      // this.SET_IS_LOGIN(false);
      // this.SET_USER_INFO(null);
      // sessionStorage.removeItem("access-token");
      // if (this.$route.path != "/") this.$router.push({ name: "main" });

      //vuex actions에서 userLogout 실행(Backend에 저장 된 리프레시 토큰 없애기
      //+ satate에 isLogin, userInfo 정보 변경)
      // this.$store.dispatch("userLogout", this.userInfo.userid);
      this.userLogout(this.userInfo.id);
      // sessionStorage.removeItem("access-token"); //저장된 토큰 없애기
      // sessionStorage.removeItem("refresh-token"); //저장된 토큰 없애기

      this.alarmChange("all", false);
      // auth 페이지면 안되고
      // 그렇지 않으면 로그 아웃만
      if (
        this.$route.path == "/tour" ||
        this.$route.path == "/sun" ||
        this.$route.path == "/plan" ||
        (this.$route.path.split("/")[1] == "board" &&
          this.$route.path.split("/")[2] != "list")
      ) {
        this.alarmChange("logout", true);
        this.modalChange("alarm", true);
        this.$router.push({ name: "home" });
      } else {
        this.alarmChange("logout", true);
        this.modalChange("alarm", true);
      }
    },
  },
  async created() {
    let authorization_code = this.$route.query.code;
    if (authorization_code) {
      let params = {
        code: authorization_code,
        "redirect-url": document.location.href.split("?")[0],
        service: "kakao",
      };
      await this.userConfirm(params);
      let token = sessionStorage.getItem("access-token"); // sessionStorage에서 "access-token" 가져오기
      if (this.isLogin) {
        await this.getUserInfo(token);
      }

      // 로그인 모달창 닫기
      this.modalChange("login", false);
      this.alarmChange("all", false);
      this.alarmChange("login", true);
      this.modalChange("alarm", true);

      let query = this.$route.query.state;
      let searchWord = "planNo";
      if (query.includes(searchWord)) {
        this.$router.push({
          name: this.$route.name,
          query: {
            planNo: query.slice(query.indexOf(searchWord) + searchWord.length),
          },
        });
      } else {
        this.$router.push({ name: this.$route.name });
      }
    }
    if (this.userInfo) {
      this.icongrayClass = "background-gray";
    } else {
      this.icongrayClass = "";
    }

    // await console.log(this.userInfo);
    // this.SET_USER_INFO(null);
    // this.IS_ALARM_LOGIN(false);

    let vue = this;
    window.addEventListener("keyup", function (e) {
      if (
        e.keyCode === 13 &&
        document.querySelector("#modal-alarm").style.display == ""
      ) {
        vue.modalChange("alarm", false);
        vue.modalChange("login", vue.alarm.wrong);
        vue.alarmChange("all", false);
      }
    });
  },
  watch: {
    userInfo: {
      handler() {
        if (this.userInfo) {
          this.icongrayClass = "background-gray";
        } else {
          this.icongrayClass = "";
        }
      },
      deep: true,
    },
  },
};
</script>

<style scoped>
@media screen and (max-width: 991px) {
  .username-id {
    display: none;
  }
}
@media screen and (min-width: 992px) {
  .username-id {
    display: "";
  }
}
.cursor:hover {
  cursor: pointer;
}
</style>
