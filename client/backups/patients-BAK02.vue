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
							<li class="breadcrumb-item">Patients</li>
						</ol>
						<!--end breadcrumb-->
					</div>
					<!--end /div-->
					<h4 class="page-title">All Patients</h4>
				</div>
				<!--end page-title-box-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->
		<!-- end page title end breadcrumb -->
		<div>
			<client-only>
				<upload-image :id="pid"></upload-image>
			</client-only>
		</div>

		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body card-body__modal">
						<b-button
							variant="primary"
							id="show-btn"
							size="md"
							class="mb-3"
							@click="showModal(false, patient={})"
						>
							<i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Patient
						</b-button>
						<b-modal variant="primary" size="lg" ref="my-modal" hide-footer title="Add a new patient">
							<add-new-patient @hideModal="hideModal" :edit="edit" :editPatient="testPatient"></add-new-patient>
						</b-modal>

						<div class="table-responsive">
							<div id="datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
								<!-- SEARCH COMPONENT -->
								<search-comp
									:input="true"
									:date="false"
									:pagination="false"
									url="/patients/"
									moduleState="PATIENTS"
								></search-comp>
								<!-- <pre>{{ patients }}</pre> -->
								<div class="row">
									<div class="col-sm-12">
										<table id="patient-table" class="table dataTable no-footer">
											<thead class="thead-light">
												<tr role="row">
													<th class="sorting_asc" style="width: 201px">Patient Name</th>
													<th class="sorting" style="width: 54px">Age</th>
													<th class="sorting" style="width: 54px">ID</th>
													<th class="sorting" style="width: 207px">Address</th>
													<th class="sorting" style="width: 109px">Mobile No</th>
													<th class="sorting" style="width: 100px">Last Visit</th>
													<th class="sorting" style="width: 78px">Status</th>
													<th class="text-right sorting" style="width: 78px">Action</th>
												</tr>
												<!--end tr-->
											</thead>

											<tbody>
												<tr role="row" class="odd" v-for="patient in patients" :key="patient.id">
													<!-- @click="onUploadImage(patient.id)" -->
													<td class="sorting_1">
														<img :src="patient.image" alt class="thumb-sm rounded-circle mr-2" />
														<nuxt-link :to="`/patients/${patient.id}`" class="a-link-normal">{{ patient.name }}</nuxt-link>
													</td>
													<td>{{ patient.age }}</td>
													<td>#{{ patient.id }}</td>
													<td>{{ patient.email }}</td>
													<td>{{ patient.phone }}</td>
													<td>18/07/2019</td>
													<td>
														<span
															:class="patient.status ? 'badge  badge-soft-success' : 'badge  badge-soft-danger'"
														>{{patient.status ? 'Active' : 'Inactive'}}</span>
													</td>
													<td class="text-right">
														<a
															@click="
																showModal(
																	true,
																	patient
																)
															"
															class="mr-2"
														>
															<i class="fas fa-edit text-info font-16"></i>
														</a>
														<a
															@click="
																confirmDelete(
																	patient.name,
																	patient.id
																)
															"
														>
															<i class="fas fa-trash-alt text-danger font-16"></i>
														</a>
													</td>
												</tr>
												<ModalConfirm
													:title="'Confirm Delete'"
													:module="
														$store.state.patients
													"
													:moduleName="'patients'"
													:name="patientNameDelete"
													:id="patientIdDelete"
												/>
											</tbody>
										</table>
									</div>
								</div>

								<b-row>
									<b-col>
										<b-table
											id="my-table"
											per-page="10"
											:items="patients"
											:fields="fields"
											:current-page="currentPage"
											head-variant="light"
										>
											<template #cell(name)="row">
												<!-- `data.value` is the value after formatted by the Formatter -->
												<nuxt-link :to="`/patients/${row.item.id}`">
													<img :src="row.item.image" alt="patient" class="thumb-sm rounded-circle mr-2" />
													{{ row.item.name }}
												</nuxt-link>
											</template>
											<template #cell(id)="row">#{{row.item.id}}</template>
											<template #cell(actions)="row">
												<a 
													@click="showModal(true,row.item)"
													class="mr-2"
												>
													<i class="fas fa-edit text-info font-16"></i>
												</a>
												<a
													@click="confirmDelete(row.item.name,row.item.id)"
												>
													<i class="fas fa-trash-alt text-danger font-16"></i>
												</a>
											</template>
										</b-table>
									</b-col>
								</b-row>
								<b-row>
									<b-col md="6">Showing {{currentPage}} of {{numPages}} entries</b-col>
									<b-col md="6">
										<b-pagination
											v-model="currentPage"
											:total-rows="patientsData.count"
											per-page="10"
											aria-controls="my-table"
										></b-pagination>
									</b-col>
								</b-row>
							</div>
						</div>
					</div>
					<!--end card-body-->
				</div>
				<!--end card-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->
	</div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { store, mutations } from "../../store/utils/conf";
import { choices } from "../../store/utils/choices";

export default {
	async asyncData({ $axios, app, store }) {
		await store.dispatch("loadData");

		// this.$store.dispatch('loadData', 'DONE');
	},
	data() {
		return {
			show: true,
			currentPage: 1,
			fields: ["name", "id", "email", "phone", "actions"],
			// pid: "",
			patientNameDelete: "",
			patientIdDelete: "",
			editPatient: null,
			edit: true,
			searchInput: "",
			searchDate: "",
			testPatient: {
				type: Object,
				default: null,
			},
		};
	},
	components: {},
	methods: {
		hideModal() {
			this.$refs["my-modal"].hide();
		},
		showModal(status, patient) {
			this.edit = status;

			if (status) {
				// console.log('Patient before send to edit: ', patient)

				this.stripPayload(patient);

				this.$store.dispatch("updateCurrentPatientState", patient);

				this.$refs["my-modal"].show();
			} else {
				this.$refs["my-modal"].show();
			}
		},
		onUploadImage(id) {
			this.pid = id;
			// this.$store.conf.dispatch('conf/toggleImageUploadOpen')
			this.$store.dispatch("toggleImageUploadOpen");
			// this.show = true;
		},
		onEditPatient(patient) {
			this.editPatient = patient;
		},
		confirmDelete(name, id) {
			(this.patientNameDelete = name),
				(this.patientIdDelete = id),
				mutations.toggleConfirmDelete();
		},
		stripPayload(patient) {
			delete patient["attachments"];
			delete patient["appointments"];
			delete patient["treatments"];
			delete patient["image"];
			delete patient.examinations["patient"];
			delete patient.examinations["created"];
			delete patient.examinations["updated"];
			delete patient.medicals["patient"];
			delete patient.medicals["created"];
			delete patient.medicals["updated"];

			return patient;
		},
		calculatePagesCount(pageSize, totalCount) {
			// we suppose that if we have 0 items we want 1 empty page
			return totalCount < pageSize ? 1 : Math.ceil(totalCount / pageSize);
		},
	},
	computed: {
		// patients() {
		//   return this.getPatients;
		// },
		numPages() {
			return this.calculatePagesCount(10, this.patientsData.count);
		},
		isAddPatientModalOpen() {
			return store.isAddPatientModalOpen;
		},
		isConfirmDeleteOpen() {
			return store.isConfirmDeleteOpen;
		},
		patients() {
			return this.patientsData.results;
		},
		...mapGetters(["patientsData", "pid"]),
	},
};
</script>
<style scoped>
/* .showModal {
	display: none;
} */
</style>
