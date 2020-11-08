<template>
  <!-- Top Bar Start -->
        <div class="topbar">
            
            <!-- Navbar -->
            <nav class="topbar-main">  
                <!-- LOGO -->
                <div class="topbar-left">
                    <a href="../projects/projects-index.html" class="logo">
                        <span>
                            <img src="~assets/images/logo-sm-2.png" alt="logo-small" class="logo-sm">
                        </span>
                        <span>
                            <img src="~assets/images/logo-dark-2.png" alt="logo-large" class="logo-lg">
                        </span>
                    </a>
                </div><!--topbar-left-->


                <!--end logo-->
                <ul class="list-unstyled topbar-nav float-right mb-0" v-if="isAuthenticated"> 
                    <!-- li LANGUAGE
                    <li @click="showLanguages" class="hidden-sm">
                        <a class="nav-link dropdown-toggle waves-effect waves-light" data-toggle="dropdown" href="javascript: void(0);" role="button"
                            aria-haspopup="false" aria-expanded="false">
                            English <img src="~assets/images/flags/us_flag.jpg" class="ml-2" height="16" alt=""/> <i class="mdi mdi-chevron-down"></i> 
                        </a>
                        <LanguagesNav />
                    </li> end of language -->

                    <li @click="showNotifications" class="dropdown notification-list">
                        <a class="nav-link dropdown-toggle arrow-none waves-light waves-effect">
                            <i class="dripicons-bell noti-icon"></i>
                            <span class="badge badge-danger badge-pill noti-icon-badge">{{$store.state.appointments.length}}</span>
                        </a>
                        <NotificationNav />
                    </li> <!--end notification-list-->

                    <li class="dropdown">
                        <a @click="showMenu" class="nav-link dropdown-toggle waves-effect waves-light nav-user pr-0">
                            <img src="~assets/images/users/user-41.jpg" alt="profile-user" class="rounded-circle" /> 
                            <span class="ml-1 nav-user-name hidden-sm">{{$auth.user.name}} <i class="mdi mdi-chevron-down"></i> </span>
                        </a>
<UserMenu />
                    
                    </li><!--end dropdown-->
                    <li class="menu-item">
                        <!-- Mobile menu toggle-->
                        <a class="navbar-toggle nav-link" id="mobileToggle">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </a>
                        <!-- End mobile menu toggle-->
                    </li> <!--end menu item-->   
                </ul><!--end topbar-nav-->
                <ul class="list-unstyled topbar-nav float-right mb-0" v-else>
                    <li class="hidden-sm">
                        <a class="nav-link dropdown-toggle waves-effect waves-light" data-toggle="dropdown" href="/login" role="button"
                            aria-haspopup="false" aria-expanded="false">
                            Login <i class="fas fa-sign-in-alt ml-1"></i> 
                        </a>
                    </li><!--end li-->
                </ul>
    
                <ul class="list-unstyled topbar-nav mb-0">
                    <li class="hide-phone app-search">
                        <form role="search" class="">
                            <input type="text" placeholder="Search..." class="form-control">
                            <a href=""><i class="fas fa-search"></i></a>
                        </form>
                    </li>
                </ul><!--end topbar-nav-->
            </nav>



            <!-- end navbar-->
             <!-- MENU Start -->
            <div class="navbar-custom-menu">
                <div class="container-fluid">
                    <div id="navigation">
                         <!-- Navigation Menu-->
                    <ul class="navigation-menu">
                        <li>
                            <nuxt-link to="/">
                                <svg class="nav-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                        <path class="svg-primary" d="M239.208 343.937c-17.78 10.103-38.342 15.876-60.255 15.876-21.909 0-42.467-5.771-60.246-15.87C71.544 358.331 42.643 406 32 448h293.912c-10.639-42-39.537-89.683-86.704-104.063zM178.953 120.035c-58.479 0-105.886 47.394-105.886 105.858 0 58.464 47.407 105.857 105.886 105.857s105.886-47.394 105.886-105.857c0-58.464-47.408-105.858-105.886-105.858zm0 186.488c-33.671 0-62.445-22.513-73.997-50.523H252.95c-11.554 28.011-40.326 50.523-73.997 50.523z"/>
                                        <g>
                                            <path d="M322.602 384H480c-10.638-42-39.537-81.691-86.703-96.072-17.781 10.104-38.343 15.873-60.256 15.873-14.823 0-29.024-2.654-42.168-7.49-7.445 12.47-16.927 25.592-27.974 34.906C289.245 341.354 309.146 364 322.602 384zM306.545 200h100.493c-11.554 28-40.327 50.293-73.997 50.293-8.875 0-17.404-1.692-25.375-4.51a128.411 128.411 0 0 1-6.52 25.118c10.066 3.174 20.779 4.862 31.895 4.862 58.479 0 105.886-47.41 105.886-105.872 0-58.465-47.407-105.866-105.886-105.866-37.49 0-70.427 19.703-89.243 49.09C275.607 131.383 298.961 163 306.545 200z"/>
                                        </g>
                                    </svg>
                                <span>Dashboard</span>
                            </nuxt-link>

                        </li>
                        <li class="has-submenu">
                            <nuxt-link to="/patients">
                                <svg class="nav-svg mr-1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 92 92">
                                        <path class="svg-primary" id="XMLID_1197_" d="M90.8,22.9C90.1,22.2,89.1,22,88,22H67V10c0-2.2-2-4-4.2-4H29.2C27,6,25,7.8,25,10v12H4
                                        c-2.2,0-4,1.3-4,3.5V82c0,2.2,1.8,4,4,4h84c2.2,0,4-1.8,4-4l0-56.3C92,24.6,91.6,23.7,90.8,22.9z M33,14h26v8H33V14z M84,78H8V30h76
                                        L84,78z"></path>
                                        <path d=" M29.7,53.5c0-1.9,1.6-3.5,3.5-3.5H42v-8.9c0-1.9,1.6-3.5,3.5-3.5s3.5,1.6,3.5,3.5V50h9.8c1.9,0,3.5,1.6,3.5,3.5
                                        S60.7,57,58.8,57H49v9.4c0,1.9-1.6,3.5-3.5,3.5S42,68.4,42,66.4V57h-8.8C31.3,57,29.7,55.4,29.7,53.5z"></path>
                                    </svg>
                                <span>Patients</span>
                            </nuxt-link>
                            <ul class="submenu">
                                <li><nuxt-link to="/patients/"><i class="dripicons-meter"></i>All Patients</nuxt-link></li>
                                <li>


                                    <a @click="showModal()">
                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Patient</a>


                                </li>
                                <!-- ADD NEW PATIENT MODAL -->
                                <AddPatient />
                                <!--end has-submenu-->
                            </ul>
                            <!--end submenu-->


                        </li>
                        <!--end has-submenu-->

                        <li class="has-submenu">
                            <nuxt-link to="/treatments"><i class="dripicons-clipboard"></i>Treatments</nuxt-link>
                            <ul class="submenu">

                                <li><nuxt-link to="/treatments"><i class="dripicons-meter"></i>All Treatments</nuxt-link></li>
                                <li>
                                    <a @click="showTreatmentModal">
                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New Treatment</a>
                                </li>
                            </ul>
                            <!--end submenu-->
                        </li>
                        <!--end has-submenu-->

                        <li class="has-submenu">
                            <nuxt-link to="/appointments"><i class="dripicons-clipboard"></i>Appointments</nuxt-link>
                            <ul class="submenu">

                                <li><nuxt-link to="/appointments"><i class="dripicons-meter"></i>All Appointments</nuxt-link></li>
                                <li>
                                    <a data-toggle="modal" data-animation="bounce" data-target=".appointment_create">
                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New User</a>
                                </li>
                            </ul>
                            <!--end submenu-->
                        </li>
                        <!--end has-submenu-->

                        <li class="has-submenu">
                            <nuxt-link to="/users"><i class="dripicons-clipboard"></i>Users</nuxt-link>
                            <ul class="submenu">

                                <li><nuxt-link to="/users"><i class="dripicons-meter"></i>All Users</nuxt-link></li>
                                <li>
                                    <a data-toggle="modal" data-animation="bounce" data-target=".appointment_create">
                                        <i class="mdi mdi-plus-circle-outline mr-2"></i>Add New User</a>
                                </li>
                            </ul>
                            <!--end submenu-->
                        </li>
                        <!--end has-submenu-->

                    </ul>
                    <!-- End navigation menu -->
                    </div> <!-- end navigation -->
                </div> <!-- end container-fluid -->
            </div> <!-- end navbar-custom -->
        </div>
        <!-- Top Bar End -->

</template>

<script>
import { mapGetters } from 'vuex'
import { store, mutations } from '../../store/utils/conf'

export default {
    data(){
        return {
            //showMenu: false,
            
        }
    },
    methods: {
        
    showModal() {
            mutations.toggleAddPatientModal();
        
      },
      showTreatmentModal() {
          mutations.toggleSelectPatientModal();
      },
      showMenu() {
          mutations.toggleUserNav();
      },
      showNotifications() {
          mutations.toggleNotification();
      },
      showLanguages() {
          mutations.toggleLanguages();
      }
    
        },
  computed: {
      isUserNavOpen() {
          return store.isUserNavOpen
      },
      isNotificationOpen() {
          return store.isNotificationOpen
      },
      isAddPatientModalOpen(){
            return store.isAddPatientModalOpen
        },
    ...mapGetters(['isAuthenticated', 'loggedInUser'])
  }
}
</script>