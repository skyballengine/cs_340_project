// App.js

/*
    SETUP
*/
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
PORT        = 9120;                 // Set a port number at the top so it's easy to change in the future

// app.js
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.

// Database
var db = require('./database/db-connector')

// app.js - SETUP section
app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(express.static(__dirname + '/public'));         // this is needed to allow for the form to use the ccs style sheet/javscript
    

// app.js

app.get('/', function(req, res)
    {
        let query1 = "SELECT * FROM Books;";
        db.pool.query(query1, function(error, rows, fields){
            res.render('index', {data: rows});
        })
    });
    
app.get('/Customers', function(req, res)
{
    let query1 = "SELECT * FROM Customers;";
    db.pool.query(query1, function(error, rows, fields){
        res.render('Customers', {data: rows});
    })
});

app.get('/OrderDetails', function(req, res)
{
    let query3 = "SELECT * FROM OrderDetails;";
    db.pool.query(query3, function(error, rows, fields){
        res.render('OrderDetails', {data: rows});
    })
});

app.get('/Orders', function(req, res)
{
    let query4 = "SELECT * FROM Orders;";
    db.pool.query(query4, function(error, rows, fields){
        res.render('Orders', {data: rows});
    })
});

app.get('/Payments', function(req, res)
{
    let query5 = "SELECT * FROM Payments;";
    db.pool.query(query5, function(error, rows, fields){
        res.render('Payments', {data: rows});
    })
});

// app.get('/', function(req, res)
// {
//     // Declare Query 1
//     let query1;

//     // If there is no query string, we just perform a basic SELECT
//     if (req.query.lname === undefined)
//     {
//         query1 = "SELECT * FROM Books;";
//     }

//     // If there is a query string, we assume this is a search, and return desired results
//     else
//     {
//         query1 = `SELECT * FROM bsg_people WHERE lname LIKE "${req.query.lname}%"`
//     }

//     // Query 2 is the same in both cases
//     let query2 = "SELECT * FROM bsg_planets;";

//     // Run the 1st query
//     db.pool.query(query1, function(error, rows, fields){
        
//         // Save the people
//         let people = rows;
        
//         // Run the second query
//         db.pool.query(query2, (error, rows, fields) => {
            
//             // Save the planets
//             let planets = rows;

//             // BEGINNING OF NEW CODE

//             // Construct an object for reference in the table
//             // Array.map is awesome for doing something with each
//             // element of an array.
//             let planetmap = {}
//             planets.map(planet => {
//                 let id = parseInt(planet.id, 10);

//                 planetmap[id] = planet["name"];
//             })

//             // Overwrite the homeworld ID with the name of the planet in the people object
//             people = people.map(book => {
//                 return Object.assign(book, {homeworld: planetmap[book.homeworld]})
//             })

//             // END OF NEW CODE
//             return res.render('index', {data: people, planets: planets});
//         })
//     })
// });


app.post('/add-book-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    // Create the query and run it on the database
    query1 = `INSERT INTO Books (author, title, genre, num_in_stock, price) VALUES ('${data['input-author']}', '${data['input-title']}', '${data['input-genre']}', ${data['input-num_in_stock']}, ${data['input-price']})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else
        {
            res.redirect('/');
        }
    })
})

app.post('/add-customer-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    // Create the query and run it on the database
    query1 = `INSERT INTO Customers (first_name, last_name, email, address) VALUES ("${data["input-first_name"]}", "${data["input-last_name"]}", "${data["input-email"]}", "${data["input-address"]}")`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else
        {
            res.redirect('/Customers');
        }
    })
})

app.post('/add-order-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    // Create the query and run it on the database
    query1 = `INSERT INTO Orders (customer_id, payment_id, date, total_due) VALUES ('${data['input-customerid']}', '${data['input-paymentid']}', '${data['input-date']}', ${data['input-totaldue']})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else
        {
            res.redirect('/Orders');
        }
    })
})

app.post('/add-od-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    // Create the query and run it on the database
    
    query1 = `INSERT INTO OrderDetails (book_id,
        order_id,
        book_quantity,
        unit_price,
        line_total, status)
         VALUES
          ('${data['input-bookid']}', '${data['input-orderid']}', '${data['input-bookquant']}', ${data['input-unit_price']},
          ${data['input-line_total']},
          ${data['input-shipped']})`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else
        {
            res.redirect('/OrderDetails');
        }
    })
})

app.post('/add-payment-form', function(req, res){
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    // Create the query and run it on the database
    query1 = `INSERT INTO Payments (Customers_customer_id, date, credit_card, exp_date) VALUES ("${data["input-customerid"]}", "${data["input-date"]}", "${data["input-cc"]}", "${data["input-exp"]}")`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error)
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM bsg_people and
        // presents it on the screen
        else
        {
            res.redirect('/Payments');
        }
    })
})


app.delete('/delete-book-ajax/', function(req,res,next){                                                                
  let data = req.body;
  let bookID = parseInt(data.id);
  let deleteOrderDetails = `DELETE FROM OrderDetails WHERE book_id = ?`;
  let deleteBook= `DELETE FROM Books WHERE book_id = ?`;


        // Run the 1st query
        db.pool.query(deleteBook, [bookID], function(error, rows, fields){
            if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
            }

            else
            {
                res.sendStatus(204)
            }
})});


app.put('/put-book-ajax', function(req,res,next){                                   
  let data = req.body;

  let num_in_stock = parseInt(data.num_in_stock);
  let book = parseInt(data.combo);

  queryUpdateWorld = `UPDATE Books SET num_in_stock = ? WHERE Books.book_id = ?`;
  selectWorld = `SELECT * FROM Books WHERE book_id = ?`

        // Run the 1st query
        db.pool.query(queryUpdateWorld, [num_in_stock, book], function(error, rows, fields){
            if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
            }

            // If there was no error, we run our second query and return that data so we can use it to update the people's
            // table on the front-end
            else
            {
                // Run the second query
                db.pool.query(selectWorld, [num_in_stock], function(error, rows, fields) {
        
                    if (error) {
                        console.log(error);
                        res.sendStatus(400);
                    } else {
                        res.send(rows);
                    }
                })
            }
})});



/*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});