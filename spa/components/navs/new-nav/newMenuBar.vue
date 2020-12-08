<template>
<b-container fluid variant="primary" class="navbar-custom-menu">
  <b-navbar class="container-fluid" toggleable="lg" type="dark">
    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
    <b-collapse id="nav-collapse" is-nav>
      <b-navbar-nav>
        <b-nav-item class="mr-3" to="/">
          <i class="dripicons-meter"></i> DASHBOARD</b-nav-item>
        <b-nav-item class="mr-3" to="/patients" >
          <i class="dripicons-user-group"></i> PATIENTS</b-nav-item>
          <b-nav-item class="mr-3" to="/treatments" >
          <i class="dripicons-clipboard"></i> TREATMENTS</b-nav-item>
          <b-nav-item class="mr-3" to="/appointments" >
          <i class="mdi mdi-account-clock"></i> VISITS</b-nav-item>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</b-container>
</template>