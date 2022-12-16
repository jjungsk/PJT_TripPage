<template>
  <div>
    <div class="text-center mb-2">추천 장소</div>
    <spot-item class="mb-2" v-for="(item, idx) in SpotRecommendItems" :item="item" :key="idx"></spot-item>
  </div>
</template>

<script>
import { recommend } from "@/api/plan";
import SpotItem from "@/components/plan/SpotItem";

export default {
  name: "RightRecommend",
  components: {
    SpotItem,
  },
  data() {
    return {
      SpotRecommendItems: [],
    }
  },
  created() {
    recommend(
      ({ data }) => {
      this.SpotRecommendItems = data;
    },
    (error) => {
      console.log(error);
    });
  },
}
</script>

<style>

</style>