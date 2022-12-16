<template>
  <div class="pb-2">
    <!-- 일출 일몰 start -->
    <div class="mt-4 pt-4">
      <the-card class="border-0 row" shadow body-classes="px-0 py-0">
        <div class="card-container row align-items-center">
          <div class="card-image-box col-8 col-xl-8 col-lg-7">
            <img
              class="card-image mb-3 mb-lg-0"
              src="../../../public/img/trip/sunset.jpg"
              alt="..."
            />
          </div>
          <div class="col-4 col-xl-4 col-lg-5">
            <div class="featured-text text-center">
              <h4 class="fw-bold">일출 일몰</h4>
              <p class="text-black-50 mb-0">
                인생샷을 남기고 싶다면?<br />
                해가 뜨고 해가 지는 아름다운 여행지
              </p>
              <router-link :to="{ name: 'sun' }" class="btn btn-primary mt-3"
                >그 날의 해는?</router-link
              >
            </div>
          </div>
        </div>
      </the-card>
    </div>
    <!-- 일출 일몰 end -->
    <!-- 여행지 목록 start -->
    <div class="mt-4 pt-4">
      <!-- <the-card class="border-0 row" hover shadow body-classes="py-0"> -->
      <the-card class="border-0 row" shadow body-classes="px-0 py-0">
        <div class="card-container row align-items-center">
          <div class="col-4 col-xl-4 col-lg-5">
            <div class="featured-text text-center">
              <h4 class="fw-bold">여행지 목록 보기</h4>
              <p class="text-black-50 mb-0">
                목적지만 선택하면 주변 정보가 한 눈에
              </p>
              <router-link :to="{ name: 'tour' }" class="btn btn-primary mt-3"
                >어디로 떠나시나요?
              </router-link>
            </div>
          </div>
          <div class="card-image-box col-8 col-xl-8 col-lg-7">
            <img
              class="card-image mb-3 mb-lg-0"
              src="../../../public/img/trip/turkey.jpg"
              alt="..."
            />
          </div>
        </div>
      </the-card>
    </div>
    <!-- 여행지 목록 end -->
    <!-- 여행 계획 start -->
    <div class="mt-4 pt-4">
      <the-card class="border-0 row" shadow body-classes="px-0 py-0">
        <div class="card-container row align-items-center">
          <div class="card-image-box col-8 col-xl-8 col-lg-7">
            <img
              class="card-image mb-3 mb-lg-0"
              src="../../../public/img/trip/Caribbean_Plymouth_Coastline.jpg"
              alt="..."
            />
          </div>
          <div class="col-4 col-xl-4 col-lg-5">
            <div class="featured-text text-center">
              <h4 class="fw-bold">나만의 여행 계획</h4>
              <p class="text-black-50 mb-0">
                나만의 여행 일정을<br />
                만들어보세요
              </p>
              <router-link :to="{ name: 'plan' }" class="btn btn-primary mt-3"
                >여행을 떠나볼까요?
              </router-link>
            </div>
          </div>
        </div>
      </the-card>
    </div>
    <!-- 여행 계획 end -->
  </div>
</template>

<script>
export default {
  name: "MainCards",
};
</script>

<style scoped>
.card {
  height: 450px;
}
.card-image-box {
  width: 100%;
  height: 100%;
  padding-left: 0;
  padding-right: 0;
  overflow: hidden;
}
.card-image {
  width: 100%;
  height: 100%;
}
.card-container {
  width: 100%;
  height: 100%;
  background-color: rgba(176, 200, 235, 0.1);
}
</style>
