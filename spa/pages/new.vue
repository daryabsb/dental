<template>
  <div>
  <b-navbar  class="topbar-main" toggleable="lg" type="dark" variant="info">
    <div class="topbar-left">
    <b-navbar-brand tag="span">
        <img src="~assets/images/logo-sm-2.png" alt="logo-small" class="logo-sm">
                  
    </b-navbar-brand>
    <b-navbar-brand tag="span">
        <img src="~assets/images/logo-dark-2.png" alt="logo-small" class="logo-sm">
                  
    </b-navbar-brand>
</div>
    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <b-navbar-nav>
        <b-nav-item >Link</b-nav-item>
        <b-nav-item>Disabled</b-nav-item>
      </b-navbar-nav>

      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto">
        <b-nav-form>
          <b-form-input size="sm" class="mr-sm-2" placeholder="Search"></b-form-input>
          <b-button size="sm" class="my-2 my-sm-0" type="submit">Search</b-button>
        </b-nav-form>

        <b-nav-item text="Lang" right>
         
        </b-nav-item>

        <b-nav-item-dropdown left>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em>User</em>
          </template>
        
          
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</div>







</template>

<script>
export default {
    layout: 'new'
}
</script>