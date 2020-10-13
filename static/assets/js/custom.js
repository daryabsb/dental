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

const form = document.getElementById('file-form');
const list = document.getElementById('file_list');

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
var url = '/api/attachments/';
form.addEventListener('submit', uploadData(url));

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
      body: JSON.stringify({'file':file}) // body data type must match "Content-Type" header
    });

    return console.log(response.json()); // parses JSON response into native JavaScript objects
  }
  


    