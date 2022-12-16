<template>
  <div>
    <div class="header-blank"></div>
    <div class="container">
      <h2 class="shadow rounded text-center my-3 py-4 mb-4">게시판</h2>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
  name: "AppBoard",
};
</script>

<style scoped>
h2 {
  font-weight: bold;
}
</style>
