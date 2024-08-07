use BDA_23162121020;

create table Sales_order(Order_no varchar(6) ,Order_Date date ,Client_no varchar(6) ,S_no varchar(6) ,Dely_type char(1) ,Billed_yn char(1) ,Dely_Date date ,Order_Status varchar(10));
desc Sales_order;

insert into Sales_order values('O1901' ,str_to_date('02/06/2015', '%d/%m/%Y') ,'C001' ,'S001' ,'F' ,'N' ,str_to_date('20/06/2015', '%d/%m/%Y') ,'InProcess');
insert into Sales_order values('O1902' ,str_to_date('25/01/2015', '%d/%m/%Y') ,'C002' ,'S002' ,'P' ,'N' ,str_to_date('27/06/2015', '%d/%m/%Y') ,'Cancelled');
insert into Sales_order values('O4665' ,str_to_date('18/02/2015', '%d/%m/%Y') ,'C003' ,'S003' ,'F' ,'Y' ,str_to_date('20/02/2015', '%d/%m/%Y') ,'Fullfilled');
insert into Sales_order values('O1903' ,str_to_date('03/04/2015', '%d/%m/%Y') ,'C001' ,'S001' ,'F' ,'Y' ,str_to_date('07/04/2015', '%d/%m/%Y') ,'Fullfilled');
insert into Sales_order values('O4666' ,str_to_date('20/05/2015', '%d/%m/%Y') ,'C004' ,'S002' ,'P' ,'N' ,str_to_date('22/05/2015', '%d/%m/%Y') ,'Cancelled');
insert into Sales_order values('O1908' ,str_to_date('24/05/2015', '%d/%m/%Y') ,'C005' ,'S003' ,'F' ,'N' ,str_to_date('26/05/2015', '%d/%m/%Y') ,'InProcess');
select * from Sales_order;

select * from client_master where Name like '_a%';
select * from client_master where Name like '_a__';
select * from client_master where City like '%a_';
select * from client_master where Bal_due >= 10000;
select * from sales_order where month(order_date) = 1;
select * from client_master where Client_no = 'C003'or Client_no = 'C001';
select * from product_master where sell_price between 2000 and 5000;
select sell_price = 1500 and sell_price * 0.15 new_price from product_master;
select * from product_master;
select * from client_master where state not in('Maharastra');
select count(order_no) from sales_order;
select avg(sell_price) "Average of Sell Price is:" from product_master;
select max(sell_price) "The Maximum Price is:" , min(sell_price) "The Minimum Price is:" from product_master;
select count(product_no) "The Total No. Of Product is:" from product_master where sell_price >=1050;
select count(product_no) "The Total No. Of Product is:" from product_master where Reorder_lvl > Qty_on_Hand;

create table cmaster like client_master;
desc cmaster;
insert into cmaster select * from client_master where city = 'Bombay';
select * from cmaster;
create table sales as select order_no , client_no from sales_order;
desc sales;
insert into sales (order_no, client_no) select Order_no, Client_no from sales_order;
select * from sales;

select order_no, dayname(order_date) as order_day from sales_order;
select date_format(dely_date, '%M %d') as dely_month_date from sales_order;
select datediff(dely_date, order_date) as days_elapsed from sales_order;
select date_add(current_date(), interval 15 day) as date_after_15_days;
select now() as current_date_time;
select curtime() as system_time;
