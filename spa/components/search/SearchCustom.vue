<template>
     <div class="row">
                  <div class="col-sm-6 col-md-3">
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
                  <div class="col-sm-6 col-md-8">
                    <div id="datatable_filter" class="dataTables_filter">
                      <label style="display: inline;"
                        >Search: <input
                        style="margin-right:10px;"
                          type="search"
                          class="form-control form-control-sm"
                          placeholder=""
                      />
                        </label>
                    </div>
                  </div>
                </div>
</template>