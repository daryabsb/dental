<template>
  <div>
    <!-- Tabs with card integration -->
    <b-card no-body>
      <b-tabs v-model="tabIndex" >
        <b-tab title="General">I'm the first fading tab</b-tab>
        <b-tab title="Edit profile">
         <div class="card">
                                <div class="card-body">
                                    <div class="row container-grid nf-col-3  projects-wrapper" style="position: relative; height: 580.968px;">
                                        <div class="col-lg-4 col-md-6 p-0 nf-item branding design coffee spacing" style="position: absolute; left: 0px; top: 0px;">
                                            <div class="item-box">
                                                <a class="cbox-gallary1 mfp-image" href="~assets/images/small/img-1.jpg" title="Consequat massa quis">
                                                    <img class="item-container " src="~assets/images/small/img-1.jpg" alt="7">
                                                    <div class="item-mask">
                                                        <div class="item-caption">
                                                            <h5 class="text-white">Consequat massa quis</h5>
                                                            <p class="text-white">Branding, Design, Coffee</p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div><!--end item-box-->
                                        </div><!--end col-->
                        
                                        <div class="col-lg-4 col-md-6 p-0 nf-item photo spacing" style="position: absolute; left: 436px; top: 0px;">
                                            <div class="item-box">
                                                <a class="cbox-gallary1 mfp-image" href="~assets/images/small/img-2.jpg" title="Vivamus elementum semper">
                                                    <img class="item-container mfp-fade" src="~assets/images/small/img-2.jpg" alt="2">
                                                    <div class="item-mask">
                                                        <div class="item-caption">
                                                            <h5 class="text-light">Vivamus elementum semper</h5>
                                                            <p class="text-light">Photo</p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div><!--end item-box-->
                                        </div><!--end col-->
                        
                                        <div class="col-lg-4 col-md-6 p-0 nf-item branding coffee spacing" style="position: absolute; left: 872px; top: 0px;">
                                            <div class="item-box">
                                                <a class="cbox-gallary1 mfp-image" href="~assets/images/small/img-3.jpg" title="Quisque rutrum">
                                                    <img class="item-container" src="~assets/images/small/img-3.jpg" alt="4">
                                                    <div class="item-mask">
                                                        <div class="item-caption">
                                                            <h5 class="text-light">Quisque rutrum</h5>
                                                            <p class="text-light">Branding, Design, Coffee</p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div><!--end item-box-->
                                        </div><!--end col-->
                        
                                        <div class="col-lg-4 col-md-6 p-0 nf-item branding design spacing" style="position: absolute; left: 0px; top: 290.484px;">
                                            <div class="item-box">
                                                <a class="cbox-gallary1 mfp-image" href="~assets/images/small/img-4.jpg" title="Tellus eget condimentum">
                                                    <img class="item-container" src="~assets/images/small/img-4.jpg" alt="5">
                                                    <div class="item-mask">
                                                        <div class="item-caption">
                                                            <h5 class="text-light">Tellus eget condimentum</h5>
                                                            <p class="text-light">Design</p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div><!--end item-box-->
                                        </div><!--end col-->
                        
                                        <div class="col-lg-4 col-md-6 p-0 nf-item branding design spacing" style="position: absolute; left: 436px; top: 290.484px;">
                                            <div class="item-box">
                                                <a class="cbox-gallary1 mfp-image" href="~assets/images/small/img-5.jpg" title="Nullam quis ant">
                                                    <img class="item-container" src="~assets/images/small/img-5.jpg" alt="6">
                                                    <div class="item-mask">
                                                        <div class="item-caption">
                                                            <h5 class="text-light">Nullam quis ant</h5>
                                                            <p class="text-light">Branding, Design</p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div><!--end item-box-->
                                        </div><!--end col-->
                        
                                        <div class="col-lg-4 col-md-6 p-0 nf-item photo spacing" style="position: absolute; left: 872px; top: 290.484px;">
                                            <div class="item-box">
                                                <a class="cbox-gallary1 mfp-image" href="~assets/images/small/img-6.jpg" title="Sed fringilla mauris">
                                                    <img class="item-container" src="~assets/images/small/img-6.jpg" alt="1">
                                                    <div class="item-mask">
                                                        <div class="item-caption">
                                                            <h5 class="text-light">Sed fringilla mauris</h5>
                                                            <p class="text-light">Photo</p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div><!--end item-box-->
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </div><!--end card-body-->
                            </div>
          <b-card>I'm the card in tab</b-card>
        </b-tab>
        <b-tab title="Premium Plan" disabled>Sibzamini!</b-tab>
        <b-tab title="Info">I'm the last tab</b-tab>
      </b-tabs>
    </b-card>

    <!-- Control buttons-->
    <div class="text-center">
      <b-button-group class="mt-2">
        <b-button @click="tabIndex--">Previous</b-button>
        <b-button @click="tabIndex++">Next</b-button>
      </b-button-group>

      <div class="text-muted">Current Tab: {{ tabIndex }}</div>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        tabIndex: 1
      }
    }
  }
</script>