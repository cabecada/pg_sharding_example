This is README for Sharding setup


1. Create EC2 instance with security group as "db-security-group", then login to instance and Install PostgreSQL on it.

sudo apt-get install postgresql-plpython-11

2. Update postgresql configurations to allow all connections.
vim /etc/postgresql/11/main/postgresql.conf
listen_addresses = '*'

vim /etc/postgresql/11/main/pg_hba.conf
host    all             all             172.0.0.0/8            trust
------------------------


3. Create standalone database and create tables as below 

sudo su - postgres
psql
create database shard;
\q

psql -d shard -f create_tables_standalone.sql
psql -d shard -f load_data_standalone.sql



4. Create database shard and create tables as below 

A. Run below SQL's On each Data Node 

sudo su - postgres
psql
create database shard;
create database auto_shard;
\q


psql -d shard -f create_tables_datanode1.sql
bash load_data_node1.sh
psql -d shard -f drop_parent_data_node1.sql
----------
psql -d shard -f create_tables_datanode2.sql
bash load_data_node2.sh
psql -d shard -f drop_parent_data_node2.sql
----------
psql -d shard -f create_tables_datanode3.sql
bash load_data_node3.sh
psql -d shard -f drop_parent_data_node3.sql
----------
psql -d shard -f create_tables_datanode4.sql
bash load_data_node4.sh
psql -d shard -f drop_parent_data_node4.sql
----------
psql -d shard -f create_tables_datanode5.sql
bash load_data_node5.sh
psql -d shard -f drop_parent_data_node5.sql
----------
psql -d shard -f create_tables_datanode6.sql
bash load_data_node6.sh
psql -d shard -f drop_parent_data_node6.sql
----------
psql -d shard -f create_tables_datanode7.sql
bash load_data_node7.sh
psql -d shard -f drop_parent_data_node7.sql
----------
psql -d shard -f create_tables_datanode8.sql
bash load_data_node8.sh
psql -d shard -f drop_parent_data_node8.sql

-------------


B. Run below SQL's On shard Node :



sudo su - postgres
psql
create database shard;
create database auto_shard;
\q

psql -d shard -f setup_shard.sql




5. bench marking of setups :
Sample queries:

select * from customer c inner join payment_history p on c.cust_id=p.cust_id;
select * from stocks s inner join payment_history p on s.stock_id=p.stock_id;
select * from stocks s inner join payment_history p on s.stock_id=p.stock_id;
select * from stocks s inner join stocks_history sh on s.stock_id=sh.stock_id;
select * from stocks_history sh inner join payment_history p on sh.stock_id=sh.stock_id;

insert into stock_history     values ( )  ;
insert into payment_history    values ( );

update stock_history set stock_price = 5000 where stock_id= ;
update payment_history set status = INACTIVE where stock_id= ;

delete from stock_history  where stock_id= ;
delete from payment_history  where stock_id= ;





6. Setup monitoring ptwatch2 with graphana dashboard

sudo apt-get install postgresql-plpython-11


Run from Docker container 
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/cpu_load_plpythonu.sql "
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/stat_activity_wrapper.sql"
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/cpu_load_plpythonu_windows.sql"
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/stat_statements_wrapper.sql"
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/psutil_mem.sql"
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/psutil_cpu.sql"
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/psutil_disk_io_total.sql"
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/psutil_disk.sql"
psql -U postgres -d shard -h 52.66.213.139 -c "\i /pgwatch2/sql/metric_fetching_helpers/table_bloat_approx.sql"
