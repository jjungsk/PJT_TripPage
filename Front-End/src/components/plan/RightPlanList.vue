<template>
  <div>
    <div class="text-center mb-2">일정 목록</div>
    <div id="planlist">
      <plan-item
        class="mb-2"
        v-for="(item, idx) in PlanItems"
        :item="item"
        :key="idx"
      ></plan-item>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import { listPlan } from "@/api/plan";
import PlanItem from "@/components/plan/PlanItem";

export default {
  name: "RightSearchList",
  components: {
    PlanItem,
  },
  data() {
    return {
      PlanItems: [],
    };
  },
  computed: {
    ...mapState("planStore", ["planNum"]),
  },
  created() {
    this.getPlans();
  },
  watch: {
    planNum: function () {
      this.getPlans();
    },
  },
  methods: {
    getPlans() {
      listPlan(
        ({ data }) => {
          this.PlanItems = data;
        },
        (error) => {
          console.log(error);
        }
      );
    },
  },
};
</script>

<style scoped>
#planlist {
  height: calc(100vh - 226px);
  overflow: auto;
}
</style>
