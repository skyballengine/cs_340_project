// code for deleteBook function using jQuery
function deleteBook(bookID) {
  let link = '/delete-book-ajax/';
  let data = {
    id: bookID
  };

  $.ajax({
    url: link,
    type: 'DELETE',
    data: JSON.stringify(data),
    contentType: "application/json; charset=utf-8", 
    success: function(result) {
      deleteRow(bookID);
    }
  });
}

//  code for deleteBook using regular javascript/xhttp
// function deleteBook(bookID) {
//     // Put our data we want to send in a javascript object
//     let data = {
//         id: bookID
//     };
    
//     // Setup our AJAX request
//     var xhttp = new XMLHttpRequest();
//     xhttp.open("DELETE", "/delete-book-ajax", true);
//     xhttp.setRequestHeader("Content-type", "application/json");

//     // Tell our AJAX request how to resolve
//     xhttp.onreadystatechange = () => {
//         if (xhttp.readyState == 4 && xhttp.status == 204) {

//             // Add the new data to the table
//             deleteRow(bookID);

//         }
//         else if (xhttp.readyState == 4 && xhttp.status != 204) {
//             console.log("There was an error with the input.")
//         }
//     }
//     // Send the request and wait for the response
//     xhttp.send(JSON.stringify(data));
// }


function deleteRow(bookID){

    let table = document.getElementById("book-table");
    for (let i = 0, row; row = table.rows[i]; i++) {
       //iterate through rows
       //rows would be accessed using the "row" variable assigned in the for loop
       if (table.rows[i].getAttribute("data-value") == bookID) {
            table.deleteRow(i);
            break;
       }
    }
}
