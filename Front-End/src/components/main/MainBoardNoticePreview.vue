<template>
  <div>
    <div class="row mt-2 mb-5">
      <div class="col-md-6">
        <div class="d-flex">
          <h3 class="fw-bold mt-5">
            공지사항
            <span class="mt-5 h6" style="line-height: 40px">
              <span class="link" @click="moveNotice">바로가기</span>
            </span>
          </h3>
        </div>
        <b-table
          striped
          :items="noticeArticles"
          :fields="noticeFields"
          class="text-center"
        ></b-table>
      </div>
      <div class="col-md-6">
        <div class="d-flex">
          <h3 class="fw-bold mt-5">
            게시판
            <span class="mt-5 h6" style="line-height: 40px">
              <span class="link" @click="moveBoard">바로가기</span>
            </span>
          </h3>
        </div>
        <b-table
          striped
          :items="boardArticles"
          :fields="boardFields"
          class="text-center"
        ></b-table>
      </div>
    </div>
  </div>
</template>

<script>
import { BTable } from "bootstrap-vue/esm/components/table/table";
import { previewArticle } from "@/api/board";
import { previewNotice } from "@/api/notice";
import { mapMutations } from "vuex";

export default {
  main: "MainBoardNoticePreview",
  components: {
    BTable,
  },
  data() {
    return {
      boardFields: [
        { key: "subject", label: "제목", tdClass: "tdSubject" },
        { key: "userName", label: "작성자", tdClass: "tdClass" },
        { key: "hit", label: "조회수", tdClass: "tdClass" },
      ],
      boardArticles: [],
      noticeFields: [
        { key: "subject", label: "제목", tdClass: "tdSubject" },
        { key: "hit", label: "조회수", tdClass: "tdClass" },
      ],
      noticeArticles: [],
    };
  },
  created() {
    previewArticle(
      ({ data }) => {
        this.boardArticles = data;
      },
      (error) => {
        console.log(error);
      }
    );
    previewNotice(
      ({ data }) => {
        this.noticeArticles = data;
      },
      (error) => {
        console.log(error);
      }
    );
  },
  methods: {
    ...mapMutations("boardStore", ["CLEAR_KEYWORD"]),
    ...mapMutations(["noticeStore/CLEAR_KEYWORD"]),
    moveBoard() {
      this.CLEAR_KEYWORD();
      this.$router.push({ name: "board" });
    },
    moveNotice() {
      this["noticeStore/CLEAR_KEYWORD"]();
      this.$router.push({ name: "notice" });
    },
  },
};
</script>

<style scoped>
.link {
  color: #5e72e4;
}
.link:hover {
  cursor: pointer;
  color: #233dd2;
}
</style>
