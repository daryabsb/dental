const testInput = document.getElementById("test_input");
const testAdd = document.getElementById("test_add");
const testContent = document.getElementById("test_content");

testAdd.addEventListener("click", () => {
    //event.preventDefault();
    console.log("clicked")
    addData()
});

const addData = event => {

    testContent.innerHTML += `<li>${testInput.value}</li>`;
    testInput.value = '';

}
var selectedFile;
var fileName;
var fileTarget = document.getElementById('uploaded_files');
var url = '/api/attachments/';
const form = document.getElementById('file-form');
const list = document.getElementById('file_list');

form.addEventListener('click', (event) => {
    event.preventDefault();
    //uploadData(url)
    addfile("/api/attachments/")
});
console.log(fileTarget)
fileTarget.addEventListener("change", chng);

function chng(event) {
    event.preventDefault();
    console.log("changed");
}
const fileSelected = (event) => {
    console.log(fileTarget)
    selectedFile = event.target.files[0]
        //   console.log(this.selectedFile);
    fileName = event.target.files[0].name
        //   console.log(this.fileName);
}
async function addfile() {
    //console.log(selectedFile, fileName)
    let formData = new FormData();
    formData.append('file', { selectedFile, fileName });


    try {
        let result = await fetch(url, {
            method: "post",
            //credentials: "same-origin",
            headers: {

                //"Accept": "application/json",
                "Content-Type": "application/json",
                "X-CSRFToken": csrftoken,
            },
            body: formData
        });
        //  console.log(formData);
        //  console.log("SUCCESS");
        //  console.log(result.json());
    } catch (err) {
        console.log('Cannot access the api!');
        console.log(err);
    }
}






/*function upload() {
console.log('custom JS');

$('#form-upload').submit(function(){
    console.log('SUBMITTED')
   $.ajax({
    url : "/api/attachments/", // the endpoint
    type : "POST", // http method
    data : { the_post : $('#uploaded_file').val() }, // data sent with the post request

    // handle a successful response
    success : function(json) {
        $('#uploaded_file').val(''); // remove the value from the input
        console.log(json); // log the returned json to the console
        console.log("success"); // another sanity check
    },

    // handle a non-successful response
    error : function(xhr,errmsg,err) {
        $('#error').html("<div class='alert-box alert radius' data-alert>Oops! We have encountered an error: "+errmsg+
            " <a href='#' class='close'>&times;</a></div>"); // add the error to the dom
        console.log(xhr.status + ": " + xhr.responseText); // provide a bit more info about the error to the console
    }
});
   
    
    
    
    
    
    
    
    
    //event.preventDefault();
    //console.log("form submitted!")  // sanity check
    //upload();
});





$



    console.log("uploading file is working!") // sanity check
} 

$( "#form-upload" ).submit(function( event ) {
 
    // If .required's value's length is zero
    if ( $( "#uploaded_file" ).val().length === 0 ) {
 
        // Usually show some kind of error message here
 
        // Prevent the form from submitting
        event.preventDefault();
    } else {
        console.log("form submitted!") 
        // Run $.ajax() here
    }
});
*/
// using jQuery
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

// Select your input type file and store it in a variable



// var csrftoken = Cookies.get('csrftoken');
// This will upload the file after having read it

/*form.addEventListener('submit', function(event){
    event.preventDefault();
var url = '/api/attachments/';
    var file = input.value;
    const list = document.getElementById('file_list');
    
  fetch(url, { // Your POST endpoint
    method: "post",
    credentials: "same-origin",
    headers: {
        
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRFToken": csrftoken,
    },
    body: {'file': file}
  }).then(
    response => {
        response.json(); 
        console.log(response); // if the response is a JSON object
        list.innerHTML = `<li>${response.json()}</li>`;
    }
  ).then(success => {console.log(success);} // Handle the success response object
        
    
  ).catch(
    error => console.log(error) // Handle the error response object
  );



});

*/

/*

async function fetchFiles(url) {
    var file = document.getElementById('uploaded_files').value;
    const response = await fetch(url, {
        method: 'POST',
        mode: 'no-cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'same-origin', // include, *same-origin, omit
        headers: {
            //"Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
            "X-CSRFToken": csrftoken
        },
        //redirect: 'follow', // manual, *follow, error
        //referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
        body: JSON.stringify({ 'file': file })
    });
    // waits until the request completes...
    console.log(response.json());
}
/*
async function uploadData(url) {
    // Default options are marked with *
    const input = document.getElementById('uploaded_files');
    var file = document.getElementById('uploaded_files').value;
    const list = document.getElementById('file_list');
    const response = await fetch(url, {
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        //mode: 'cors', // no-cors, *cors, same-origin
        //cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'same-origin', // include, *same-origin, omit
        headers: {

            "Accept": "application/json",
            "Content-Type": "application/json",
            "X-CSRFToken": csrftoken
                // 'Content-Type': 'application/x-www-form-urlencoded',
        },
        //redirect: 'follow', // manual, *follow, error
        //referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
        body: JSON.stringify({ 'file': file }) // body data type must match "Content-Type" header
    });

    return console.log(response.json()); // parses JSON response into native JavaScript objects
}*/




const form = document.getElementById('file-form');
const file = document.getElementById("file");

form.addEventListener("submit", (e) => {
    e.preventDefault();
    let selFile = file.files[0];
    let selName = selFile.name;
    let formData = new FormData();
    formData.append("file",
        selFile, selName);
    //console.log(formData.keys());
    //const data = Array.from(formData)

    //console.log(JSON.stringify(data))
    //console.log(data)
    
	//var formData = new FormData(form);
	
    postData(`/api/attachments/`, formData);
});

// Example POST method implementation:
async function postData(url = '', data) {
    // Default options are marked with *
    try {
        const response = await fetch(url, {
            method: 'POST', // *GET, POST, PUT, DELETE, etc.
            //mode: 'cors', // no-cors, *cors, same-origin
            //cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
            //credentials: 'same-origin', // include, *same-origin, omit
            headers: {
                //"Accept": "application/json",
                // "Content-Type": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
                "X-CSRFToken": csrftoken,
            },
            //redirect: 'follow', // manual, *follow, error
            //referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
            body: data // body data type must match "Content-Type" header
        });
        // console.log(response.json());
        return response; // parses JSON response into native JavaScript objects
    } catch (error) {
        console.log(error)
    }

}

/*postData('https://example.com/answer', { answer: 42 })
.then(data => {
    console.log(data); // JSON data parsed by `data.json()` call
});
*/

var serializeForm = function (form) {
	var obj = {};
	//var formData = new FormData(form);
	for (var key of form.keys()) {
		obj[key] = form.get(key);
	}
	return obj;
};

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