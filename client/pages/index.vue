<template>
	<div class="container-fluid" v-if="isAuthenticated">
		<!-- Page-Title -->
		<div class="row">
			<div class="col-sm-12">
				<div class="page-title-box">
					<div class="float-right">
						<ol class="breadcrumb">
							<li class="breadcrumb-item active">Dashboard</li>
						</ol>
						<!--end breadcrumb-->
					</div>
					<!--end /div-->
					<h4 class="page-title">Dashboard</h4>
				</div>
				<!--end page-title-box-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->
		<!-- end page title end breadcrumb -->
		<div class="row">
			<div class="col-lg-12">
				<div class="row">
					<div class="col-lg-4">
						<div class="card hospital-info">
							<div class="card-body">
								<h4 class="header-title mt-0 mb-3">
									Appointments
								</h4>
								<div class="media">
									<div class="data-icon align-self-center">
										<i
											class="fas fa-wheelchair rounded-circle text-danger"
										></i>
									</div>
									<div
										class="media-body ml-3 align-self-center text-right"
									>
										<h3 class="mt-0">40</h3>
										<p class="text-muted mb-0 text-nowrap">
											Yesterday 32 App.
										</p>
									</div>
									<!--end media body-->
								</div>
							</div>
							<!--end card-body-->
						</div>
						<!--end card-->
					</div>
					<!-- end col-->
					<div class="col-lg-4">
						<div class="card hospital-info">
							<div class="card-body">
								<h4 class="header-title mt-0 mb-3">
									New Admit
								</h4>
								<div class="media">
									<div class="data-icon align-self-center">
										<i
											class="fas fa-bed rounded-circle text-warning"
										></i>
									</div>
									<div
										class="media-body ml-3 align-self-center text-right"
									>
										<h3 class="mt-0">21</h3>
										<p class="text-muted mb-0 text-nowrap">
											Yesterday 22 Add.
										</p>
									</div>
									<!--end media body-->
								</div>
							</div>
							<!--end card-body-->
						</div>
						<!--end card-->
					</div>
					<!-- end col-->
					<div class="col-lg-4">
						<div class="card hospital-info">
							<div class="card-body">
								<h4 class="header-title mt-0 mb-3">
									Operations
								</h4>
								<div class="media">
									<div class="data-icon align-self-center">
										<i
											class="fas fa-cut rounded-circle text-success"
										></i>
									</div>
									<div
										class="media-body ml-3 align-self-center text-right"
									>
										<h3 class="mt-0">10</h3>
										<p class="text-muted mb-0 text-nowrap">
											Yesterday 12 Ope.
										</p>
									</div>
									<!--end media body-->
								</div>
							</div>
							<!--end card-body-->
						</div>
						<!--end card-->
					</div>
					<!-- end col-->
				</div>
				<!--end row-->
			</div>
			<!--end col-->
		</div>
		<!--end row-->

		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-sm-3">
								<h4 class="header-title mt-0 mb-3">
									Hospital Survey
								</h4>
							</div>
							<div class="col-sm-9">
								<!-- <span><h4 class="header-title mt-0 mb-3">Select Date</h4></span>
                            <span>

                                 <client-only>
                                            <date-picker
                                            class="form-control"
                                                placeholder="Select a date"
                                                format="MM/dd/yyyy"
                                                v-model="date_today" />
                                        </client-only>
                            </span> -->
								<div class="form-group row">
									<label
										for="example-search-input"
										class="header-title col-sm-2 col-form-label text-right"
									>
										Search
									</label>
									<div class="col-sm-5 mr-0">
										<input
											class="form-control"
											type="search"
											value="How do I shoot web"
											id="example-search-input"
										/>
									</div>

									<label
										for="example-date-input mr-0"
										class="col-sm-2 col-form-label text-right"
										>Date</label
									>
									<div class="col-sm-3">
										<input
                                        v-model="date_today"
                                        class="form-control"
                                        type="date"
										/>
									</div>
								</div>
							</div>
						</div>
						<div class="table-responsive">
							<table id="datatable" class="table">
								<thead class="thead-light">
									<tr>
										<th>Patient Name</th>
										<th>Treatment</th>
										<th>Last Visit</th>
										<th>Diseases</th>
										<th class="text-right">Action</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<a
												href="../hospital/patient-profile.html"
												><img
													src="/_nuxt/assets/images/users/user-10.jpg"
													alt=""
													class="thumb-sm rounded-circle mr-2"
												/>Donald Gardner</a
											>
										</td>
										<td>Rebuild the rear teeth</td>
										<td>18/07/2019</td>
										<td>
											<span
												class="badge badge-soft-danger"
												>Cancer</span>
										</td>
										<td class="text-right">
											<a
												href="../hospital/patient-edit.html"
												class="mr-2"
												><i
													class="fas fa-edit text-info font-16"
												></i
											></a>
											<a href="#"
												><i
													class="fas fa-trash-alt text-danger font-16"
												></i
											></a>
										</td>
									</tr>
									<tr>
										<td>
											<a
												href="../hospital/patient-profile.html"
												><img
													src="/_nuxt/assets/images/users/user-9.jpg"
													alt=""
													class="thumb-sm rounded-circle mr-2"
												/>Keith Jacobson</a
											>
										</td>

										<td>B28 University Street US</td>

										<td>18/07/2019</td>
										<td>
											<span
												class="badge badge-soft-success"
												>Ulcers</span
											>
										</td>
										<td class="text-right">
											<a
												href="../hospital/patient-edit.html"
												class="mr-2"
												><i
													class="fas fa-edit text-info font-16"
												></i
											></a>
											<a href="#"
												><i
													class="fas fa-trash-alt text-danger font-16"
												></i
											></a>
										</td>
									</tr>
									<tr>
										<td>
											<a
												href="../hospital/patient-profile.html"
												><img
													src="/_nuxt/assets/images/users/user-9.jpg"
													alt=""
													class="thumb-sm rounded-circle mr-2"
												/>Greg Crosby</a
											>
										</td>

										<td>B28 University Street US</td>

										<td>18/07/2019</td>
										<td>
											<span
												class="badge badge-soft-danger"
												>HIV</span
											>
										</td>
										<td class="text-right">
											<a
												href="../hospital/patient-edit.html"
												class="mr-2"
												><i
													class="fas fa-edit text-info font-16"
												></i
											></a>
											<a href="#"
												><i
													class="fas fa-trash-alt text-danger font-16"
												></i
											></a>
										</td>
									</tr>
									<tr>
										<td>
											<a
												href="../hospital/patient-profile.html"
												><img
													src="/_nuxt/assets/images/users/user-8.jpg"
													alt=""
													class="thumb-sm rounded-circle mr-2"
												/>Fred Godina</a
											>
										</td>

										<td>B28 University Street US</td>

										<td>18/07/2019</td>
										<td>
											<span
												class="badge badge-soft-success"
												>Virus Fever</span
											>
										</td>
										<td class="text-right">
											<a
												href="../hospital/patient-edit.html"
												class="mr-2"
												><i
													class="fas fa-edit text-info font-16"
												></i
											></a>
											<a href="#"
												><i
													class="fas fa-trash-alt text-danger font-16"
												></i
											></a>
										</td>
									</tr>
									<tr>
										<td>
											<a
												href="../hospital/patient-profile.html"
												><img
													src="/_nuxt/assets/images/users/user-7.jpg"
													alt=""
													class="thumb-sm rounded-circle mr-2"
												/>Peggy Doe</a
											>
										</td>

										<td>B28 University Street US</td>

										<td>20/07/2019</td>
										<td>
											<span
												class="badge badge-soft-success"
												>heart attack</span
											>
										</td>
										<td class="text-right">
											<a
												href="../hospital/patient-edit.html"
												class="mr-2"
												><i
													class="fas fa-edit text-info font-16"
												></i
											></a>
											<a href="#"
												><i
													class="fas fa-trash-alt text-danger font-16"
												></i
											></a>
										</td>
									</tr>
									<tr>
										<td>
											<a
												href="../hospital/patient-profile.html"
												><img
													src="/_nuxt/assets/images/users/user-8.jpg"
													alt=""
													class="thumb-sm rounded-circle mr-2"
												/>Jennifer Doss</a
											>
										</td>

										<td>B28 University Street US</td>

										<td>19/07/2019</td>
										<td>
											<span
												class="badge badge-soft-danger"
												>Ebola</span
											>
										</td>
										<td class="text-right">
											<a
												href="../hospital/patient-edit.html"
												class="mr-2"
												><i
													class="fas fa-edit text-info font-16"
												></i
											></a>
											<a href="#"
												><i
													class="fas fa-trash-alt text-danger font-16"
												></i
											></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!--end card-body-->
				</div>
				<!--end card-->
			</div>
		</div>
	</div>
	<!-- container -->
	<div class="container-fluid" v-else>
		<h1>You have to login to view this page</h1>
	</div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
	data() {
		return {
			date_today: new Date(),
		};
	},
	computed: {
		...mapGetters(["isAuthenticated", "loggedInUser"]),
	},
};
</script>
