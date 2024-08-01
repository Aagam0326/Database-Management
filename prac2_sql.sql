use BDA_23162121020;
set SQL_SAFE_UPDATES =0;

select name from client_master;
select name , city from client_master;
select Description from product_master;
select name from client_master where city = 'Bombay';
select S_Name from salesman_master where Sal_amt = 3000;
select distinct city from client_master;
select * from product_master order by Sell_Price desc ;
select * from product_master order by Sell_Price , Cost_Price desc;
select Product_no , Description from product_master order by Sell_Price desc;

update client_master set city = 'Bombay' where Client_no = 'C002';
select * from client_master;
update client_master set Bal_due = 1000 where Client_no = 'C001';
select * from client_master;
update product_master set cost_price = 950 where Description = 'Floppies';
select * from product_master;
update salesman_master set city = 'Mumbai' where city = 'bombay';
select * from salesman_master;

delete from salesman_master where sal_amt = 3500;
select * from salesman_master;
delete from product_master where Qty_on_hand = 100;
select * from product_master;
delete from client_master where state = 'Tamil Nadu';
select * from client_master;

alter table client_master add telephone int(10);
select * from client_master;
alter table product_master modify sell_price Numeric(10,2);
select * from product_master;
alter table client_master rename column telephone to contact;
select * from client_master;
alter table client_master drop contact;
select * from client_master;

create table employee (Column1 int, Column2 varchar(10), Column3 varchar(10), Column4 int);
insert into employee values(1, 'anik', 'okay', 10);
insert into employee values(2, 'this', 'nah', 8);
insert into employee values(3, 'that', 'mate', 7);
insert into employee values(4, 'nope', 'yo', 6);
insert into employee values(5, 'yess', 'buddy', 4);
select * from employee;
drop table employee;

rename table salesman_master to sman_mast;
select * from sman_mast;