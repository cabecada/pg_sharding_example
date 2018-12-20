
CREATE TABLE stocks_history (
stock_id int,
stock_price int,
stock_currency character(500),
at timestamp with time zone
) PARTITION BY RANGE (at) ;

ALTER TABLE stocks_history ADD primary key(at,stock_id);

CREATE TABLE stocks_history_y2018m05 PARTITION OF stocks_history ( stock_currency DEFAULT 'Rupees' ) FOR VALUES FROM ('2018-05-01 00:00:00') TO ('2018-06-01 00:00:00') WITH (fillfactor='100');


CREATE TABLE stocks (
stock_id int primary key,
stock_name text,
stock_desc text
) PARTITION BY RANGE (stock_id) ;

CREATE TABLE stocks1 PARTITION OF stocks FOR VALUES FROM (1) TO (11) WITH (fillfactor='100');


CREATE TABLE customer (
cust_id int primary key,
cust_name text,
cust_desc text
) PARTITION BY RANGE (cust_id) ;

CREATE TABLE customer1 PARTITION OF customer FOR VALUES FROM (1) TO (11) WITH (fillfactor='100');
	

CREATE TABLE payment_history (
payment_id int,
cust_id int,
stock_id int,
status character(500),
at timestamp with time zone
) PARTITION BY RANGE (at) ;

ALTER TABLE payment_history ADD primary key(at,payment_id,stock_id);

CREATE TABLE payment_history_y2018m05 PARTITION OF payment_history FOR VALUES FROM ('2018-05-01 00:00:00') TO ('2018-06-01 00:00:00') WITH (fillfactor='100');
