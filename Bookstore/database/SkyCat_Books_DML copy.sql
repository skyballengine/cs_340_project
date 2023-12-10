-- CRUD functionality for database web interface 


-- BOOKS RELATION

-- Create
INSERT INTO Books (
	author,
    title,
    genre,
    num_in_stock,
    price
    )
    VALUES
    (
    :input_author,
    :input_title,
    :input_genre,
    :input_num_in_stock,
    :input_price
    );

-- Read
SELECT * FROM Books;

-- Update
UPDATE Books SET 
	author = :input_author,
    title = :input_title,
    genre = :input_genre,
    num_in_stock = :input_num_in_stock,
    price = :input_price
    WHERE book_id = :input_book_id;
    
-- Delete
DELETE FROM Books WHERE book_id = :input_book_id;



-- CUSTOMERS RELATION

-- Create
INSERT INTO Customers (
	first_name,
    last_name,
    email,
    address
    )
    VALUES 
    (
    :input_first_name,
    :input_last_name,
    :input_email,
    :input_address
    );
    
    -- Read
SELECT * FROM Customers;



-- PAYMENTS RELATION    

-- Create 
INSERT INTO Payments (
	customer_id,
    date,
    credit_card,
    exp_date
    )
    VALUES
    (
    :input_customer_id,
    :input_date,
    :input_credit_card,
    :input_exp_date
    );

-- Read    
SELECT * FROM Payments;

    
-- ORDERS RELATION

-- Create
INSERT INTO Orders (
	customer_id,
    payment_id,
    date,
    total_price
    )
    VALUES
    (
    :input_customer_id,
    :input_payment_id,
    :input_date,
    :input_total_price
    );
    
-- Read
SELECT * FROM Orders;
    
-- Update
UPDATE Orders SET 
	customer_id = :input_customer_id,
    payment_id = :input_payment_id,
    date = :input_date,
    total_price = :input_total_price
    WHERE order_id = :input_order_id;
    

-- ORDERDETAILS RELATION

-- Create
INSERT INTO OrderDetails (
	book_id,
    order_id,
    book_quantity,
    unit_price,
    line_total,
    status
    )
    VALUES
    (
    :input_book_id,
    :input_order_id,
    :input_book_quantity,
    :input_unit_price,
    :input_line_total,
    :input_status
    );
    
-- Read
SELECT * FROM OrderDetails;

