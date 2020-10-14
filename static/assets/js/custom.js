var app = new Vue({
    delimitters: ["[[", "]]"],
    el: '#app',
    data: {
        message: "Hello World",
        selectedFile: null,
        fileName: '',
        listEl: '',
        fileIds: []

    },
    methods: {
        async uploadFile() {
            //e.preventDefault();
            //alert(this.message);
            try {
                let url = '/api/attachments/'
                const options = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                        "X-CSRFToken": csrftoken
                    }
                };
                let formData = new FormData();
                formData.append("file", this.selectedFile, this.fileName);
                //let res = await axios.get('http://jsonplaceholder.typicode.com/todos');

                let res = await axios.post(url, formData, options);
                console.log(res.data.file)
                this.selectedFile = null;
                this.fileIds.push(res.data.id)
                this.fileName = '';
                this.listEl += `<li>${res.data.file}</li>`
                console.log(this.fileIds)


                console.log(res.data);
            } catch (error) {
                console.log(error);
            }

        },
        onFileSelected(event) {
            this.selectedFile = event.target.files[0]
                //   console.log(this.selectedFile);
            this.fileName = event.target.files[0].name
                //   console.log(this.fileName);

        },
        async onAddProduct() {
            console.log('tags', this.tagID)
            let formData = new FormData()
            formData.append('category', this.categoryID)
            formData.append('tags', this.tagID[0]),
                formData.append('title', this.productTitle),
                formData.append('stock', this.productStock)
            formData.append('price', this.productPrice)
            formData.append('image', this.selectedFile, this.fileName)


            try {
                let result = await this.$axios.$post('/product/products/', formData)
                console.log(formData)
                    // console.log("SUCCESS");
                this.$router.push('/')
            } catch (err) {
                console.log('Cannot access the api!')
                console.log(err)
            }
        }
    }
});

function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie != '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) == (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
var csrftoken = getCookie('csrftoken');
console.log(csrftoken)