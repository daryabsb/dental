var patientId = JSON.parse(document.getElementById("patientID").textContent);
var user = JSON.parse(document.getElementById("user").textContent);

var treatAdd = new Vue({
    delimiters: ["[[", "]]"],
    el: '#treatAdd',
    data: {
        message: "Hello World",
        user: user,
        patientID: patientId,
        selectedFile: null,
        fileName: '',
        listEl: '',
        listElLink: '',
        fileId: '',
        listElName: '',
        fileIds: [],
        filelist: [],
        description: '',
        addDescription: '',
        title: 'Treatment Detail'

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
                formData.append("filename", this.fileName);
                formData.append("file", this.selectedFile, this.fileName);
                //let res = await axios.get('http://jsonplaceholder.typicode.com/todos');
                console.log(Array.from(formData))
                let res = await axios.post(url, formData, options);
                let alertElement = `
                <div role="alert" class="alert alert-secondary alert-outline-purple">
                                <button type="button" data-dismiss="alert" aria-label="Close" class="close">
                                    <span aria-hidden="true">
                                        <i class="mdi mdi-close"></i>
                                    </span>
                                </button>
                                <strong>Well done!</strong>
                </div>
                `;


                this.filelist.push(res.data);

                // console.log("From the res: ", res.data.id);
                // console.log(this.fileIds);

                this.fileId = res.data.id;
                this.fileIds.push(this.fileId);
                console.log(this.fileIds)
                    //this.listEl += alertElement;
                this.fileName = '';
                this.selectedFile = null;
            } catch (error) {
                console.log(error);
            }

        },
        onFileSelected(event) {
            console.log('Vue is working!')
            this.selectedFile = event.target.files[0]
                //   console.log(this.selectedFile);
            this.fileName = event.target.files[0].name
                //   console.log(this.fileName);

        },
        async deleteAttached(id) {
            id = parseInt(id);
            console.log('Id is: ', id);
            let indexOfFile = this.fileIds.indexOf(id);
            console.log('Index of Id is: ', indexOfFile);
            const options = {
                headers: {
                    "Content-Type": "multipart/form-data",
                    "X-CSRFToken": csrftoken
                }
            };

            this.fileIds.splice(indexOfFile, 1);

            let url = `http://127.0.0.1:8000/api/attachments/${id}/`;
            console.log(url);
            try {
                await axios.delete(url, options);
            } catch (error) {
                console.log(error);
            }

        },
        onAddDescription(event) {
            console.log(typeof this.fileIds);
            this.description += this.addDescription;
            this.addDescription = '';
            console.log(this.description);
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
                    // console.log(formData)
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