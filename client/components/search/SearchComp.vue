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
			<div id="datatable_filter" class="dataTables_filter">
				<input
						type="search"
						class="form-control shadow p-3 my-3 bg-white rounded text-md lead"
						placeholder="Type you search keywords"
						@keyup="onSearchInput"
						v-model="searchInput"
						
				/>
			</div>
		</div>
</div>
		<div class="col-sm-12 col-md-6 row text-center">
			<div class="col-sm-12 col-md-6 mr-0">
				<div id="datatable_filter" class="dataTables_length">
					<label class=" shadow px-3 my-3 bg-white rounded lead"
						>Filter by date:<select
							class="form-control border-0"
							placeholder=""
							aria-controls="datatable"
						>
							<option value="1" selected>Today</option>
						</select>
					</label>
				</div>
			</div>
			<div class="col-sm-12 col-md-6 ml-0">
				<div id="datatable_filter" class="dataTables_length">
					<input
							type="date"
							class="form-control shadow p-3 my-3 bg-white rounded text-md lead"
							placeholder="Date Filter"
					/>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	props: ['url', 'module', ],
	data() {
		return {
			searchInput: '',
			dateSelect: '',
			dateInput: ''
		}
	},
	methods: {
		onSearchInput() {

			console.log(this.searchInput)

		},
		onDateSelect() {

		}
	}

}
</script>