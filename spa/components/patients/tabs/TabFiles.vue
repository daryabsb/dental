<template>
    <div>
                                    <div class="row">
                                        <div class="col-lg-8">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <ul class="col container-filter categories-filter mb-0" id="filter">

                                                        <li
                                                            
                                                            v-for="tab in tabs"
                                                            :key="tab.name"
                                                        >
                                                            <a
                                                                @click="setActiveTabName(tab.name)"
                                                                href="javascript: void(0);"
                                                                class="categories"
                                                                id="general_detail_tab"
                                                                data-toggle="pill"
                                                                :class="{
                                                                    active: tab.name === activeTabName,
                                                                }"
                                                                >{{ tab.displayName }}</a
                                                            >
                                                        </li>
                                                            
                                                            <!-- <li><a class="categories active" data-filter="*">All</a></li> -->
                                                           
                                                        </ul>
                                                        

                                                    </div><!-- End portfolio  -->
                                                </div><!--end card-body-->
                                            </div><!--end card-->
                                            <!-- <h1>Darya</h1><pre>{{ images }}</pre> -->
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row container-grid nf-col-3  projects-wrapper">
                                                        <div class="col-lg-4 col-md-6 p-0 nf-item branding design coffee spacing" 
                                                        v-for="file in files" :key="file.id"
                                                        v-if="displayContents('tabFiles')"
                                                        >
                                                            <div class="item-box p-3">
                                                                <a 
                                                                class="cbox-gallary1 mfp-image p-3" 
                                                                href="javascript: void(0);" 
                                                                title="Consequat massa quis"
                                                                >

                                                                    <pdf-view :src="file.file" class="item-container" />
                                                                    <!-- <img class="item-container " src="~assets/images/small/img-1.jpg" alt="7" /> -->
                                                                    <div class="item-mask">
                                                                        <div class="item-caption">
                                                                            <h5 class="text-white">Consequat massa quis</h5>
                                                                            <p class="text-white">Branding, Design, Coffee</p>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div><!--end item-box-->
                                                        </div><!--end col-->
                                                        <!-- <pre>{{imageUrls}}</pre> -->
                                                        <div class="col-lg-4 d-flex align-items-center col-md-6 p-0 nf-item branding design coffee spacing" 
                                                        v-for="(image, imageIndex) in images" :key="image.id"
                                                        v-if="displayContents('tabImages')"
                                                        >
                                                            <div class="item-box p-3">
                                                                <a 
                                                                class="cbox-gallary1 mfp-image p-3" 
                                                                
                                                                @click="index = imageIndex" 
                                                                title="Consequat massa quis"
                                                                >
                                                                
                                                                    <!-- <pdf-view :src="file.file" class="item-container" /> -->
                                                                    <img class="item-container " :src="image.file" alt="7" />
                                                                    <div class="item-mask">
                                                                        <div class="item-caption">
                                                                            <h5 class="text-white">Consequat massa quis</h5>
                                                                            <p class="text-white">Branding, Design, Coffee</p>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                                
                                                            </div><!--end item-box-->
                                                        </div><!--end col-->
                                                        <!-- OTHER THINGIES -->
                                                        
                                        
            
                                                    </div><!--end row-->
                                                </div><!--end card-body-->
                                            </div><!--end card-->
                                        </div><!--end col-->
                                        <div class="col-lg-4">
                                            <div class="card ">
                                                <div class="card-body">
                                                    <div class="text-center">
                                                        <h4><i class="fas fa-quote-left text-primary"></i></h4>
                                                    </div>                                            
                                                    <div id="carouselExampleFade2" class="carousel slide" data-ride="carousel">
                                                        <div class="carousel-inner">
                                                            <div class="carousel-item">
                                                                <div class="text-center">
                                                                    <p class="text-muted px-4">
                                                                        It is a long established fact that a reader will be distracted by 
                                                                        the readable content of a page when looking at its layout. 
                                                                        The point of using Lorem Ipsum is that it has a more-or-less 
                                                                        normal distribution of letters, as opposed to using.
                                                                    </p>
                                                                    <div class="">
                                                                        <img src="~assets/images/users/user-10.jpg" alt="" class="rounded-circle thumb-lg mb-2">
                                                                        <p class="mb-0 text-primary"><b>- Mary K. Myers</b></p>
                                                                        <small class="text-muted">CEO Facebook</small>
                                                                    </div>                                                            
                                                                </div>
                                                            </div>
                                                            <div class="carousel-item active">
                                                                <div class="text-center">
                                                                    <p class="text-muted px-4">                                                                
                                                                        Where does it come from?
                                                                        Contrary to popular belief, Lorem Ipsum is not simply random text. 
                                                                        It has roots in a piece of classical Latin literature from 45 BC, 
                                                                        making it over 2000 years  popular belief,old.
                                                                    </p>
                                                                    <div class="">
                                                                        <img :src="patient.image" alt="" class="rounded-circle  thumb-lg mb-2">
                                                                        <p class="mb-0 text-primary"><b>- {{patient.name}}</b></p>
                                                                        <small class="text-muted">{{patient.status}}</small>
                                                                    </div>                                                            
                                                                </div>
                                                            </div>
                                                            <div class="carousel-item">
                                                                <div class="text-center">
                                                                    <p class="text-muted px-4">
                                                                        There are many variations of passages of Lorem Ipsum available, 
                                                                        but the majority have suffered alteration in some form, by injected humour, 
                                                                        or randomised words which don't look even slightly believable. 
                                                                        If you are going to use a passage of Lorem Ipsum. 
                                                                    </p>
                                                                    <div class="">
                                                                        <img src="~assets/images/users/user-5.jpg" alt="" class="rounded-circle  thumb-lg mb-2">
                                                                        <p class="mb-0 text-primary"><b>- Lisa D. Pullen</b></p>
                                                                        <small class="text-muted">CEO Facebook</small>
                                                                    </div>                                                            
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!--end row-->
                                    <client-only>
                                    <gallery :images="imagesURL" :index="index" @close="index = null" />
                                    </client-only>
                                </div><!--end portfolio detail-->
                                
 
</template>

<script>
export default {
    props: ['files', 'images','imagesURL', 'patient'],
    data() {
        return {
            tabs: [
				{
					name: "tabFiles",
					displayName: "Files",
				},
				{
					name: "tabImages",
					displayName: "Images",
				},
				{
					name: "tabOthers",
					displayName: "Others",
				},
				// {
				// 	name: "tabAppointments",
				// 	displayName: "Appointments",
				// },
			],
            activeTabName: null,
            index: null,
        }
        
    },
    methods: {
        setActiveTabName(name) {
			this.activeTabName = name;
		},
		displayContents(name) {
			return this.activeTabName === name;
		},
    },
    computed: {
    // imageUrls() {
    //   console.log(this.images)
    //   return this.images.map((image) => image.file);
    // },
  },
  mounted() {
		// The currently active tab, init as the 1st item in the tabs array
        this.activeTabName = this.tabs[0].name;
	},
}
</script>