$(document).ready(function() {
    $.ajax({
        type: "GET",
        url: "file:///Users/patrickli/Desktop/code_fun/csv_frontend/crime.csv",
        dataType: "csv",
        success: function(data) {
          debugger
        }
     });
});

// $(document).ready(function () {
//     $.ajax({
//         type: "GET",
//         url: "D:\Docs\Desktop\csvfile.csv",
//         dataType: "csv",
//         success: function (data) { processData(data); }
//     });
// });
