<template>
    <div class="container-fluid">
                    <!-- Page-Title -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="page-title-box">
                                <div class="float-right">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="javascript:void(0);">Hospital</a></li>
                                        <li class="breadcrumb-item"><a href="javascript:void(0);">Patients</a></li>
                                        <li class="breadcrumb-item active">Patients</li>
                                    </ol><!--end breadcrumb-->
                                </div><!--end /div-->
                                <h4 class="page-title">All Patients</h4>
                            </div><!--end page-title-box-->
                        </div><!--end col-->
                    </div><!--end row-->
                    <!-- end page title end breadcrumb -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <button type="button" class="btn btn-primary px-4 mt-0 mb-3" onclick="location.href='../hospital/add-patient.html'"><i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Patient</button>
                                    <div class="table-responsive">
                                        <div id="datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer"><div class="row"><div class="col-sm-12 col-md-6"><div class="dataTables_length" id="datatable_length"><label>Show <select name="datatable_length" aria-controls="datatable" class="custom-select custom-select-sm form-control form-control-sm"><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select> entries</label></div></div><div class="col-sm-12 col-md-6"><div id="datatable_filter" class="dataTables_filter"><label>Search:<input type="search" class="form-control form-control-sm" placeholder="" aria-controls="datatable"></label></div></div></div><div class="row"><div class="col-sm-12"><table id="datatable" class="table dataTable no-footer" role="grid" aria-describedby="datatable_info">
                                            <thead class="thead-light">
                                            <tr role="row">
                                                <th class="sorting_asc" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Patient Name: activate to sort column descending" style="width: 201px;">Patient Name</th>
                                                <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" style="width: 54px;">Age</th>
                                                <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="ID: activate to sort column ascending" style="width: 54px;">ID</th>
                                                <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="Address: activate to sort column ascending" style="width: 207px;">Address</th>
                                                <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="Mobile No: activate to sort column ascending" style="width: 109px;">Mobile No</th>
                                                <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="Last Visit: activate to sort column ascending" style="width: 100px;">Last Visit</th>
                                                <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending" style="width: 78px;">Status</th>
                                                <th class="text-right sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="Action: activate to sort column ascending" style="width: 78px;">Action</th>
                                                </tr><!--end tr-->
                                            </thead>
        
                                            <tbody>
                                                                         
                                            <tr role="row" class="odd" v-for="patient in patients" :key="patient.id">
                                                <td class="sorting_1">


<nuxt-link :to="`/patients/${patient.id}`" class="a-link-normal">
                            <img src="~assets/images/users/user-10.jpg" alt="" class="thumb-sm rounded-circle mr-2">
                              {{patient.name}}
                             
                            
</nuxt-link>








                                                   
                                                
                                                
                                                
                                                
                                                </td>
                                                <td>{{patient.age}}</td>
                                                <td>#{{patient.id}}</td>
                                                <td>{{patient.email}}</td>
                                                <td>{{patient.phone}}</td> 
                                                <td>18/07/2019</td>
                                                <td><span class="badge badge-soft-success">Approved</span></td>                                                                                               
                                                <td class="text-right">                                                       
                                                    <a href="../hospital/patient-edit.html" class="mr-2"><i class="fas fa-edit text-info font-16"></i></a>
                                                    <a href="#"><i class="fas fa-trash-alt text-danger font-16"></i></a>
                                                </td>
                                            </tr>
                                            
                                            </tbody>
                                        </table></div></div><div class="row"><div class="col-sm-12 col-md-5"><div class="dataTables_info" id="datatable_info" role="status" aria-live="polite">Showing 1 to 6 of 6 entries</div></div><div class="col-sm-12 col-md-7"><div class="dataTables_paginate paging_simple_numbers" id="datatable_paginate"><ul class="pagination"><li class="paginate_button page-item previous disabled" id="datatable_previous"><a href="#" aria-controls="datatable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li><li class="paginate_button page-item active"><a href="#" aria-controls="datatable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li><li class="paginate_button page-item next disabled" id="datatable_next"><a href="#" aria-controls="datatable" data-dt-idx="2" tabindex="0" class="page-link">Next</a></li></ul></div></div></div></div>                    
                                    </div>                                         
                                </div><!--end card-body--> 
                            </div><!--end card--> 
                        </div> <!--end col-->                               
                    </div><!--end row-->    

                </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
    components: {
        },
    methods: {
        
    },
    mounted: {
        patients(){
            return this.$store.state.patients
        }
    },
}
</script>