<template>


<b-container fluid>
  <b-row class="my-3">
    <b-col sm="2">
      <label for="input-none">Search:</label>
    </b-col>
    <b-col sm="10">
      <b-form-input 
	  	id="input-none" 
	  	placeholder="Enter some keywords for God's sake!"
	  	@keyup="onSearchInput"
		v-model="searchInput"
		size="lg"
	  ></b-form-input>
    </b-col>
  </b-row>

  <b-row class="my-1" v-show="date">
    <b-col sm="2">
      <label for="input-valid">Search Date:</label>
    </b-col>
    <b-col sm="5">
      <b-form-select 
	  	id="input-valid"
		  :options="dateSearchOptions" 
	  	@change="onSearchInput"
		v-model="dateSelect"
	  ></b-form-select>
    </b-col>
    
    <b-col sm="5">
      <b-form-datepicker
	  	v-model="dateInput"
		@context="onSearchInput"
		v-if="dateSelect == 'custom'"
	  ></b-form-datepicker>
    </b-col>
  </b-row>
</b-container>
























	<!-- <div class="container-fluid"> -->
	


		<!-- <div class="row">
			<div class="col-sm-12 col-md-6 row text-left">
				<div class="col-sm-12 col-md-3" v-if="pagination">
					<div class="dataTables_length" id="datatable_length">
						<label>
							Show
							<select
								name="datatable_length"
								aria-controls="datatable"
								class="custom-select custom-select-sm form-control form-control-sm"
							>
								<option value="10">10</option>
								<option value="25">25</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
							entries
						</label>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" v-if="input">
				<div class="input-group">
					<input
						class="form-control"
						type="text"
						placeholder="Type you search keywords"
						@keyup="onSearchInput"
						v-model="searchInput"
					/>
					<div class="input-group-append">
						<span
							@click="searchInput = '', onSearchInput()"
							class="input-group-text amber lighten-3"
							id="basic-text1"
						>
							<i class="far fa-times-circle text-grey" aria-hidden="true"></i>
						</span>
					</div>
				</div>
			</div>
			<div class="col-md-6 text-center" v-if="date">
				<div class="col-sm-12 col-md-6 mr-0">
					<div id="datatable_filter" class="dataTables_length">
						<label>Filter by date</label>
						<select
							class="browser-default custom-select custom-select-sm"
							@change="onSearchInput"
							v-model="dateSelect"
						>
							<option value="none" v-if="dateSelect !== 'none'">Clear Filter</option>
							<option value="today">Today</option>
							<option value="tomorrow">Tomorrow</option>
							<option value="week">This Week</option>
							<option value="month">Next Month</option>
							<option value="custom">Select a date</option>
						</select>
					</div>
				</div>
				<div class="col-sm-12 col-md-6 ml-0">
					<div id="datatable_filter" class="dataTables_length">
						<input
							type="date"
							class="form-control shadow p-3 my-3 bg-white rounded text-md lead"
							v-model="dateInput"
							@change="onSearchInput"
							v-if="dateSelect == 'custom'"
						/>
					</div>
				</div>
			</div>
		</div> -->
	<!-- </div> -->
</template>

<script>
export default {
	props: ["input", "date", "pagination", "url", "moduleState"],
	data() {
		return {
			searchInput: "",
			dateSelect: "",
			dateInput: "",
			data: {
				searchInput: "",
				date: "",
				url: "",
				module: "",
				pagination: false,
			},
			dateSearchOptions: [
				{value:"none", text: "Clear Filter"},
				{value:"today", text:"Today"},
				{value:"tomorrow", text:"Tomorrow"},
				{value:"week", text:"This Week"},
				{value:"month", text:"Next Month"},
				{value:"custom", text:"Select a date"}
			],
		};
	},
	methods: {
		onSearchInput() {
			// 1. WE GET THE INPUT SEARCH IF ANY
			if (this.input) {
				this.data.searchInput = this.searchInput;
			}

			// 2. WE GET THE DATE IF ANY
			if (this.date) {
				let query = {};

				if (query.dq !== "") {
					query.dq = this.dateSelect;
				} else {
					query.dq = "";
				}

				if (query.dq === "custom" && this.dateInput != "") {
					query.date = this.$moment(this.dateInput).format(
						"yyyy-MM-DD"
					);
				} else {
					query.date = "";
				}

				this.data.date = query;
			}

			if (this.pagination) {
				this.data.pagination = true;
			}
			if (this.url) {
				this.data.url = this.url;
			}
			if (this.moduleState) {
				this.data.module = this.moduleState;
			}

			// CHECK TO SEE IF DATE IS INCLUDED

			this.$store.dispatch("onFilter", this.data);

			// console.log(this.searchInput)
		},
		onDateSelect() {},
	},
};
</script>