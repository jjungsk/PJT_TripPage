<template>
  <div id="app">
    <router-view name="header" :bgstate="bgstate"></router-view>
    <main>
      <fade-transition origin="center" mode="out-in" :duration="250">
        <router-view />
      </fade-transition>
    </main>
    <router-view name="footer"></router-view>
  </div>
</template>
<script>
import { FadeTransition } from "vue2-transitions";

export default {
  components: {
    FadeTransition,
  },
  data() {
    return {
      userinfo: null,
      bgstate: "cyan",
    };
  },
  updated() {
    if (this.$route.name == "home") {
      this.bgstate = "cyan";
    } else {
      this.bgstate = "teal";
    }
  },
};
</script>

<style>
@media screen and (max-width: 241px) {
  .header-blank {
    height: 100px;
  }
}
@media screen and (min-width: 242px) and (max-width: 991px) {
  .header-blank {
    height: 60px;
  }
}
@media screen and (min-width: 992px) {
  .header-blank {
    height: 89px;
  }
}
main {
  min-height: calc(100vh - 120px);
}
table {
  line-height: 1;
}

/* scroll  */
::-webkit-scrollbar {
  width: 16px;
}
::-webkit-scrollbar-track {
  background-color: #e4e4e4;
  border-radius: 100px;
}
::-webkit-scrollbar-thumb {
  background-color: #d4aa70;
  border-radius: 100px;
}
::-webkit-scrollbar-thumb {
  background-image: linear-gradient(180deg, #d0368a 0%, #708ad4 99%);
  box-shadow: inset 2px 2px 5px 0 rgba(#fff, 0.5);
  border-radius: 100px;
}
</style>
