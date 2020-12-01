<template>
<b-row>
    <b-col lg="12">
  <vue-cal :user="user"></vue-cal>
  </b-col>
</b-row>
</template>

<script>
export default {
    props: ['settings', 'user']
}
</script>