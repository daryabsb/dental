<template>
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
								{{ patient.name }}
							</li>
						</ol>
						<!--end breadcrumb-->
					</div>
					<!--end /div-->
					<h4 class="page-title">Patient's Profile</h4>
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
											<span
												@click="
													onUploadImage(patient.id)
												"
												class="fro-profile_main-pic-change"
											>
												<i class="fas fa-camera"></i>
											</span>
										</div>
										<div class="met-profile_user-detail">
											<h5 class="met-user-name">
												{{ patient.name }}
											</h5>
											<p class="mb-0 met-user-name-post">
												UI/UX Designer
											</p>
										</div>
									</div>
								</div>
								<!--end col-->
								<div class="col-lg-4 ml-auto">
									<ul class="list-unstyled personal-detail">
										<li class="">
											<i
												class="dripicons-phone mr-2 text-info font-18"
											></i>
											<b> Phone </b> : {{ patient.phone }}
										</li>
										<li class="mt-2">
											<i
												class="dripicons-mail text-info font-18 mt-2 mr-2"
											></i>
											<b> Email </b> : {{ patient.email }}
										</li>
										<li class="mt-2">
											<i
												class="dripicons-location text-info font-18 mt-2 mr-2"
											></i>
											<b>Birthday</b> :
											{{
												$moment(patient.dob).format(
													"DD/MM/yyyy"
												)
											}}
										</li>
									</ul>
									<client-only>
										<upload-image :id="pid"></upload-image>
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
					<tab-general
						:examinations="patient.examinations"
						v-if="displayContents('tabGeneral')"
					></tab-general>
					<tab-treatment
						v-if="displayContents('tabTreatment')"
					></tab-treatment>

					<tab-files
					
					v-if="displayContents('tabFiles')"
					:files="pdfs"
					:images="images"
					:imagesURL="imagesURL"
					:patient="patient"
					></tab-files>

					<tab-appointments
						v-if="displayContents('tabAppointments')"
					></tab-appointments>
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

		let patientsURL = "/patients";
		// let attachmentsURL = '/attachments'

		try {
            let singlePatient = await $axios.$get(`${patientsURL}/${id}/`);
            
			const [patientLoaded] = await Promise.all([singlePatient]);
            // store.state.pimage = patientLoaded.image;
            
            // this.img = patientLoaded.image;
			return {
				patient: patientLoaded,
            };

            
            
		} catch (err) {
			console.log(err);
		}
	},
	data() {
		return {
			tabs: [
				{
					name: "tabGeneral",
					displayName: "General",
				},
				{
					name: "tabTreatment",
					displayName: "Treatments",
				},
				{
					name: "tabFiles",
					displayName: "Files",
				},
				{
					name: "tabAppointments",
					displayName: "Appointments",
				},
			],
			activeTabName: null,
			pid: 0,
			pdfs: null,
      		images: null,
      		imagesURL: null,
		};
	},
	methods: {
		setActiveTabName(name) {
			this.activeTabName = name;
			if (name === 'tabFiles') {
				console.log('TAB FILES')
				this.onLoadPDFs(this.patient.id);
				this.onLoadImages(this.patient.id)
			}
			
		},
		displayContents(name) {
			return this.activeTabName === name;
		},
		async onUploadImage(id) {
			this.pid = id;
			
			await this.$store.dispatch("toggleImageUploadOpen");

			// change photo of the current patient;
            // await this.updateCurrentImage();
			
            
        },
        updateCurrentImage() {
            
            this.patient.image = this.$store.state.pimage;
        },
		async onLoadPDFs(patientID) {
			// Load pdfs of the patient

			let id = patientID;

			let attachmentsURL = "/attachments";

			try {
				let singlePatientPdfs = await this.$axios.$get(
					`${attachmentsURL}/?p=${id}&type=pdf`
				);

				this.pdfs = singlePatientPdfs;
				// console.log(patientData)

				// this.pdfs = patientFiles
			} catch (err) {
				console.log(err);
			}

			// console.log('ID: ', patientID)
			// console.log('has pdf: ', this.hasPDF)
			this.togglePdf();
		},
		async onLoadImages(patientID) {
			let id = patientID;

			let attachmentsURL = "/attachments";
			let url = `${attachmentsURL}/?p=${id}&type=image`

			try {
				let singlePatientImages = await this.$axios.$get(url);
				this.images = singlePatientImages;
				this.imagesURL = singlePatientImages.map(image=>image.file);
				// console.log(this.images)

				// this.images = patientImages;
			} catch (err) {
				console.log(err);
			}

			this.toggleImages();
		},
		togglePdf() {
			if (!this.isPdfTabOpen) {
				mutations.togglePdfTab();
			}
			if (this.isImagesTabOpen) {
				mutations.toggleImagesTab();
			}
			if (this.isPatientHistoryTabOpen) {
				mutations.togglePatientHistoryTab();
			}
		},

		toggleImages() {
			if (!this.isImagesTabOpen) {
				mutations.toggleImagesTab();
			}
			if (this.isPdfTabOpen) {
				mutations.togglePdfTab();
			}
			if (this.isPatientHistoryTabOpen) {
				mutations.togglePatientHistoryTab();
			}
		},
		toggleHealthCondition() {
			if (!this.isPatientHistoryTabOpen) {
				mutations.togglePatientHistoryTab();
			}
			if (this.isPdfTabOpen) {
				mutations.togglePdfTab();
			}
			if (this.isImagesTabOpen) {
				mutations.toggleImagesTab();
			}
		},

		onlyUnique(value, index, self) {
			return self.indexOf(value) === index;
		},
    },
	computed: {
        
		isPdfTabOpen() {
			return store.isPdfTabOpen;
		},
		isImagesTabOpen() {
			return store.isImagesTabOpen;
		},
		isPatientHistoryTabOpen() {
			return store.isPatientHistoryTabOpen;
		},

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
        this.$store.dispatch('setPimage', this.patient.image);
	},
};
</script>