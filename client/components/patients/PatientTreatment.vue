<template>
    <div class="col-lg-6">
                            <div class="card">                                       
                                <div class="card-body"> 
                                    <h4 class="header-title mt-0 mb-3">Experience</h4>
                                   <button 
                                   @click="showModal()"
                                   type="button" 
                                   class="btn btn-primary btn-outline-white px-4 mt-0 mb-3">
                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment
                                        </button>
                                    <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 363px;"><div class="slimscroll education-activity" style="overflow: hidden; width: auto; height: 363px;">
                                       <ModalTreatment />
                                        <perfect-scrollbar> 
                                            <div class="activity">
                                            <i class="mdi mdi-school icon-success"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Oxford University</h6>
                                                        <span class="text-muted">Oct-2009 to Oct-2011</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Design</span>
                                                        <span class="badge badge-soft-secondary">HTML</span>                                                    
                                                        <span class="badge badge-soft-secondary">Css</span>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="mdi mdi-medal icon-pink"></i>                                                                                                           
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Apollo Hospital</h6>
                                                        <span class="text-muted">Oct-2006 to Oct-209</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Python</span>
                                                        <span class="badge badge-soft-secondary">Django</span>
                                                    </div>
                                                </div>                                            
                                            </div>
                                            <i class="mdi mdi-book-open-page-variant icon-purple"></i> 
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Stanford Hospitals</h6>
                                                        <span class="text-muted">Oct-2003 to Oct-2006</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                </div>
                                            </div>                                         
                                            <i class="mdi mdi-lead-pencil icon-warning"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Karolinska Hospital</h6>
                                                        <span class="text-muted">Oct-1996 to Oct-2003</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>                                                
                                                </div>
                                            </div> 
                                            <i class="mdi mdi-school icon-success"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Oxford University</h6>
                                                        <span class="text-muted">Oct-2009 to Oct-2011</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Design</span>
                                                        <span class="badge badge-soft-secondary">HTML</span>                                                    
                                                        <span class="badge badge-soft-secondary">Css</span>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="mdi mdi-medal icon-pink"></i>                                                                                                           
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Apollo Hospital</h6>
                                                        <span class="text-muted">Oct-2006 to Oct-209</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Python</span>
                                                        <span class="badge badge-soft-secondary">Django</span>
                                                    </div>
                                                </div>                                            
                                            </div>
                                            <i class="mdi mdi-book-open-page-variant icon-purple"></i> 
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Stanford Hospitals</h6>
                                                        <span class="text-muted">Oct-2003 to Oct-2006</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                </div>
                                            </div>                                         
                                            <i class="mdi mdi-lead-pencil icon-warning"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Karolinska Hospital</h6>
                                                        <span class="text-muted">Oct-1996 to Oct-2003</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>                                                
                                                </div>
                                            </div>  
                                            <i class="mdi mdi-school icon-success"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Oxford University</h6>
                                                        <span class="text-muted">Oct-2009 to Oct-2011</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Design</span>
                                                        <span class="badge badge-soft-secondary">HTML</span>                                                    
                                                        <span class="badge badge-soft-secondary">Css</span>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="mdi mdi-medal icon-pink"></i>                                                                                                           
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Apollo Hospital</h6>
                                                        <span class="text-muted">Oct-2006 to Oct-209</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                    <div>
                                                        <span class="badge badge-soft-secondary">Python</span>
                                                        <span class="badge badge-soft-secondary">Django</span>
                                                    </div>
                                                </div>                                            
                                            </div>
                                            <i class="mdi mdi-book-open-page-variant icon-purple"></i> 
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Stanford Hospitals</h6>
                                                        <span class="text-muted">Oct-2003 to Oct-2006</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>
                                                </div>
                                            </div>                                         
                                            <i class="mdi mdi-lead-pencil icon-warning"></i>
                                            <div class="time-item">
                                                <div class="item-info">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h6 class="m-0">Karolinska Hospital</h6>
                                                        <span class="text-muted">Oct-1996 to Oct-2003</span>
                                                    </div>
                                                    <p class="text-muted mt-3">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.
                                                        <a href="#" class="text-info">[more info]</a>
                                                    </p>                                                
                                                </div>
                                            </div>     
                                            
                                            </div><!--end activity--> 
 </perfect-scrollbar>
                                      
                                       
                                    </div><div class="slimScrollBar" style="background: rgb(230, 234, 245); width: 7px; position: absolute; top: 0px; opacity: 1; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 316.484px;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div></div><!--end education-activity-->
                                </div>  <!--end card-body-->                                     
                            </div><!--end card-->
                        </div><!--end col-->
</template>

<script>

import { PerfectScrollbar } from 'vue2-perfect-scrollbar';
import { store, mutations } from '../../store/utils/conf';

export default {
    components: {
        PerfectScrollbar
    },
    methods: {
        showModal() {
            mutations.toggleTreatment();
        }
        },
    }
</script> 
<style src="vue2-perfect-scrollbar/dist/vue2-perfect-scrollbar.css"/>
<style>
.ps {
  height: 100%;
}

</style>