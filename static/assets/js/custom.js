console.log('custom JS');


console.log('STARTED');
$('#upload_file').on('submit', function(event) {
    event.preventDefault();
    //console.log("File uploaded ") // sanity check
    upload();
});

function upload() {
    var file = $("#uploaded_file").val();
    //window.location = patientId + '/treatments/create'
    console.log("File uploaded ");
    console.log(file);
    alert(file.filename);

    const file_path = '<input  class="form-control" name="files" value="' + file + '">'

    $("#file_list").prepend(file);
    console.log("success");



}