<template>
<div>
  <nav class="horizontal top-border block-section">
    <div class="col-md-20" id="tabs">
      <a v-for="tab in tabs" :key="tab.name" @click="setActiveTabName(tab.name)">
        {{ tab.displayName }}
      </a>
    </div>
  </nav>

  <div v-if="displayContents(activeTabName, 'overview')">
      <!-- <overview></overview> -->
      <h1>Overview</h1>
  </div>
  <div v-if="displayContents(activeTabName, 'about')">
      <!-- <about-company></about-company> -->
      <h1>About Company</h1>
  </div>
  </div>
</template>

<script>
// import Overview from './Overview'
// import AboutCompany from './AboutCompany'

export default {
  components: {
//   Overview,
//   AboutCompany
  },
  data() {
    return {
      // List here all available tabs
      tabs: [
        {
          name: 'overview',
          displayName: 'Company Overview',
        },
        {
          name: 'about',
          displayName: 'About us',
        }
      ],
      activeTabName: null,
    };
  },
  mounted() {
    // The currently active tab, init as the 1st item in the tabs array
    this.activeTabName = this.tabs[0].name;
  },
  methods: {
    setActiveTabName(name) {
      this.activeTabName = name;
    },
    displayContents(name) {
      return this.activeTabName === name;
    },
  },
}
</script>