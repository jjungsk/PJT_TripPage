<template>
  <div>
    <!-- Navbar Menu -->
    <ul class="navbar-nav align-items-lg-center ml-lg-auto">
      <li class="nav-item">
        <a
          class="nav-link nav-link-icon"
          style="cursor: pointer"
          target="_blank"
          rel="noopener"
          data-toggle="tooltip"
          @click="modals.login = true"
        >
          <i class="ni ni-button-power"></i>
          <span class="nav-link-inner--text d-lg">Log-In</span>
        </a>
      </li>
      <li class="nav-item">
        <a
          class="nav-link nav-link-icon"
          style="cursor: pointer"
          target="_blank"
          rel="noopener"
          data-toggle="tooltip"
        >
          <i class="ni ni-button-power"></i>
          <span class="nav-link-inner--text d-lg">Log-Out</span>
        </a>
      </li>
    </ul>

    <!-- Modal-Login Start -->
    <modal
      :show.sync="modals.login"
      body-classes="p-2"
      modal-classes="modal-dialog-centered modal-sm"
    >
      <card
        type="secondary"
        shadow
        header-classes="bg-white pb-5"
        body-classes="px-lg-5 py-lg-5"
        class="border-0"
      >
        <template>
          <div class="text-muted text-center mb-3">
            <small>Login</small>
          </div>
          <div class="btn-wrapper text-center">
            <base-button type="neutral">
              <img slot="icon" src="img/icons/common/github.svg" />
              Kakao
            </base-button>
          </div>
        </template>
        <template>
          <div class="text-center text-muted mb-4">
            <small>Or sign in with credentials</small>
          </div>
          <form role="form" id="login-form">
            <base-input
              alternative
              class="mb-3"
              placeholder="ID"
              addon-left-icon="ni ni-check-bold"
              v-model="userinfo.userId"
              @input="loginId"
            >
            </base-input>
            <base-input
              alternative
              type="password"
              placeholder="Password"
              addon-left-icon="ni ni-lock-circle-open"
              v-model="userinfo.userPwd"
              @input="loginId"
            >
            </base-input>
            <base-checkbox> Remember me </base-checkbox>
            <div class="text-center">
              <base-button type="primary" class="my-4" @click="loginUser"
                >로그인</base-button
              >
              <base-button type="submit" class="my-4" @click="findPwd"
                >비밀번호 찾기</base-button
              >
            </div>
          </form>
        </template>
      </card>
    </modal>
    <!-- Modal-Login End -->
  </div>
</template>

<script>
export default {
  name: "UserBeforeLogin",
  data() {
    return {
      modals: { login: false, register: false, toggl: true },
    };
  },
};
</script>

<style></style>
