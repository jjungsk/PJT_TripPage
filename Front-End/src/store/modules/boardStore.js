import { listArticle } from "@/api/board";

const boardStore = {
  namespaced: true,
  state: {
    key: "",
    word: "",
    pgno: 1,
    totalData: 0,
    dataPerPage: 0,
    articles: [],
  },
  mutations: {
    CLEAR_KEYWORD(state) {
      state.key = "";
      state.word = "";
      state.pgno = 1;
    },
    SET_KEYWORD(state, params) {
      state.key = params.key;
      state.word = params.word;
      state.pgno = params.pgno;
    },
    SET_PAGINATION_INFO(state, pginfo) {
      state.totalData = pginfo.totalData;
      state.dataPerPage = pginfo.dataPerPage;
      state.pageCount = pginfo.pageCount;
    },
    SET_ARTICLE_LIST(state, articles) {
      state.articles = articles;
    },
  },
  actions: {
    getArticleList: ({ commit }, params) => {
      commit("SET_KEYWORD", params);
      listArticle(
        params,
        ({ data }) => {
          commit("SET_PAGINATION_INFO", data.paginationInfo);
          commit("SET_ARTICLE_LIST", data.list);
        },
        (error) => {
          console.log(error);
        }
      );
    },
  },
};

export default boardStore;
