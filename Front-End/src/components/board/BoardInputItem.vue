<template>
  <div>
    <div class="mb-3">
      <label for="subject" class="form-label">제목 : </label>
      <input
        type="text"
        class="form-control"
        placeholder="제목을 입력해주세요"
        v-model="article.subject"
        ref="subject"
      />
    </div>
    <div class="mb-3">
      <label for="content" class="form-label">내용 : </label>
      <textarea class="form-control" rows="10" v-model="article.content" ref="content"></textarea>
    </div>
    <div class="text-center pt-3">
      <button type="button" id="btn-register" class="btn btn-outline-default" @click="submitArticle" v-if="this.type === 'register'">
        글작성
      </button>
      <button type="button" id="btn-modify" class="btn btn-outline-default" @click="submitArticle" v-if="this.type === 'modify'">
        글수정
      </button>
      <router-link to="/board/list">
        <button
          type="button"
          class="btn btn-outline-primary"
        >
          글목록
        </button>
      </router-link>
    </div>
  </div>
</template>

<script>
import { viewArticle, writeArticle, modifyArticle } from "@/api/board";
import { mapState, mapMutations } from "vuex";

export default {
  name: "BoardInputItem",
  data() {
    return {
      article: {
        subject: "",
        content: "",
        userId: "",
        hit: 0,
        registerTime: "",
        articleNo: null,
      },
    };
  },
  props: {
    type: { type: String },
  },
  created() {
    if (this.type === "modify") {
      let param = this.$route.params.articleno;
      viewArticle(
        param,
        ({ data }) => {
          this.article = data;
        },
        (error) => {
          console.log(error);
        }
      );
    }
  },
  computed: {
    ...mapState("memberStore", ["userInfo"]),
  },
  methods: {
    ...mapMutations("boardStore", ["CLEAR_KEYWORD"]),
    submitArticle() {
      let err = true;
      let msg = "";
      !this.article.subject && ((msg = "제목을 입력해주세요"), (err = false), this.$refs.subject.focus());
      err && !this.article.content && ((msg = "내용을 입력해주세요"), (err = false), this.$refs.content.focus());

      if (!err) alert(msg);
      else this.type === "register" ? this.registArticle() : this.modifyArticle();
    },
    registArticle() {
      let param = {
        userId: this.userInfo.id,
        subject: this.article.subject,
        content: this.article.content,
      };
      writeArticle(
        param,
        ({ data }) => {
          let msg = "등록 처리시 문제가 발생했습니다.";
          if (data === 1) {
            msg = "등록이 완료되었습니다.";
            this.CLEAR_KEYWORD();
          }
          alert(msg);
          this.moveList();
        },
        (error) => {
          console.log(error);
        }
      );
    },
    modifyArticle() {
      let param = {
        articleNo: this.article.articleNo,
        subject: this.article.subject,
        content: this.article.content,
      };
      modifyArticle(
        param,
        ({ data }) => {
          let msg = "수정 처리시 문제가 발생했습니다.";
          if (data === 1) {
            msg = "수정이 완료되었습니다.";
          }
          alert(msg);
          this.moveList();
        },
        (error) => {
          console.log(error);
        }
      );
    },
    moveList() {
      this.$router.push({ name: "boardlist" });
    },
  },
}
</script>

<style>

</style>