
CREATE EXTENSION postgres_fdw;
create extension pg_stat_statements ;
create extension plpythonu ;

CREATE SERVER data_node_1 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.28.51', dbname 'shard');
CREATE SERVER data_node_2 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.30.149', dbname 'shard');
CREATE SERVER data_node_3 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.20.171', dbname 'shard');
CREATE SERVER data_node_4 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.26.202', dbname 'shard');
CREATE SERVER data_node_5 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.16.37', dbname 'shard');
CREATE SERVER data_node_6 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.17.196', dbname 'shard');
CREATE SERVER data_node_7 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.19.185', dbname 'shard');
CREATE SERVER data_node_8 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '172.31.6.113', dbname 'shard');

CREATE USER MAPPING FOR postgres SERVER data_node_1 OPTIONS (user 'postgres');
CREATE USER MAPPING FOR postgres SERVER data_node_2 OPTIONS (user 'postgres');
CREATE USER MAPPING FOR postgres SERVER data_node_3 OPTIONS (user 'postgres');
CREATE USER MAPPING FOR postgres SERVER data_node_4 OPTIONS (user 'postgres');
CREATE USER MAPPING FOR postgres SERVER data_node_5 OPTIONS (user 'postgres');
CREATE USER MAPPING FOR postgres SERVER data_node_6 OPTIONS (user 'postgres');
CREATE USER MAPPING FOR postgres SERVER data_node_7 OPTIONS (user 'postgres');
CREATE USER MAPPING FOR postgres SERVER data_node_8 OPTIONS (user 'postgres');



CREATE TABLE stocks_history (
stock_id int,
stock_price int,
stock_currency character(500),
at timestamp with time zone 
) PARTITION BY RANGE (at);

CREATE TABLE stocks (
stock_id int,
stock_name text,
stock_desc text
) PARTITION BY RANGE (stock_id);

CREATE TABLE customer (
cust_id int,
cust_name text,
cust_desc text
) PARTITION BY RANGE (cust_id);


CREATE TABLE payment_history (
payment_id int,
cust_id int,
stock_id int,
status text,
at timestamp with time zone
) PARTITION BY RANGE (at);


CREATE FOREIGN TABLE stocks_history_y2018m05 PARTITION OF stocks_history
FOR VALUES FROM ('2018-05-01 00:00:00') TO ('2018-06-01 00:00:00')
SERVER data_node_1;

CREATE FOREIGN TABLE stocks_history_y2018m06 PARTITION OF stocks_history
FOR VALUES FROM ('2018-06-01 00:00:00') TO ('2018-07-01 00:00:00')
SERVER data_node_2;

CREATE FOREIGN TABLE stocks_history_y2018m07 PARTITION OF stocks_history
FOR VALUES FROM ('2018-07-01 00:00:00') TO ('2018-08-01 00:00:00')
SERVER data_node_3;

CREATE FOREIGN TABLE stocks_history_y2018m08 PARTITION OF stocks_history
FOR VALUES FROM ('2018-08-01 00:00:00') TO ('2018-09-01 00:00:00')
SERVER data_node_4;

CREATE FOREIGN TABLE stocks_history_y2018m09 PARTITION OF stocks_history
FOR VALUES FROM ('2018-09-01 00:00:00') TO ('2018-10-01 00:00:00')
SERVER data_node_5;

CREATE FOREIGN TABLE stocks_history_y2018m10 PARTITION OF stocks_history
FOR VALUES FROM ('2018-10-01 00:00:00') TO ('2018-11-01 00:00:00')
SERVER data_node_6;

CREATE FOREIGN TABLE stocks_history_y2018m11 PARTITION OF stocks_history
FOR VALUES FROM ('2018-11-01 00:00:00') TO ('2018-12-01 00:00:00')
SERVER data_node_7;

CREATE FOREIGN TABLE stocks_history_y2018m12 PARTITION OF stocks_history
FOR VALUES FROM ('2018-12-01 00:00:00') TO ('2019-01-01 00:00:00')
SERVER data_node_8;
	
CREATE FOREIGN TABLE stocks1 PARTITION OF stocks FOR VALUES FROM (1) TO (11) SERVER data_node_1;
CREATE FOREIGN TABLE stocks2 PARTITION OF stocks FOR VALUES FROM (11) TO (21) SERVER data_node_2;
CREATE FOREIGN TABLE stocks3 PARTITION OF stocks FOR VALUES FROM (21) TO (31) SERVER data_node_3;
CREATE FOREIGN TABLE stocks4 PARTITION OF stocks FOR VALUES FROM (31) TO (41) SERVER data_node_4;
CREATE FOREIGN TABLE stocks5 PARTITION OF stocks FOR VALUES FROM (41) TO (51) SERVER data_node_5;
CREATE FOREIGN TABLE stocks6 PARTITION OF stocks FOR VALUES FROM (51) TO (61) SERVER data_node_6;
CREATE FOREIGN TABLE stocks7 PARTITION OF stocks FOR VALUES FROM (61) TO (71) SERVER data_node_7;
CREATE FOREIGN TABLE stocks8 PARTITION OF stocks FOR VALUES FROM (71) TO (81) SERVER data_node_8;

CREATE FOREIGN TABLE customer1 PARTITION OF customer FOR VALUES FROM (1) TO (11) SERVER data_node_1;
CREATE FOREIGN TABLE customer2 PARTITION OF customer FOR VALUES FROM (11) TO (21) SERVER data_node_1;
CREATE FOREIGN TABLE customer3 PARTITION OF customer FOR VALUES FROM (21) TO (31) SERVER data_node_1;
CREATE FOREIGN TABLE customer4 PARTITION OF customer FOR VALUES FROM (31) TO (41) SERVER data_node_1;
CREATE FOREIGN TABLE customer5 PARTITION OF customer FOR VALUES FROM (41) TO (51) SERVER data_node_1;
CREATE FOREIGN TABLE customer6 PARTITION OF customer FOR VALUES FROM (51) TO (61) SERVER data_node_1;
CREATE FOREIGN TABLE customer7 PARTITION OF customer FOR VALUES FROM (61) TO (71) SERVER data_node_1;
CREATE FOREIGN TABLE customer8 PARTITION OF customer FOR VALUES FROM (71) TO (81) SERVER data_node_1;
	
CREATE FOREIGN TABLE payment_history_y2018m05 PARTITION OF payment_history
FOR VALUES FROM ('2018-05-01 00:00:00') TO ('2018-06-01 00:00:00')
SERVER data_node_1;

CREATE FOREIGN TABLE payment_history_y2018m06 PARTITION OF payment_history
FOR VALUES FROM ('2018-06-01 00:00:00') TO ('2018-07-01 00:00:00')
SERVER data_node_2;

CREATE FOREIGN TABLE payment_history_y2018m07 PARTITION OF payment_history
FOR VALUES FROM ('2018-07-01 00:00:00') TO ('2018-08-01 00:00:00')
SERVER data_node_3;

CREATE FOREIGN TABLE payment_history_y2018m08 PARTITION OF payment_history
FOR VALUES FROM ('2018-08-01 00:00:00') TO ('2018-09-01 00:00:00')
SERVER data_node_4;

CREATE FOREIGN TABLE payment_history_y2018m09 PARTITION OF payment_history
FOR VALUES FROM ('2018-09-01 00:00:00') TO ('2018-10-01 00:00:00')
SERVER data_node_5;

CREATE FOREIGN TABLE payment_history_y2018m10 PARTITION OF payment_history
FOR VALUES FROM ('2018-10-01 00:00:00') TO ('2018-11-01 00:00:00')
SERVER data_node_6;

CREATE FOREIGN TABLE payment_history_y2018m11 PARTITION OF payment_history
FOR VALUES FROM ('2018-11-01 00:00:00') TO ('2018-12-01 00:00:00')
SERVER data_node_7;

CREATE FOREIGN TABLE payment_history_y2018m12 PARTITION OF payment_history
FOR VALUES FROM ('2018-12-01 00:00:00') TO ('2019-01-01 00:00:00')
SERVER data_node_8;



