<template>
  <div id="date-picker">
    <div>
      <div id="date-picker-label" class="font-weight-bold mb-1">
        날짜 선택 :
      </div>
    </div>
    <base-input addon-left-icon="ni ni-calendar-grid-58">
      <flat-picker
        slot-scope="{ focus, blur }"
        @on-open="focus"
        @on-close="blur"
        :config="{ allowInput: true }"
        class="form-control datepicker"
        placeholder="날짜를 선택해주세요"
        v-model="date"
      >
      </flat-picker>
    </base-input>
  </div>
</template>

<script>
import flatPicker from "vue-flatpickr-component";
import "flatpickr/dist/flatpickr.css";

export default {
  name: "SunDatePicker",
  data() {
    return {
      date: "",
    };
  },
  components: {
    flatPicker,
  },
  watch: {
    date: function () {
      this.$emit("change", this.date);
    },
  },
};
</script>

<style scoped>
#date-picker {
  width: 200px;
}
#date-picker-label {
  margin-top: 15px;
  width: 80px;
}
</style>
