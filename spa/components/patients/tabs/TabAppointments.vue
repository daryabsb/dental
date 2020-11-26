<template>
  <div>
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <!-- {{ appointments }} -->

            <b-row v-for="appointment in appointments" :key="appointment.id">
              <b-col cols="4">
                <div class="mt-3">
                  <b-card-group deck>
                    <b-card
                      :bg-variant="datePassed(appointment.date)"
                      :header="$moment(appointment.date).format('YYYY-MM-DD - hh:mm A')"
                      class="text-center"
                    >
                      <b-card-text
                        >{{appointment.description}}.</b-card-text
                      >
                    </b-card>
                  </b-card-group>
                </div>
                <hr>
              </b-col>
            </b-row>
            
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["appointments"],
  methods: {
      datePassed(datetime) {
          let today = new Date();
          let date = new Date(datetime);
          if (today >= date) {
              return 'light';
            }
  },
},
}
</script>

