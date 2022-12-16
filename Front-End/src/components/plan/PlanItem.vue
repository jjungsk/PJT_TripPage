<template>
  <the-card class="border-0 card" shadow bodyClasses="px-0 py-0">
    <div class="d-flex">
      <div id="card-image">
        <div v-if="!item.planInforms[0].image">
          <i class="ni ni-image"></i>
          <span>&nbsp;NO IMAGE</span>
        </div>
        <img
          :src="item.planInforms[0].image"
          alt=""
          v-if="item.planInforms[0].image"
        />
      </div>
      <div id="card-content">
        <h6 class="text-primary">{{ item.planSubject }}</h6>
        <button
          class=""
          id="kakaotalk-sharing-btn"
          style="cursor: pointer"
          @click="sendKakao(item)"
        >
          <img
            src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
            alt="카카오톡 공유 보내기 버튼"
          />
        </button>
        <button class="btn btn-primary" @click="showPlan">
          <i class="ni ni-bold-left"></i>
        </button>
      </div>
    </div>
  </the-card>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "PlanItem",
  props: ["item"],
  methods: {
    ...mapActions("planStore", ["showPlanInfo"]),
    showPlan() {
      this.showPlanInfo(this.item.planNo);
    },
    sendKakao(item) {
      console.log(item);
      var imgUrl = null;
      if (!item.planInforms[0].image) {
        imgUrl =
          "https://contents.verygoodtour.com/content/210/TR/0000/KAP/image/1874718_2.jpg";
      } else {
        imgUrl = item.planInforms[0].image;
      }
      console.log(imgUrl);
      window.Kakao.Share.sendDefault({
        objectType: "feed",
        content: {
          title: item.planSubject,
          description: "여행 계획",
          imageUrl: imgUrl,
          link: {
            // [내 애플리케이션] > [플랫폼] 에서 등록한 사이트 도메인과 일치해야 함
            mobileWebUrl: "http://localhost:8080",
            webUrl: "http://localhost:8080",
          },
        },
        buttons: [
          {
            title: "웹으로 보기",
            link: {
              mobileWebUrl: `http://localhost:8080/plan?planNo=${item.planNo}`,
              webUrl: `http://localhost:8080/plan?planNo=${item.planNo}`,
            },
          },
          {
            title: "앱으로 보기",
            link: {
              mobileWebUrl: `http://localhost:8080/plan?planNo=${item.planNo}`,
              webUrl: `http://localhost:8080/plan?planNo=${item.planNo}`,
            },
          },
        ],
      });
    },
  },
};
</script>

<style scoped>
h6 {
  overflow: hidden;
  text-overflow: ellipsis;
  word-wrap: break-word;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;

  padding-left: 4px;
  padding-top: 2px;
}
.card {
  height: 100px;
}
#card-image {
  width: 50%;
  height: 100px;
  overflow: hidden;
  background-color: rgba(238, 221, 248, 0.5);
}
#card-image div {
  text-align: center;
  line-height: 100px;
}
#card-image img {
  width: 100%;
  height: 100%;
  display: block;
}
#card-content {
  width: 50%;
  height: 100px;
  position: relative;
}
#card-content button {
  position: absolute;
  bottom: 2px;
  right: 2px;
  padding: 5px 8px 3px 8px;
}
#card-content a {
  position: absolute;
  bottom: 2px;
  right: 2px;
  padding: 5px 8px 3px 8px;
}
#kakaotalk-sharing-btn img {
  position: absolute;
  background-color: white;
  bottom: -3px;
  left: -50px;
  width: 34px;
}
</style>
