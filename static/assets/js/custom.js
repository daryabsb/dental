const form = document.getElementById('file-form');
const file = document.getElementById("file");

form.addEventListener("submit", (e) => {
    e.preventDefault();
    //console.log(e);
    let selFile = file.files[0];
    let selName = selFile.name;
    let formData = new FormData(e.target);
    //formData.append("file",selFile, selName);
    //console.log()
    let data = formData
    
	const url = '/api/attachments/';
    postData(url, data);
});

// Example POST method implementation:
async function postData(url = '', data) {
    // Default options are marked with *
    try {
        const response = await fetch(url, {
            method: 'POST', // *GET, POST, PUT, DELETE, etc.
            headers: {
                "Content-Type": "multipart/form-data",
                "X-CSRFToken": csrftoken,
            },
            body : JSON.stringify(data) // body data type must match "Content-Type" header
        });
       
        return response.json(); // parses JSON response into native JavaScript objects
    } catch (error) {
        console.log("BAD REQUEST");
        console.log(error)
    }

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