insert into Books (author, title, genre, num_in_stock, price)
values 
(
    "Michael J. Sullian",
    "Theft of Swords",
    "Fantasy",
    "4",
    "18.99"
),
(
    "Branden Sanderson",
    "The Way of Kings",
    "Fantasy",
    "5",
    "24.99"
),
(
    "Charlotte Brontë",
    "Jane Eyre",
    "Romance",
    "6",
    "14.99"
),
(
    "J.R.R. Tolkien",
    "The Hobbit",
    "Fantasy",
    "3",
    "23.99"
),
(
    "G. Polya",
    "How To Solve It",
    "Mathematics",
    "6",
    "17.99"
);

insert into Customers (first_name, last_name, email, address)
values 
(
    "Sally",
    "McRae",
    "smcrae@hello.com",
    "1234 st Bend, OR. 30092"
),
(
    "Bo",
    "Chan'g",
    "bochang@hello.com",
    "545 Ave Portland,  OR.  40092"
),
(
    "Bob",
    "Smith",
    "ssmith@hello.com",
    "4321 st Hood River, OR.  50092"
),
(
    "Miguel",
    "Cabrera",
    "mc@hello.com",
    "2024 st Corona, CA.  92882"
),

(
    "Willy",
    "Thomas",
    "willtom@hello.com",
    "2349 aster ave. Someville, PA 17773"
);

insert into OrderDetails (book_id, order_id, book_quantity, unit_price, line_total, status)
values
(
    "1",
    "1",
    "1",
    "18.99",
    (select unit_price * book_quantity),
    "0"
),
(
    "4",
    "2",
    "2",
    "23.99",
   (select unit_price * book_quantity),
    "1"
),
(
    "2",
    "3",
    "1",
    "24.99",
    (select unit_price * book_quantity),
    "0"
),
(
    "1",
    "3",
    "1",
    "18.99",
    (select unit_price * book_quantity),
    "1"
),
(
    "3",
    "3",
    "1",
    "14.99",
    (select unit_price * book_quantity),
    "1"
);

insert into Payments (date, credit_card, exp_date, customer_id)
values
(
    "2008-04-08",
    "1234567890122345",
    "9/2029",
    (select customer_id from Customers where first_name = "Miguel" and last_name = "Cabrera")
),
(
    "2008-04-09",
    "4284652697294202",
    "9/2029",
    (select customer_id from Customers where first_name = "Bob" and last_name = "Smith")
),
(
    "2008-04-10",
    "5241331426663057",
    "8/2027",
    (select customer_id from Customers where first_name = "Willy" and last_name = "Thomas")
),
(
    "2008-04-11",
    "4556204748319454",
    "11/2023",
    (select customer_id from Customers where first_name = "Willy" and last_name = "Thomas")
);

insert into Orders (date, customer_id, payment_id, total_price)
values
(
    "2008-04-09",
    (select customer_id from Customers where first_name = "Miguel" and last_name = "Cabrera"),
    (select payment_id from Payments where payment_id = "1"),
    "1112.23"
	
),
(
    "2008-04-09",
    (select customer_id from Customers where first_name = "Bob" and last_name = "Smith"),
    (select payment_id from Payments where payment_id = "2"),
    "12.23"
),
(
    "2008-04-10",
    (select customer_id from Customers where first_name = "Willy" and last_name = "Thomas"),
    (select payment_id from Payments where payment_id = "3"),
    "13.23"
),
(
    "2008-04-10",
    (select customer_id from Customers where first_name = "Willy" and last_name = "Thomas"),
    (select payment_id from Payments where payment_id = "4"),
    "9992.00"
);