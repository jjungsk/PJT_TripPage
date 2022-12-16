<template>
  <div class="container">
    <tour-nav></tour-nav>
    <tour-middle></tour-middle>
  </div>
</template>

<script>
import TourNav from "@/components/tour/TourHeader.vue";
import TourMiddle from "@/components/tour/TourMiddle.vue";

export default {
  name: "AppTour",
  components: {
    TourNav,
    TourMiddle,
  },
};
</script>

<style scoped></style>
