<template>
  <div class="" id="tour-list-inform" style="width: 35%; height: 600px; margin-left: 10px">
    <div
      class="scrollspy scroll"
      data-bs-spy="scroll"
      data-bs-target="#lex"
      id="work"
      data-offset="20"
      style="height: 600px; overflow: auto"
    >
      <table class="table table-striped table-hover">
        <thead>
          <tr class="text-center">
            <th>Location</th>
            <th>Tel</th>
          </tr>
        </thead>
        <tbody id="trip-info-list">
          <tr class="text-center"
          v-for="(tour, index) in tourList"
          :key="tour.title"
          :index="index">
            <th class="tourButton" id="" scope="row" style="font-size: 14px; cursor:pointer;"
            @click="showDetailModal(tour.title, tour.desc, tour.image)"
            @mouseover="showMarkerTour(tour.mapx, tour.mapy)"
            @mouseout="deleteMarkerTour()"
            >{{tour.title}}</th>
            <td style="font-size: 12px">
              <a href="tel:\${tour.tel}" v-if="tour.tel">{{tour.tel}}</a>
              <a href="tel:\${tour.tel}" v-else>no phone number</a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal Detail 여행 정보 Start  -->
    <modal
      :show.sync="isDetailModal"
      gradient="primary"
      modal-classes="modal-primary modal-dialog-centered"
    >
      <h6 slot="header" class="modal-title" id="modal-title-notification" style="font-size: 2rem;">
        {{ title }}
      </h6>

      <div class="py-3 text-center">
        <div class="mb-4">
          <img v-if="img" :src="img" style="width: 100%"/>
          <div v-else>
            <i class="ni ni-image"></i>
            <span>&nbsp;NO IMAGE</span>
          </div>
        </div>
        <p>
          {{ desc }}
        </p>
      </div>
      <!-- <template slot="footer">
        <base-button type="white">Ok, Got it</base-button>
        <base-button
          type="link"
          text-color="white"
          class="ml-auto"
          @click="modals.modal2 = false"
        >
          Close
        </base-button>
      </template> -->
    </modal>
    <!-- Modal Detail 여행 정보 End -->
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import Modal from "@/components/TemplateComponents/Modal.vue";

export default {
  name: "TourMiddleList",
  components: {
    Modal,
  },
  data() {
    return {
      isDetailModal: false,
      title: null,
      desc: null,
      img: null,
    }
  },
  computed: {
    ...mapState("tourStore", ["tourList"]),
  },
  methods: {
    ...mapMutations("planStore", ["ADD_PLANSPOT", "REMOVE_PLANSPOT", "SET_PLAN_MARKER", "REMOVE_PLAN_MARKER"]),
    showMarkerTour(mapx, mapy) {
      let markerData = {
        lat: mapy,
        lng: mapx,
      }
      this.SET_PLAN_MARKER(markerData);
    },
    deleteMarkerTour() {
      this.REMOVE_PLAN_MARKER();
    },
    showDetailModal(title, desc, img) {
      this.title = title;
      this.desc = desc;
      this.img = img;
      this.isDetailModal = true;
    }
  }
}
</script>

<style scoped>
.scroll::-webkit-scrollbar {
    width: 14px;
}
</style>