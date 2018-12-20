#!/bin/bash

start_date='2018-11-01 00:00:00'
end_date='2018-11-30 00:00:00'

for id in {61..70}
do
        psql -d shard -c "insert into stocks_history_y2018m11 values ( $id, generate_series(1,2505600), 'Rupees', generate_series(timestamp '$start_date',timestamp '$end_date', interval '1 sec'));"

done

for id in {61..70}
do
        psql -d shard -c "insert into stocks7 values ( $id, md5(random()::text), md5(random()::text));"
done

for id in {61..70}
do
        psql -d shard -c "insert into customer7 values ( $id, md5(random()::text), md5(random()::text));"
done

for id in {61..70}
do
       psql -d shard -c "insert into payment_history_y2018m11 values (  generate_series(1,1252801), $id, $id, 'Active', generate_series(timestamp '$start_date',timestamp '$end_date', interval '2 sec'));"

done
