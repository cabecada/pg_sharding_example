-- Drop parent tables
ALTER TABLE stocks_history DETACH PARTITION stocks_history_y2018m11;
ALTER table stocks DETTACH PARTITION stocks7;
ALTER table customer DETTACH PARTITION customer7;
ALTER table payment_history DETTACH PARTITION payment_history_y2018m11;


drop table stocks_history;
drop table stocks;
drop table customer;
drop table payment_history;
