<template>
<div>
<b-navbar toggleable="lg" type="light" variant="default">
    <b-navbar-brand href="#">NavBar</b-navbar-brand>

    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
       <b-nav-form>
          <b-form-input size="sm" class="mr-sm-2" placeholder="Search"></b-form-input>
          <b-button size="sm" class="my-2 my-sm-0" type="submit">Search</b-button>
        </b-nav-form>


      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto">
       

        <b-nav-item-dropdown text="Lang" right>
          <b-dropdown-item href="#">EN</b-dropdown-item>
          <b-dropdown-item href="#">ES</b-dropdown-item>
          <b-dropdown-item href="#">RU</b-dropdown-item>
          <b-dropdown-item href="#">FA</b-dropdown-item>
        </b-nav-item-dropdown>

        <b-nav-item-dropdown right>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em>User</em>
          </template>
          <b-dropdown-item href="#">Profile</b-dropdown-item>
          <b-dropdown-item href="#">Sign Out</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>


    <b-navbar toggleable="lg" type="dark" variant="primary">
    <b-navbar-brand href="#">NavBar</b-navbar-brand>

    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <b-navbar-nav>
        <b-nav-item href="#"><a href="/patients" class=""><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 92 92" class="nav-svg mr-1"><path id="XMLID_1197_" d="M90.8,22.9C90.1,22.2,89.1,22,88,22H67V10c0-2.2-2-4-4.2-4H29.2C27,6,25,7.8,25,10v12H4
                                        c-2.2,0-4,1.3-4,3.5V82c0,2.2,1.8,4,4,4h84c2.2,0,4-1.8,4-4l0-56.3C92,24.6,91.6,23.7,90.8,22.9z M33,14h26v8H33V14z M84,78H8V30h76
                                        L84,78z" class="svg-primary"></path> <path d=" M29.7,53.5c0-1.9,1.6-3.5,3.5-3.5H42v-8.9c0-1.9,1.6-3.5,3.5-3.5s3.5,1.6,3.5,3.5V50h9.8c1.9,0,3.5,1.6,3.5,3.5
                                        S60.7,57,58.8,57H49v9.4c0,1.9-1.6,3.5-3.5,3.5S42,68.4,42,66.4V57h-8.8C31.3,57,29.7,55.4,29.7,53.5z"></path></svg> <span>Patients</span></a></b-nav-item>
        <b-nav-item href="#" disabled>Disabled</b-nav-item>
      </b-navbar-nav>

      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto">
        <b-nav-form>
          <b-form-input size="sm" class="mr-sm-2" placeholder="Search"></b-form-input>
          <b-button size="sm" class="my-2 my-sm-0" type="submit">Search</b-button>
        </b-nav-form>

        <b-nav-item-dropdown text="Lang" right>
          <b-dropdown-item href="#">EN</b-dropdown-item>
          <b-dropdown-item href="#">ES</b-dropdown-item>
          <b-dropdown-item href="#">RU</b-dropdown-item>
          <b-dropdown-item href="#">FA</b-dropdown-item>
        </b-nav-item-dropdown>

        <b-nav-item-dropdown right>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em>User</em>
          </template>
          <b-dropdown-item href="#">Profile</b-dropdown-item>
          <b-dropdown-item href="#">Sign Out</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
  </div>
</template>