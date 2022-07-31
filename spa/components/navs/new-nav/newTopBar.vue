<template>
<b-container>
  <b-navbar toggleable="sm" type="light" variant="white">
      <template>
    <div class="topbar-left">
	<nuxt-link to="/">
      <b-navbar-brand tag="span">
        <img
          src="~assets/images/logo-sm-2.png"
          alt="logo-small"
          class="logo-custom logo-sm"
        />
      </b-navbar-brand>
	</nuxt-link>
      <b-navbar-brand tag="span" class="mr-8">
        <img
          src="~assets/images/logo-dark-2.png"
          alt="logo-small"
          class="logo-custom logo-sm"
        />
      </b-navbar-brand>
    </div>
    </template>
    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
    <b-collapse id="nav-collapse" is-nav>
    <b-navbar-nav class="text-center">
        <template>
      <!-- <ul class="list-unstyled topbar-nav mb-3">
        <li class="hide-phone app-search">
          <form role="search" class="">
            <input type="text" placeholder="Search..." class="form-control" />
            <a href=""><i class="fas fa-search"></i></a>
          </form>
        </li>
      </ul> -->
      </template>
      <!--end topbar-nav-->

    </b-navbar-nav >
    
      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto" v-if="isAuthenticated">        
        <b-nav-item-dropdown
          ref="dropdown-user"
          toggle-class="nav-link-custom"
          right
        >
        <template slot="button-content">
            <a class="waves-effect waves-light nav-user pr-0">
              <img src="~assets/images/users/user-41.jpg" alt="profile-user" class="rounded-circle" /> 
              <span class="ml-1 nav-user-name hidden-sm">{{$auth.user.name}}</span>
              </a>
            </template>

            <b-dropdown-item :to="`/users/${$auth.user.id}`">Profile</b-dropdown-item>
            <b-dropdown-item @click="$auth.logout()" >Sign Out</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>

      <b-navbar-nav v-else>
        <b-nav-item to="/login">login</b-nav-item>
      </b-navbar-nav>

    </b-collapse>
  </b-navbar>
  </b-container>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {

  layout: "new",
  methods: {
    closeMenu() {
      this.$refs.dropdownUser.toggle();
    },
  },
  computed: {
    ...mapGetters(['isAuthenticated', 'loggedInUser', 'counter', 'alertMsg', 'alertStatus'])
  }
};
</script>
