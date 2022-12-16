<template>
  <div>
    <div class="text-center mb-2">검색 결과 ({{ SpotSearchItems.length }}건)</div>
    <div id="searchlist">
      <spot-item class="mb-2" v-for="(item, idx) in SpotSearchItems" :item="item" :key="idx"></spot-item>
    </div>
  </div>
</template>

<script>
import { search } from "@/api/plan";
import SpotItem from "@/components/plan/SpotItem";

export default {
  name: "RightSearchList",
  components: {
    SpotItem,
  },
  data() {
    return {
      SpotSearchItems: [],
    }
  },
  props: ["word"],
  created() {
    this.search();
  },
  methods: {
    search() {
      search(this.word, 
        ({ data }) => {
        this.SpotSearchItems = data;
      },
      (error) => {
        console.log(error);
      });
    }
  },
  watch: {
    word: function() {
      this.search();
    }
  }
}
</script>

<style scoped>
#searchlist {
  height: calc(100vh - 226px);
  overflow: auto;
}
</style>