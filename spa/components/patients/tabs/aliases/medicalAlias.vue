<template>
  <b-list-group>
    <b-list-group-item class="d-flex justify-content-between align-items-center" :variant="getVariant(medicals.physical_restrictions)"

      >Physical Restrictions
      <b-badge :variant="getVariant(medicals.physical_restrictions)">{{ medicals.physical_restrictions }} </b-badge>
    </b-list-group-item>
    <b-list-group-item class="d-flex justify-content-between align-items-center"  :variant="getVariant(medicals.heart_problem)"
      >Heart Problem
      <b-badge :variant="getVariant(medicals.heart_problem)">{{ medicals.heart_problem }} </b-badge>
    </b-list-group-item>
    <b-list-group-item class="d-flex justify-content-between align-items-center" :variant="getVariant(medicals.diabetes)"
      >Diabetes
      <b-badge :variant="getVariant(medicals.diabetes)">{{ medicals.diabetes }} </b-badge>
    </b-list-group-item>
    <b-list-group-item class="d-flex justify-content-between align-items-center" :variant="getVariant(medicals.sinus_infections)"
      >Sinus Infections
      <b-badge :variant="getVariant(medicals.sinus_infections)">{{ medicals.sinus_infections }} </b-badge>
    </b-list-group-item>
    <b-list-group-item class="d-flex justify-content-between align-items-center" :variant="getVariant(medicals.kidney_illness)"
      >Kidney Illness
      <b-badge :variant="getVariant(medicals.kidney_illness)">{{ medicals.kidney_illness }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center" :variant="getVariant(medicals.emotional_difficulties)"
      >Emotional Difficulties
      <b-badge :variant="getVariant(medicals.emotional_difficulties)">{{ medicals.emotional_difficulties }} </b-badge>
    </b-list-group-item>
  </b-list-group>
</template>
<script>
export default {
  props: ["medicals"],
  methods: {
    getVariant(n) {
      if (n>=95) {
        return 'success';
      } else if (n>=75) {
        return 'primary';
      } else if (n>=50) {
        return 'secondary';
      } 
        return 'danger';
    }
  }
};
</script>