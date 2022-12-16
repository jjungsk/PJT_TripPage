<template>
  <div class="gifhead">
    <div class="btn-wrapper">
      <div class="block-wallpaper"></div>
      <div class="black-wallpaper"></div>
      <base-button
        id="base-button-trip"
        tag="button"
        class="mb-3 mb-sm-0"
        type="white"
        icon="fa fa-plane"
        size="lg"
        @click="moveDown"
      >
        Let's trip!
      </base-button>
    </div>
    <iframe
      frameborder="0"
      height="100%"
      width="100%"
      :src="src"
      allow="autoplay; encrypted-media"
      allowfullscreen
    >
    </iframe>
  </div>
</template>

<script>
// `${srcURL}?mute=1&loop=1&autoplay=1&rel=0&controls=0&showinfo=0&loop=1`
export default {
  name: "MainCover",
  data() {
    return {
      src: "",
      srcList: [
        "https://www.youtube.com/embed/_KEb4P3t9Ec",
        "https://www.youtube.com/embed/p_PQ4VyPDEA",
        "https://www.youtube.com/embed/pYzX7cqK_JQ",
        "https://www.youtube.com/embed/4V1ZGEKQE2A",
        "https://www.youtube.com/embed/ENMQMD2x1Ws",
        "https://www.youtube.com/embed/ADDFmfOeihU",
      ],
    };
  },
  mounted() {
    let num = Math.floor(Math.random() * this.srcList.length);
    this.src = `${this.srcList[num]}?mute=1&loop=1&autoplay=1&rel=0&controls=0&showinfo=0&loop=1`;
  },
  methods: {
    moveDown(evt) {
      this.$emit("moveDown", evt);
    },
  },
};
</script>

<style scoped>
.gifhead {
  z-index: -5;
  height: 100vh;
  width: 100%;
  min-height: 35rem;
  /* background-image: url(../../../public/img/trip/giphy.gif); */
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: scroll;
  background-size: 100% 100vh;
}
.gifhead .btn-wrapper {
  text-align: center;
  padding-top: 55vh;
}
iframe {
  position: absolute;
  top: 0;
}
.block-wallpaper {
  position: absolute;
  background-color: transparent;
  top: 60px;
  height: 80%;
  width: 100%;
  z-index: 1;
}
.black-wallpaper {
  position: absolute;
  background-color: black;
  bottom: 0;
  height: 15%;
  width: 100%;
  z-index: 1;
}
/* style="position: absolute; z-index: 1; bottom: 300px" */
#base-button-trip {
  position: absolute;
  z-index: 1;
  background-color: transparent;
  border-color: white;
  /* border-width: thick; */
  border-radius: 10px;
  font-weight: thick;
  color: white;
  bottom: 50px;
}
#base-button-trip:hover {
  /* border-color: white; */
  color: black;
  background-color: white;
}
</style>
