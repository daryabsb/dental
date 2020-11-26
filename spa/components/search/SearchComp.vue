<template>
	<b-row>
		<b-col sm="6">
			<b-input-group class="mb-3">
				<b-input-group-prepend is-text>
					<!-- <input type="checkbox" aria-label="Checkbox for following text input"> -->
					<i class="fas fa-search"></i>
				</b-input-group-prepend>
				<b-form-input
					placeholder="Enter some keywords for God's sake!"
					@keyup="onSearchInput"
					v-model="searchInput"
					size="lg"
					aria-label="Text input with checkbox"
				></b-form-input>
			</b-input-group>
		</b-col>
		<b-col sm="6" v-show="date">
			<b-row >
				<b-col sm="6">
					<b-form-select
						id="input-valid"
						:options="dateSearchOptions"
						@change="onSearchInput"
						v-model="dateSelect"
					></b-form-select>
				</b-col>

				<b-col sm="6">
					<b-form-datepicker
						v-model="dateInput"
						@context="onSearchInput"
						v-if="dateSelect == 'custom'"
						dropleft
						style="z-index:55;"
					></b-form-datepicker>
				</b-col>
			</b-row>
		</b-col>
	</b-row>
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
				{ value: '', text: "Search by Date" },
				{ value: "none", text: "Clear Filter" },
				{ value: "today", text: "Today" },
				{ value: "tomorrow", text: "Tomorrow" },
				{ value: "week", text: "This Week" },
				{ value: "month", text: "Next Month" },
				{ value: "custom", text: "Select a date" },
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