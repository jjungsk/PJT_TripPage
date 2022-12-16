<template>
  <div>
    <h3 class="text-center">MY PLAN</h3>
    <div class="mb-3">
      <label for="subject" class="form-label ml-1">일정이름 : </label>
      <input
        type="text"
        class="form-control"
        placeholder="이름을 입력해주세요"
        v-model="subject"
        ref="subject"
      />
    </div>
    <div class="mb-2">
      <label for="content" class="form-label ml-1">상세내용 : </label>
      <textarea class="form-control" rows="8" v-model="content" ref="content"></textarea>
    </div>
    <div>
      <div class="text-center mb-2">선택목록</div>
      <div id="select-list">
        <spot-item class="mb-2" v-for="(item, idx) in planSpotList" :item="item" :idx="idx" :key="idx" type="select"></spot-item>
      </div>
    </div>
    <div class="text-center mt-2">
      <button class="btn btn-outline-primary" @click="regist">일정 등록</button>
    </div>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import { writePlan } from "@/api/plan";
import SpotItem from "@/components/plan/SpotItem";

export default {
  name: "LeftPlanRegist",
  components: {
    SpotItem,
  },
  data() {
    return {
      subject: "",
      content: "",
    }
  },
  computed: {
    ...mapState("memberStore", ["userInfo"]),
    ...mapState("planStore", ["planSpotList"]),
  },
  methods: {
    ...mapMutations("planStore", ["CHANGE_PLANNUM", "CLEAR_PLAN"]),
    regist() {
      let err = true;
      let msg = "";
      !this.subject && ((msg = "일정 이름을 입력해주세요"), (err = false), this.$refs.subject.focus());
      err && !this.content && ((msg = "내용을 입력해주세요"), (err = false), this.$refs.content.focus());
      err && this.planSpotList.length == 0 && ((msg = "장소를 선택해주세요"), (err = false));
      
      if (!err) {
        alert(msg);
        return;
      }

      let plan = {
        planSubject: this.subject,
        planContent: this.content,
        planInforms: this.planSpotList,
        userId: this.userInfo.id,
      };

      writePlan(plan, 
        ({data}) => {
          if (data == 1) {
            alert("일정이 등록되었습니다.");
            this.CHANGE_PLANNUM();
            this.CLEAR_PLAN();
            this.subject = "";
            this.content = "";
          }
        },
        (error) => console.log(error)
      );
    }
  },
}
</script>

<style scoped>
h3 {
  margin-bottom: 0px;
  font-size: 40px;
  letter-spacing: 2px;
  font-weight: 900;
  color: white;
  background-color: rgba(155, 135, 245, 0.5);
}
#select-list {
  max-height: calc(100vh - 556px);
  overflow: auto;
}
</style>