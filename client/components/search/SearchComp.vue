<template>
	<div class="row">
		<div class="col-sm-12 col-md-6 row text-left">
		<div class="col-sm-12 col-md-3">
			<div class="dataTables_length" id="datatable_length">
				<label
					>Show
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
					entries</label
				>
			</div>
		</div>
		<div class="col-sm-12 col-md-9">
			

			<div class="input-group md-form form-sm form-2">
				<input class="form-control my-0 py-1 amber-border" 
					type="text" 
					placeholder="Type you search keywords"
					@keyup="onSearchInput"
					v-model="searchInput"
				>
				<div class="input-group-append">
					<span @click="searchInput = '', onSearchInput()" class="input-group-text amber lighten-3" id="basic-text1">
						<i class="far fa-times-circle text-grey" aria-hidden="true"></i>
					</span>
				</div>
			</div>
		</div>
</div>
		<div class="col-sm-12 col-md-6 row text-center" v-if="date">
			<div class="col-sm-12 col-md-6 mr-0">
				<div id="datatable_filter" class="dataTables_length">
					<label>Filter by date</label>
					<select class="browser-default custom-select custom-select-sm" 
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
	</div>
</template>

<script>
export default {
	props: ['input', 'date', 'pagination', 'url', 'moduleState', ],
	data() {
		return {
			searchInput: '',
			dateSelect: '',
			dateInput: '',
			data: {
				searchInput: '',
				date: '',
				url: '',
				module: '',
				pagination: false,
			}
		}
	},
	methods: {
		onSearchInput() {

			// 1. WE GET THE INPUT SEARCH IF ANY
			if (this.input) { this.data.searchInput = this.searchInput}
			
			// 2. WE GET THE DATE IF ANY
			if (this.date) { 

				let query = {}

				if (query.dq !== '') {
				query.dq = this.dateSelect;
				} else {
				query.dq = ''
				}
				
				if (query.dq === 'custom' && this.dateInput != '') {
				query.date = this.$moment(this.dateInput).format("yyyy-MM-DD")
				} else {
				query.date = ''
				}

				this.data.date = query
				
			}

			if (this.pagination) { this.data.pagination = true}
			if (this.url) { this.data.url = this.url}
			if (this.moduleState) { this.data.module = this.moduleState}

			// CHECK TO SEE IF DATE IS INCLUDED
			
			
			this.$store.dispatch('onFilter', this.data)

			// console.log(this.searchInput)

		},
		onDateSelect() {

		}
	}

}
</script>