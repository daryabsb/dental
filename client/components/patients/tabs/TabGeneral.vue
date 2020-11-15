<template>
    <div>
                                    <div class="row">
                                        <!-- <pre>{{examinations}}</pre> -->
                                        <div class="col-12 px-0">                                            
                                            
                                                   <div class="row">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-12">
                                     <div class="card">
                                <div class="card-body">
                                    <span class="float-right text-muted font-weight-normal">These examinations were updated on: {{$moment(examinations.updated).format('DD/MM/yyyy')}}</span>
                                    <h2 class="text-pink text-uppercase mt-0">Clinical Examinations</h2> 
                                    <!-- <p class="text-muted mb-4">Make a paragraph stand out by adding <code class="highlighter-rouge">.lead</code>.</p> -->
                                    <p class="text-info lead mb-0">
                                        Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.
                                    </p>
                                </div><!--end card-body-->
                            </div><!--end card-->
                                </div>
                                 <!-- TREATMENT PLAN -->
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Treatment Plan</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.treatment_plan}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end treatment plan-->
                                
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Skeletal Class</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.skeletal_class}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                 <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Nasolabial Angle</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.nasolabial_angle}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Nasolabial Sulcus</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.nasolabial_sulcus}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Lip Competency</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.lip_competency}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Face Form</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.face_form}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Molar Class Left</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.molar_class_left}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Molar Class Left</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.molar_class_right}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Midline Upper</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.midline_upper}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Midline Lower</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.midline_lower}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Overjet</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.overjet}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Oral Hygiene</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.oral_hygiene}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Treated Arch</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.treated_arch}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Treated Arch</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.treated_arch}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Slot</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.slot}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Bracket System</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.bracket_system}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Extraction Upper</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.extraction_upper}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Extraction Lower</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.extraction_lower}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body">
                                            <span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
                                            <h3 class="font-weight-normal mt-0 mb-4">Anchorage Upper</h3>
                                            <h5 class="mb-0 font-weight-normal text-success">{{examinations.anchorage_upper}}</h5>
                                        </div><!--end card-body-->
                                    </div><!--end card-->
                                </div><!--end col-->
                               
                            </div><!--end row-->
                        </div><!--end col-->
                    </div><!--end row-->                         
                </div><!--end col-->
            </div><!--end row-->                                             
        </div><!--end general detail-->
</template>

<script>
export default {
    props: ['examinations']
}
</script>