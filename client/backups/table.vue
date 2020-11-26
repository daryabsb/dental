<template>
  <div>
    <b-table 
    striped 
    hover 
    :items="items" 
    :fields="fields"
    @row-selected="onRowSelected"
    selectable
    select-mode="single"
    >
      <template 
      v-slot:cell(name)="row"
      @click="row.item.edit = true"
      @change="row.item.edit = false"
      
        
      >
        
        <b-form-input v-model="row.item.name" v-if="row.item.edit" />
        <span v-else >{{row.item.name}}</span><!-- <b-form-label v-model="row.item.name" v-else /> -->
      </template>
      <template v-slot:cell(age)="row" v-if="!edit">
        <b-form-input v-model="row.item.age" v-if="row.item.edit" />
        <span v-else >{{row.item.age}}</span>
        <!-- <b-form-input v-model="row.item.age" v-else /> -->
      </template>
      <template v-slot:cell(action)="row">
          <b-button @click="row.item.edit = !row.item.edit">Edit</b-button>
        <!-- <b-form-checkbox v-model="row.item.edit" /> -->
      </template>
    </b-table>
    {{ items }}
  </div>
</template>

<style>
body {
  padding: 1rem;
}
</style>

<script>
export default {
  data() {
    return {
      fields: [ "name", "age", "action" ],
      items: [{ name: "Joe", age: 33, edit: false }, { name: "Sue", age: 77, edit: false }],
      edit: false,
      selected: [],
    };
  },
  methods: {
      onRowSelected(items) {
          console.log(items[0])
        this.selected = items
      },
  },
};
</script>
