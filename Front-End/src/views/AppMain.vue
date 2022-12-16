<template>
  <div class="home">
    <!-- Cover start -->
    <main-cover @moveDown="moveDown"></main-cover>
    <!-- Cover end -->
    <div class="container mt-4 mb-4">
      <!-- 카드 3장 start -->
      <main-cards id="main-cards"></main-cards>
      <!-- 카드 3장 end -->
      <!-- 공지사항/게시판 start -->
      <main-board-notice-preview></main-board-notice-preview>
      <!-- 공지사항/게시판 end -->
    </div>
  </div>
</template>

<script>
import MainCover from "@/components/main/MainCover.vue";
import MainCards from "@/components/main/MainCards.vue";
import MainBoardNoticePreview from "@/components/main/MainBoardNoticePreview.vue";

export default {
  name: "AppMain",
  components: {
    MainCover,
    MainCards,
    MainBoardNoticePreview,
  },
  methods: {
    moveDown() {
      document
        .getElementById("main-cards")
        .scrollIntoView({ behavior: "smooth" });
    },
  },
};
</script>

<style></style>
