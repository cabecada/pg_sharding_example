CREATE TABLE stocks_history (
stock_id int,
stock_price int,
stock_currency character(500),
at timestamp with time zone 
);

ALTER TABLE stocks_history ADD primary key(at,stock_id);


CREATE TABLE stocks (
stock_id int primary key,
stock_name text,
stock_desc text
);

CREATE TABLE customer (
cust_id int primary key,
cust_name text,
cust_desc text
);
	
CREATE TABLE payment_history (
payment_id int,
cust_id int,
stock_id int,
status character(500),
at timestamp with time zone
);

ALTER TABLE payment_history ADD primary key(at,payment_id,stock_id);

