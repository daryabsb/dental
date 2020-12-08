<template>
<b-container>
  <b-navbar toggleable="sm" type="light" variant="white">
      <template>
    <div class="topbar-left">
      <b-navbar-brand tag="span">
        <img
          src="~assets/images/logo-sm-2.png"
          alt="logo-small"
          class="logo-custom logo-sm"
        />
      </b-navbar-brand>
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
      <ul class="list-unstyled topbar-nav mb-3">
        <li class="hide-phone app-search">
          <form role="search" class="">
            <input type="text" placeholder="Search..." class="form-control" />
            <a href=""><i class="fas fa-search"></i></a>
          </form>
        </li>
      </ul>
      </template>
      <!--end topbar-nav-->
    </b-navbar-nav>
    
      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto">
        <b-nav-item-dropdown left>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em>User</em>
          </template>
        </b-nav-item-dropdown>
        <b-nav-item-dropdown
          ref="dropdown-user"
          class="ml-3"
          variant="light"
          id="my-nav-dropdown"
          text="User"
          toggle-class="nav-link-custom"
          right
        >
        <template #button-content>
            <a class="nav-link dropdown-toggle waves-effect waves-light nav-userpr-0">
          <img src="~assets/images/users/user-41.jpg" alt="profile-user" class="rounded-circle" /> 
          <span class="ml-1 nav-user-name hidden-sm">{{$auth.user.name}}</span>
            </a>
        </template>
        





        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
  </b-container>
</template>

<script>
export default {
  layout: "new",
  methods: {
    closeMenu() {
      this.$refs.dropdownUser.toggle();
    },
  },
};
</script>

