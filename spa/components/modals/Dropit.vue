<template>
  <dropzone id="foo" ref="el" :options="options" :destroyDropzone="true"></dropzone>
</template>
<script>
import Dropzone from 'nuxt-dropzone'
import 'nuxt-dropzone/dropzone.css'
 
export default {
    	// module="$store.state.files"
		// moduleName="'attachments'"
    
    props: ['module', 'moduleName'],
  components: {
    Dropzone
  },
  data() {
    return {
      // See https://rowanwins.github.io/vue-dropzone/docs/dist/index.html#/props
      options: {
        "args": {}, 
        "data": "", 
        "files": {}, 
        "form": {}, 
        "headers": {
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9", 
            "Accept-Encoding": "gzip, deflate", 
            "Accept-Language": "en-US,en;q=0.9,ar;q=0.8,fa;q=0.7,ur;q=0.6", 
            // "Host": "httpbin.org", 
            // "Upgrade-Insecure-Requests": "1", 
            // "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36", 
            // "X-Amzn-Trace-Id": "Root=1-5f9e6b89-0d6e2194301633965c9c5e6a"
        }, 
        "json": null, 
        "method": "POST", 
        // "origin": "62.201.232.212", 
        "url": `http://127.0.0.1:8000/api/${this.moduleName}/`
        }
    }
  },
  mounted() {
    // Everything is mounted and you can access the dropzone instance
    const instance = this.$refs.el.dropzone
  }
}
</script>