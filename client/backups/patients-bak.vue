<template>
	<div class="container-fluid">
		<AddPatient
			:editId="editId"
			:editUser="editUser ? editUser : 1"
			:editName="editName"
			:editDoctor="editDoctor"
			:editDob="editDob"
			:editGender="editGender"
			:editPhone="editPhone"
			:editEmail="editEmail"
			:editDescription="editDescription"
			:editStatus="editStatus"
		/>

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
            
          
              	<add-new-patient></add-new-patient>
          
						<!-- <button
							type="button"
							@click="showModal(false)"
							data-toggle="modal"
							data-animation="bounce"
							data-target=".patient_create"
							class="btn btn-primary btn-outline-white px-4 mt-0 mb-3"
						>
							<i class="mdi mdi-plus-circle-outline mr-2"></i>Add
							New Patient
						</button> -->
						
					
						<div class="table-responsive">
							<div
								id="datatable_wrapper"
								class="dataTables_wrapper dt-bootstrap4 no-footer"
							>
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
										<table
											id="datatable"
											class="table dataTable no-footer"
											role="grid"
											aria-describedby="datatable_info"
										>
											<thead class="thead-light">
												<tr role="row">
													<th
														class="sorting_asc"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-sort="ascending"
														aria-label="Patient Name: activate to sort column descending"
														style="width: 201px"
													>
														Patient Name
													</th>
													<th
														class="sorting"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-label="Age: activate to sort column ascending"
														style="width: 54px"
													>
														Age
													</th>
													<th
														class="sorting"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-label="ID: activate to sort column ascending"
														style="width: 54px"
													>
														ID
													</th>
													<th
														class="sorting"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-label="Address: activate to sort column ascending"
														style="width: 207px"
													>
														Address
													</th>
													<th
														class="sorting"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-label="Mobile No: activate to sort column ascending"
														style="width: 109px"
													>
														Mobile No
													</th>
													<th
														class="sorting"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-label="Last Visit: activate to sort column ascending"
														style="width: 100px"
													>
														Last Visit
													</th>
													<th
														class="sorting"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-label="Status: activate to sort column ascending"
														style="width: 78px"
													>
														Status
													</th>
													<th
														class="text-right sorting"
														tabindex="0"
														aria-controls="datatable"
														rowspan="1"
														colspan="1"
														aria-label="Action: activate to sort column ascending"
														style="width: 78px"
													>
														Action
													</th>
												</tr>
												<!--end tr-->
											</thead>

											<tbody>
												<tr
													role="row"
													class="odd"
													v-for="patient in patients"
													:key="patient.id"
												>
													<td class="sorting_1">
														<img
															:src="patient.image"
															@click="
																onUploadImage(
																	patient.id
																)
															"
															alt=""
															class="thumb-sm rounded-circle mr-2"
														/>
														<nuxt-link
															:to="`/patients/${patient.id}`"
															class="a-link-normal"
														>
															{{ patient.name }}
														</nuxt-link>
													</td>
													<td>{{ patient.age }}</td>
													<td>#{{ patient.id }}</td>
													<td>{{ patient.email }}</td>
													<td>{{ patient.phone }}</td>
													<td>18/07/2019</td>
													<td>
														<span
															:class="patient.status ? 'badge  badge-soft-success' : 'badge  badge-soft-danger'"
															>{{patient.status ? 'Active' : 'Inactive'}}</span
														>
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
															><i
																class="fas fa-edit text-info font-16"
															></i
														></a>
														<a
															@click="
																confirmDelete(
																	patient.name,
																	patient.id
																)
															"
															><i
																class="fas fa-trash-alt text-danger font-16"
															></i
														></a>
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
								<div class="row">
									<div class="col-sm-12 col-md-5">
										<div
											class="dataTables_info"
											id="datatable_info"
											role="status"
											aria-live="polite"
										>
											Showing 1 to 6 of 6 entries
										</div>
									</div>
									<div class="col-sm-12 col-md-7">
										<div
											class="dataTables_paginate paging_simple_numbers"
											id="datatable_paginate"
										>
											<ul class="pagination">
												<li
													class="paginate_button page-item previous disabled"
													id="datatable_previous"
												>
													<a
														href="#"
														aria-controls="datatable"
														data-dt-idx="0"
														tabindex="0"
														class="page-link"
														>Previous</a
													>
												</li>
												<li
													class="paginate_button page-item active"
												>
													<a
														href="#"
														aria-controls="datatable"
														data-dt-idx="1"
														tabindex="0"
														class="page-link"
														>1</a
													>
												</li>
												<li
													class="paginate_button page-item next disabled"
													id="datatable_next"
												>
													<a
														href="#"
														aria-controls="datatable"
														data-dt-idx="2"
														tabindex="0"
														class="page-link"
														>Next</a
													>
												</li>
											</ul>
										</div>
									</div>
								</div>
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

export default {
	async asyncData({ $axios, app, store }) {
		await store.dispatch("loadData");

		// this.$store.dispatch('loadData', 'DONE');
	},
	data() {
		return {
			// show: false,
			pid: "",
			patientNameDelete: "",
			patientIdDelete: "",
			editPatient: [],
			addUserModal: false,
			editId: "",
			editUser: "",
			editName: "",
			editDoctor: 1,
			editDob: "",
			editGender: "",
			editPhone: "",
			editEmail: "",
			editDescription: "",
			editStatus: true,
			searchInput: "",
			searchDate: "",
		};
	},
	components: {},
	methods: {
		onUploadImage(id) {
			this.pid = id;
			// this.$store.conf.dispatch('conf/toggleImageUploadOpen')
			this.$store.dispatch("toggleImageUploadOpen");
			// this.show = true;
		},
    /*
    showModal(modalState, data = {}) {
			if (!modalState) {
				this.editUser = this.$auth.user.id;
				this.editId = "";
				this.editName = "";
				this.editDoctor = 1;
				this.editDob = "";
				this.editGender = "";
				this.editPhone = "";
				this.editEmail = "";
				this.editDescription = "";
				this.editStatus = true;
				store.isEditModal;
				//this.$store.conf.actions.dispatch('showAddUserModal');
				store.isEditModal = false;
				mutations.toggleAddPatientModal();

				//this.addUserModal = !this.addUserModal;
			} else {
				this.editUser = data.user;
				this.editId = data.id;
				this.editName = data.name;
				this.editDoctor = data.doctor;
				this.editDob = data.dob;
				this.editGender = data.gender;
				this.editPhone = data.phone;
				this.editEmail = data.email;
				this.editDescription = data.description;
				this.editStatus = data.status;

				//this.addUserModal = !this.addUserModal;
				store.isEditModal = true;
				mutations.toggleAddPatientModal();
			}
		},
*/
		confirmDelete(name, id) {
			(this.patientNameDelete = name),
				(this.patientIdDelete = id),
				mutations.toggleConfirmDelete();
		},
	},
	computed: {
		// patients() {
		//   return this.getPatients;
		// },
		isAddPatientModalOpen() {
			return store.isAddPatientModalOpen;
		},
		isConfirmDeleteOpen() {
			return store.isConfirmDeleteOpen;
		},
		...mapGetters(["patients"]),
	},
};
</script>
<style scoped>
/* .showModal {
	display: none;
} */
</style>
