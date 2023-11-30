
// Get the objects we need to modify
let updatebookForm = document.getElementById('update-book-form-ajax');

// Modify the objects we need
updatebookForm.addEventListener("submit", function (e) {
   
    // Prevent the form from submitting
    e.preventDefault();

    // Get form fields we need to get data from
    let inputcombo = document.getElementById("mySelect");
    let inputnum_in_stock = document.getElementById("input-num_in_stock-update");

    // Get the values from the form fields
    let comboValue = inputcombo.value;
    let num_in_stockValue = inputnum_in_stock.value;
    
    // currently the database table for bsg_people does not allow updating values to NULL
    // so we must abort if being bassed NULL for num_in_stock

    if (isNaN(num_in_stockValue)) 
    {
        return;
    }


    // Put our data we want to send in a javascript object
    let data = {
        combo: comboValue,
        num_in_stock: num_in_stockValue,
    }
    
    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("PUT", "/put-book-ajax", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 200) {

            // Add the new data to the table
            updateRow(xhttp.response, comboValue);

        }
        else if (xhttp.readyState == 4 && xhttp.status != 200) {
            console.log("There was an error with the input.")
        }
    }

    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));

})


function updateRow(data, bookID){
    let parsedData = JSON.parse(data);
    
    let table = document.getElementById("people-table");

    for (let i = 0, row; row = table.rows[i]; i++) {
       //iterate through rows
       //rows would be accessed using the "row" variable assigned in the for loop
       if (table.rows[i].getAttribute("data-value") == bookID) {

            // Get the location of the row where we found the matching book ID
            let updateRowIndex = table.getElementsByTagName("tr")[i];

            // Get td of num_in_stock value
            let td = updateRowIndex.getElementsByTagName("td")[5];

            // Reassign num_in_stock to our value we updated to
            td.innerHTML = parsedData[0].name; 
       }
    }
}


