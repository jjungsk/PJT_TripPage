<template>
  <div>
    <div>
      <h4 class="text-center">{{ planInfo.planSubject }}</h4>
    </div>
    <div class="text-right pr-2">
      <div>작성자 : {{ planInfo.userId }}</div>
      <div>조회수 : {{ planInfo.hit }}</div>
    </div>
    <div>
      <div class="py-2 px-1" v-html="message"></div>
    </div>
    <div>
      <div class="text-center mb-2">장소목록</div>
      <div id="spot-list">
        <spot-item class="mb-2" v-for="(item, idx) in planInfo.planInforms" :item="item" :idx="idx" :key="idx" type="view"></spot-item>
      </div>
    </div>
    <div>
      <!-- <div>등록일 : 2022-11-19 10:11:11</div> -->
    </div>
    <div class="d-flex justify-content-center mt-2">
      <button class="btn btn-outline-primary" @click="SHOW_LEFT_REGIST">일정 등록</button>
      <div v-if="userInfo && userInfo.id === planInfo.userId">
        <button
          type="button"
          class="btn btn-outline-danger"
          @click="deletePlan"
        >
        일정 삭제
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import { deletePlan } from "@/api/plan";
import SpotItem from "@/components/plan/SpotItem";

export default {
  name: "LeftPlanView",
  components: {
    SpotItem,
  },
  computed: {
    ...mapState("planStore", ["planInfo"]),
    ...mapState("memberStore", ["userInfo"]),
    message() {
      if (this.planInfo.planContent) return this.planInfo.planContent.split("\n").join("<br>");
      return "";
    },
  },
  methods: {
    ...mapMutations("planStore", ["CHANGE_PLANNUM", "SHOW_LEFT_REGIST"]),
    deletePlan() {
      deletePlan(this.planInfo.planNo, 
        ({data}) => {
          if (data == 1) {
            this.CHANGE_PLANNUM();
            alert("삭제되었습니다.");
            this.SHOW_LEFT_REGIST();
          }
        },
        (error) => console.log(error)
      );
    }
  },
  mounted() {
    let spotlist = document.querySelector("#spot-list");
    spotlist.style.height = `calc(100vh - ${spotlist.getBoundingClientRect().y}px - 58px)`;
  },
  watch: {
    planInfo: {
      handler() {
        this.$nextTick(function() {
          let spotlist = document.querySelector("#spot-list");
          spotlist.style.height = `calc(100vh - ${spotlist.getBoundingClientRect().y}px - 58px)`;
        })
      },
    }
  },
}
</script>

<style scoped>
#spot-list {
  overflow: auto;
}
</style>