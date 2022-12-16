<template>
  <div>
    <div class="row mb-2">
      <div class="col-5">
        <router-link
          to="/notice/write"
          class="btn btn-primary"
          v-if="userInfo && userInfo.isManager"
          >글쓰기</router-link
        >
      </div>
      <div class="col-7 d-flex justify-content-end">
        <base-dropdown>
          <base-button
            id="dropdown-key"
            slot="title"
            type="secondary"
            class="dropdown-toggle"
          >
            {{ searchKey }}
          </base-button>
          <div class="dropdown-item" @click="changeKeySubject">제목</div>
          <div class="dropdown-item" @click="changeKeyUserid">작성자</div>
        </base-dropdown>
        <input
          placeholder="검색어를 입력해주세요"
          class="form-control"
          id="search-word"
          v-model="searchWord"
          @keyup.enter="search"
        />
        <base-button @click="search">검색</base-button>
      </div>
    </div>
    <div>
      <b-table
        striped
        hover
        :items="articles"
        :fields="fields"
        class="text-center tablehover"
        @row-clicked="viewArticle"
      ></b-table>
    </div>
    <div>
      <base-pagination
        :total="totalData"
        :per-page="dataPerPage"
        :value="pgno"
        @input="pageInput"
        align="center"
      ></base-pagination>
    </div>
  </div>
</template>

<script>
import { BTable } from "bootstrap-vue/esm/components/table/table";
import { mapState, mapActions } from "vuex";

export default {
  name: "NoticeList",
  components: {
    BTable,
  },
  data() {
    return {
      searchKey: "검색조건",
      searchWord: "",
      fields: [
        { key: "articleNo", label: "글번호", tdClass: "tdClass" },
        { key: "subject", label: "제목", tdClass: "tdSubject" },
        { key: "userName", label: "작성자", tdClass: "tdClass" },
        { key: "registerTime", label: "작성일", tdClass: "tdClass" },
        { key: "hit", label: "조회수", tdClass: "tdClass" },
      ],
    };
  },
  computed: {
    ...mapState("memberStore", ["userInfo"]),
    ...mapState("noticeStore", [
      "key",
      "word",
      "pgno",
      "totalData",
      "dataPerPage",
      "articles",
    ]),
  },
  created() {
    if (this.key === "subject") {
      this.searchKey = "제목";
    } else if (this.key === "username") {
      this.searchKey = "작성자";
    }
    this.searchWord = this.word;
    let params = {
      key: this.key,
      word: this.word,
      pgno: this.pgno,
    };
    this.getArticleList(params);
  },
  methods: {
    ...mapActions("noticeStore", ["getArticleList"]),
    viewArticle(article) {
      this.$router.push({
        name: "noticeview",
        params: { articleNo: article.articleNo },
      });
    },
    pageInput(page) {
      let params = {
        key: this.key,
        word: this.word,
        pgno: page,
      };
      this.getArticleList(params);
    },
    changeKeySubject() {
      this.searchKey = "제목";
    },
    changeKeyUserid() {
      this.searchKey = "작성자";
    },
    search() {
      let key = "";
      if (this.searchKey === "제목") {
        key = "subject";
      } else if (this.searchKey === "작성자") {
        key = "username";
      }
      let params = {
        key,
        word: this.searchWord,
        pgno: 1,
      };
      this.getArticleList(params);
    },
  },
};
</script>

<style scoped>
#dropdown-key {
  width: 100px;
  text-align: right;
}
#search-word {
  width: 200px;
  margin-right: 5px;
}
.tablehover >>> tbody tr:hover {
  cursor: pointer;
  color: black;
}
</style>
