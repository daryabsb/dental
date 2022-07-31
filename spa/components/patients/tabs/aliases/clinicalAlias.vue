<template>
  <b-list-group>
    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Treatment Plan
      <b-badge variant="primary">{{ examinations.treatment_plan }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Skeletal Class
      <b-badge variant="primary">{{ examinations.skeletal_class }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Nasolabial Angle
      <b-badge variant="primary">{{ examinations.nasolabial_angle }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Nasolabial Sulcus
      <b-badge variant="primary">{{ examinations.nasolabial_sulcus }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Lip Competency
      <b-badge variant="primary">{{ examinations.lip_competency }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Face Form
      <b-badge variant="primary">{{ examinations.face_form }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Molar Class Left
      <b-badge variant="primary">{{ examinations.molar_class_left }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Molar Class Left
      <b-badge variant="primary">{{ examinations.molar_class_right }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Midline Upper
      <b-badge variant="primary">{{ examinations.midline_upper }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Midline Lower
      <b-badge variant="primary">{{ examinations.midline_lower }} </b-badge>
    </b-list-group-item>
    
    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Overjet
      <b-badge variant="primary">{{ examinations.overjet }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Oral Hygiene
      <b-badge variant="primary">{{ examinations.oral_hygiene }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Treated Arch
      <b-badge variant="primary">{{ examinations.treated_arch }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Treated Arch
      <b-badge variant="primary">{{ examinations.treated_arch }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Slot
      <b-badge variant="primary">{{ examinations.slot }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Bracket System
      <b-badge variant="primary">{{ examinations.bracket_system }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Extraction Upper
      <b-badge variant="primary">{{ examinations.extraction_upper }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Extraction Lower
      <b-badge variant="primary">{{ examinations.extraction_lower }} </b-badge>
    </b-list-group-item>

    <b-list-group-item class="d-flex justify-content-between align-items-center"
      >Anchorage Upper
      <b-badge variant="primary">{{ examinations.anchorage_upper }} </b-badge>
    </b-list-group-item>
  </b-list-group>
</template>
<script>
export default {
  props: ["examinations"],
};
</script>