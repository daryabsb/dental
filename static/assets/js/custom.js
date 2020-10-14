const form = document.getElementById('file-form');
const file = document.getElementById("file");

form.addEventListener("submit", (e) => {
    e.preventDefault();
    let selFile = file.files[0];
    let selName = selFile.name;
    let formData = new FormData();
    formData.append('file',
        selFile, selName);
    // console.log(formData['file']);
    for (var pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
    }
    postData(`/api/attachments/`, formData);
});

// Example POST method implementation:
async function postData(url = '', data = {}) {
    // Default options are marked with *
    try {
        const response = await fetch(url, {
            method: 'POST', // *GET, POST, PUT, DELETE, etc.
            //mode: 'cors', // no-cors, *cors, same-origin
            //cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
            //credentials: 'same-origin', // include, *same-origin, omit
            headers: {
                //"Accept": "application/json",
                //"Content-Type": "application/json",
                "Content-Type": "multipart/form-data",
                "X-CSRFToken": csrftoken,
            },
            //redirect: 'follow', // manual, *follow, error
            //referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
            body: data // body data type must match "Content-Type" header
        });
        // console.log(response.json());
        return response.json(); // parses JSON response into native JavaScript objects
    } catch (error) {
        console.log(error)
    }

}

/*postData('https://example.com/answer', { answer: 42 })
.then(data => {
    console.log(data); // JSON data parsed by `data.json()` call
});
*/


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