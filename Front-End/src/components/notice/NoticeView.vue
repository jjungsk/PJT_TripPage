<template>
  <div>
    <div>
      <h2 class="text-center py-3">{{ article.subject }}</h2>
    </div>
    <div class="row pb-4">
      <div class="col-8 row">
        <div class="mr-2">
          <img
            class="avatar bg-light p-2"
            src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
          />
        </div>
        <div>
          <div class="fw-bold" id="view-user-id">작성자 : {{ article.userName }}</div>
          <div class="" id="view-register-time">{{ article.registerTime }}</div>
        </div>
      </div>
      <div class="col-4 align-self-center text-right" id="view-hit">
        조회수 : {{ article.hit }}
      </div>
    </div>
    <div>
      <div class="" v-html="message">
      </div>
    </div>
    <div class="d-flex justify-content-end">
      <router-link to="/notice/list" class="mb-3 mr-2">
        <button
          type="button"
          class="btn btn-outline-primary"
        >
          글목록
        </button>
      </router-link>
      <div class="btn-writer-show" v-if="userInfo && userInfo.id === article.userId">
        <button
          type="button"
          class="btn btn-outline-default mb-3 ms-1"
          @click="moveModifyArticle"
        >
          글수정
        </button>
        <button
          type="button"
          class="btn btn-outline-danger mb-3 ms-1"
          @click="deleteArticle"
        >
          글삭제
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { viewNotice, deleteNotice } from "@/api/notice";
import { mapState, mapMutations } from "vuex";

export default {
  name: "NoticeView",
  data() {
    return {
      article: {},
    };
  },
  computed: {
    ...mapState("memberStore", ["userInfo"]),
    message() {
      if (this.article.content) return this.article.content.split("\n").join("<br>");
      return "";
    },
  },
  created() {
    let param = this.$route.params.articleNo;
    viewNotice(
      param,
      ({ data }) => {
        this.article = data;
      },
      (error) => {
        console.log(error);
      }
    );
  },
  methods: {
    ...mapMutations("noticeStore", ["CLEAR_KEYWORD"]),
    moveModifyArticle() {
      this.$router.replace({ // history 남기지 않음
        name: "noticemodify",
        params: { articleno: this.article.articleNo },
      });
    },
    deleteArticle() {
      if (confirm("정말로 삭제하시겠습니까?")) {
        let param = this.$route.params.articleNo;
        deleteNotice(
          param,
          ({ data }) => {
            if (data === 1) {
              alert("삭제되었습니다.");
              this.CLEAR_KEYWORD();
              this.$router.push({ name: "notice" });
            } else {
              alert("삭제 도중에 문제가 발생하였습니다.");
            }
          },
          (error) => {
            console.log(error);
          }
        );
      }
    },
  },
}
</script>

<style scoped>
div.col-8 {
  padding-left: 0px;
}
</style>