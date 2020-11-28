<template>

<!-- 

1. add todos
2. add general settings
3. add user settings
4. add general numbers(patients, treatments, files)





 -->
	<div class="container-fluid">
		<!-- Page-Title -->
		<div class="row">
			<div class="col-sm-12">
				<div class="page-title-box">
					<div class="float-right">
						<ol class="breadcrumb">
							<li class="breadcrumb-item">
								<nuxt-link to="/">Home</nuxt-link>
							</li>
							<li class="breadcrumb-item">
								<nuxt-link to="/patients">Patients</nuxt-link>
							</li>
							<li class="breadcrumb-item active">
								{{ $auth.user.name }}
							</li>
						</ol>
						<!--end breadcrumb-->
					</div>
					<!--end /div-->
					<h4 class="page-title">User's Profile</h4>
				</div>
				<!--end page-title-box-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->
		<!-- end page title end breadcrumb -->
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body met-pro-bg">
						<div class="met-profile">
							<div class="row">
								<div
									class="col-lg-4 align-self-center mb-3 mb-lg-0"
								>
									<div class="met-profile-main">
										<div class="met-profile-main-pic">
											<img
												:src="pimage"
												alt="patient"
												style="width: 95%"
												class="rounded-circle"
											/>
											<!-- <img
												src="~assets/images/users/user-1.jpg"
												alt="patient"
												style="width: 95%"
												class="rounded-circle"
											/> -->
											<span
												@click="
													onUploadImage(user.id)
												"
												class="fro-profile_main-pic-change"
											>
												<i class="fas fa-camera"></i>
											</span>
										</div>
										<div class="met-profile_user-detail">
											<h5 class="met-user-name">
												{{ user.name }}
											</h5>
											<p class="mb-0 met-user-name-post">
												{{ user.is_staff ? 'Admin' : 'Normal User' }}
											</p>
										</div>
									</div>
								</div>
								<!--end col-->
								<div class="col-lg-4 ml-auto">
									<ul class="list-unstyled personal-detail">
										<!-- <li class="">
											<i
												class="dripicons-phone mr-2 text-info font-18"
											></i>
											<b> Phone </b> : {{ patient.phone }}
										</li> -->
										<li class="mt-2">
											<i
												class="dripicons-mail text-info font-18 mt-2 mr-2"
											></i>
											<b> Email </b> : {{ user.email }}
										</li>
										<li class="mt-2">
											<i
												class="dripicons-location text-info font-18 mt-2 mr-2"
											></i>
											<b>Date Joined</b> :
											{{
												$moment(user.created).format(
													"DD/MM/yyyy"
												)
											}}
										</li>
									</ul>
									<client-only>
										<!-- <test-upload :id="pid"></test-upload> -->
										<upload-image :url="url" :id="pid"></upload-image>
									</client-only>
									<div class="button-list btn-social-icon">
										<button
											type="button"
											class="btn btn-blue btn-round"
										>
											<i class="fab fa-facebook-f"></i>
										</button>

										<button
											type="button"
											class="btn btn-secondary btn-round ml-2"
										>
											<i class="fab fa-twitter"></i>
										</button>

										<button
											type="button"
											class="btn btn-pink btn-round ml-2"
										>
											<i class="fab fa-dribbble"></i>
										</button>
									</div>
								</div>
								<!--end col-->
							</div>
							<!--end row-->
						</div>
						<!--end f_profile-->
					</div>
					<!--end card-body-->
					<div class="card-body">
						<ul
							class="nav nav-pills mb-0"
							id="pills-tab"
							role="tablist"
						>
							<li
								class="nav-item"
								v-for="tab in tabs"
								:key="tab.name"
							>
								<a
									@click="setActiveTabName(tab.name)"
                                    href="javascript: void(0);"
									class="nav-link"
									id="general_detail_tab"
									data-toggle="pill"
									:class="{
										active: tab.name === activeTabName,
									}"
									>{{ tab.displayName }}</a
								>
							</li>
						</ul>
					</div>
					<!--end card-body-->
				</div>
				<!--end card-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->
		<div class="row">
			<div class="col-12">
				<div class="tab-content detail-list">
					
					<tab-user-settings
						:user="$auth.user" v-if="displayContents('tabUser')"
					></tab-user-settings>
					<tab-general-settings
						:settings="$auth.user"
						v-if="displayContents('tabGeneral')"
					></tab-general-settings>

					<!-- <tab-files
					
					v-if="displayContents('tabFiles')"
					:files="pdfs"
					:images="images"
					:imagesURL="imagesURL"
					:patient="patient"
					></tab-files> -->

					<!-- <tab-appointments
						v-if="displayContents('tabAppointments')"
						:appointments="appointments"
					></tab-appointments> -->
				</div>
				<!--end tab-content-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->
	</div>
	<!-- container -->
</template>

<script>
import { store, mutations } from "../../store/utils/conf";
import { mapState, mapActions, mapGetters } from "vuex";
export default {
	async asyncData({ $axios, store, params }) {
		let id = params.id;
		console.log("Page Loaded: ", id);
		// store.dispatch('loadPatientData', id);
		// mutations.togglePatientHistoryTab();
		console.log("Function is loaded and the ID is: ", id);

		let usersURL = "/users";
		// let attachmentsURL = '/attachments'

		try {
            let singleUser = await $axios.$get(`${usersURL}/${id}/`);
            
			const [userLoaded] = await Promise.all([singleUser]);
            // store.state.pimage = patientLoaded.image;
            
            // this.img = patientLoaded.image;
			return {
				user: userLoaded,
            };

            
            
		} catch (err) {
			console.log(err);
		}
	},
	data() {
		return {
			tabs: [
				{
					name: "tabUser",
					displayName: "User Settings",
				},
				{
					name: "tabGeneral",
					displayName: "General Settings",
				},
				// {
				// 	name: "tabFiles",
				// 	displayName: "Files",
				// },
				// {
				// 	name: "tabRe",
				// 	displayName: "Appointments",
				// },
			],
			activeTabName: null,
			pid: 0,
			url: '',
			// pdfs: null,
      		// images: null,
			// imagesURL: null,
			// appointments: null,
		};
	},
	methods: {
		setActiveTabName(name) {
			this.activeTabName = name;
			// if (name === 'tabFiles') {
			// 	console.log('TAB FILES')
			// 	this.onLoadPDFs(this.patient.id);
			// 	this.onLoadImages(this.patient.id)

			// } else if (name === 'tabAppointments') {
			// 	this.onLoadAppointments(this.patient.id);
			// }
			
		},
		displayContents(name) {
			return this.activeTabName === name;
		},
		
		async onUploadImage(id) {
			this.pid = id;
			this.url = `/users/${id}/image/`;
			await this.$store.dispatch("toggleImageUploadOpen");

			// change photo of the current patient;
            // await this.updateCurrentImage();
			
            
        },
        updateCurrentImage() {
            
            this.patient.image = this.$store.state.pimage;
        },
		
	
    },
	computed: {
        
	
		// patient() {
		//   return this.getPatient;
		// },
		...mapGetters([
			"getPatientPDFs",
			"getPatientImages",
			"hasPDF",
			"hasIMAGES",
            "patientHasImage",
            "pimage",
		]),
	},
	mounted() {
		// The currently active tab, init as the 1st item in the tabs array
        this.activeTabName = this.tabs[0].name;
        this.$store.dispatch('setPimage', this.user.image);
	},
};
</script>