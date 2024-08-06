create database BDA_23162121020;
show databases; 

use BDA_23162121027;

create table Client_master( Client_no varchar(6), Name varchar(20), City varchar(15), Pincode numeric(8), State varchar(15), Bal_due numeric(10,2));
desc Client_master;

create table Product_master( Product_no varchar(6), Description varchar(15), P_Percent numeric(4,2), U_Measure varchar(10), Qty_on_Hand numeric(8), Reorder_lvl numeric(8), Sell_Price numeric(8,2), Cost_Price numeric(8,2));
desc Product_master;

create table Salesman_master( S_no varchar(6), S_Name varchar(20), City varchar(20), Pincode numeric(8), State varchar(15), Sal_amt numeric(8,2), Tgt_to_get numeric(6,2), Ytd_sales numeric(6,2), remarks varchar(12));
desc Salesman_master;

insert into Client_master values( 'C001', 'Ivan', 'Bombay', 400054, 'Maharastra', 15000);
insert into Client_master values( 'C002', 'Vandana', 'Madras', 780001, 'Tamil Nadu', 0);
insert into Client_master values( 'C003', 'Pramada', 'Bombay', 400057, 'Maharastra', 5000);
insert into Client_master values( 'C004', 'Basu', 'Bombay', 400056, 'Maharastra', 0);
insert into Client_master values( 'C005', 'Ravi', 'Delhi', 100001, 'Gujarat', 2000);
insert into Client_master values( 'C006', 'Rukmani', 'Bombay', 400050, 'Maharastra', 0);
select * from Client_master;

insert into Product_master values( 'P001', 'Floppies', 5, 'Piece', 100, 20, 525, 500);
insert into Product_master values( 'P002', 'Monitor', 6, 'Piece', 10, 3, 12000, 11280);
insert into Product_master values( 'P003', 'Mouse', 5, 'Piece', 20, 5, 1050, 1000);
insert into Product_master values( 'P004', 'Floppies', 5, 'Piece', 100, 20, 525, 500);
insert into Product_master values( 'P005', 'Keyboards', 2, 'Piece', 10, 3, 3150, 3050);
insert into Product_master values( 'P006', 'Cd Drive', 2.5, 'Piece', 10, 3, 5250, 5100);
insert into Product_master values( 'P007', '1.44 Drive', 4, 'Piece', 10, 3, 8400, 8000);
select * from Product_master;

insert into Salesman_master values('S001', 'Kiran', 'Bombay', 400002, 'Maharastra', 3000, 100, 50, 'Excellent');
insert into Salesman_master values('S002', 'Manish', 'Bombay', 400001, 'Maharastra', 3000, 200, 100, 'Good');
insert into Salesman_master values('S003', 'Ravi', 'Bombay', 400032, 'Maharastra', 3000, 200, 100, 'Average');
insert into Salesman_master values('S004', 'Ashish', 'Bombay', 400044, 'Maharastra', 3500, 200, 150, 'Good');
select * from Salesman_master;

select * from Client_master;
select Product_no , Sell_price , Cost_price from Product_master;
select S_no , S_name , Remarks , Sal_amt from Salesman_master;

show tables;
