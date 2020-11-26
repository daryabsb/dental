<template>
      <carousel 
      :per-page="1" 
      :mouse-drag="true"
      :navigationEnabled="true"
      :centerMode="true"
      :paginationColor="'#EFA291'"
      >
    <slide>
      slide 1
    </slide>
    <slide>
      Slide 2 Content
    </slide>
    <slide>
      Slide 4 Content
    </slide>
    <slide>
      Slide 5 Content
    </slide>
  </carousel>
</template>

<script>
  export default {
    
    data() {
      return {
        data: [
          '<div class="example-slide">Slide 1</div>',
          '<div class="example-slide">Slide 2</div>',
          '<div class="example-slide">Slide 3</div>',
        ],
      };
    },
  };
</script>