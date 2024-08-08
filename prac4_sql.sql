use BDA_23162121020;

create table client_master(Client_no varchar(6) primary key check(Client_no like 'C%'), Name varchar(15) NOT NULL, City varchar(15), Pincode numeric(8), State varchar(15), Bal_due numeric(10,2));
desc client_master;
insert into Client_master values( 'C001', 'Ivan', 'Bombay', 400054, 'Maharastra', 15000);
insert into Client_master values( 'C002', 'Vandana', 'Madras', 780001, 'Tamil Nadu', 0);
insert into Client_master values( 'C003', 'Pramada', 'Bombay', 400057, 'Maharastra', 5000);
insert into Client_master values( 'C004', 'Basu', 'Bombay', 400056, 'Maharastra', 0);
insert into Client_master values( 'C005', 'Ravi', 'Delhi', 100001, 'Gujarat', 2000);
insert into Client_master values( 'C006', 'Rukmani', 'Bombay', 400050, 'Maharastra', 0);
select * from Client_master;

create table product_master(Product_no varchar(6) primary key check(Product_no like 'P%'), Description varchar(15) NOT NULL, P_percent numeric(4,2) NOT NULL,U_measure varchar(10) NOT NULL,Qty_on_hand numeric(8) NOT NULL,Reorder_lvl numeric(8) NOT NULL,Sell_price numeric(8,2) NOT NULL check(Sell_price not like 0) ,Cost_price numeric(8,2) NOT NULL check(Cost_price not like 0));
desc product_master;
insert into Product_master values( 'P001', 'Floppies', 5, 'Piece', 100, 20, 525, 500);
insert into Product_master values( 'P002', 'Monitor', 6, 'Piece', 10, 3, 12000, 11280);
insert into Product_master values( 'P003', 'Mouse', 5, 'Piece', 20, 5, 1050, 1000);
insert into Product_master values( 'P004', 'Floppies', 5, 'Piece', 100, 20, 525, 500);
insert into Product_master values( 'P005', 'Keyboards', 2, 'Piece', 10, 3, 3150, 3050);
insert into Product_master values( 'P006', 'Cd Drive', 2.5, 'Piece', 10, 3, 5250, 5100);
insert into Product_master values( 'P007', '1.44 Drive', 4, 'Piece', 10, 3, 8400, 8000);
select * from Product_master;

create table salesman_master(S_no varchar(6) primary key check(S_no like 'S%'),S_name varchar(15) NOT NULL,City varchar(15), Pincode numeric(8), State varchar(15),Sal_amt numeric(8,2) NOT NULL check(Sal_amt not like 0) ,Tgt_to_get numeric(6,2) NOT NULL check(Tgt_to_get not like 0),Ytd_sales numeric(6,2) NOT NULL,Remarks varchar(20));
desc salesman_master;
insert into Salesman_master values('S001', 'Kiran', 'Bombay', 400002, 'Maharastra', 3000, 100, 50, 'Excellent');
insert into Salesman_master values('S002', 'Manish', 'Bombay', 400001, 'Maharastra', 3000, 200, 100, 'Good');
insert into Salesman_master values('S003', 'Ravi', 'Bombay', 400032, 'Maharastra', 3000, 200, 100, 'Average');
insert into Salesman_master values('S004', 'Ashish', 'Bombay', 400044, 'Maharastra', 3500, 200, 150, 'Good');
select * from Salesman_master;

create table sales_order(Order_no varchar(6) primary key check(Order_no like 'O%'), Order_date Date, Client_no Varchar(6) ,foreign key(Client_no) references client_master(Client_no), S_no varchar(6) ,foreign key(S_no) references salesman_master(S_no), Dely_Type char(1) DEFAULT 'F' check(dely_type like 'P' or dely_type like 'F'), Billed_yn char(1), Dely_date date ,check(Dely_date >= Order_date), Order_status varchar(10) check(Order_status like 'inprocess' or Order_status like 'cancelled' or Order_status like 'backorder' or Order_status like 'fulfilled') );
desc sales_order;
insert into Sales_order values('O1901' ,str_to_date('02/06/2015', '%d/%m/%Y') ,'C001' ,'S001' ,'F' ,'N' ,str_to_date('20/06/2015', '%d/%m/%Y') ,'InProcess');
insert into Sales_order values('O1902' ,str_to_date('25/01/2015', '%d/%m/%Y') ,'C002' ,'S002' ,'P' ,'N' ,str_to_date('27/06/2015', '%d/%m/%Y') ,'Cancelled');
insert into Sales_order values('O4665' ,str_to_date('18/02/2015', '%d/%m/%Y') ,'C003' ,'S003' ,'F' ,'Y' ,str_to_date('20/02/2015', '%d/%m/%Y') ,'fulfilled');
insert into Sales_order values('O1903' ,str_to_date('03/04/2015', '%d/%m/%Y') ,'C001' ,'S001' ,'F' ,'Y' ,str_to_date('07/04/2015', '%d/%m/%Y') ,'fulfilled');
insert into Sales_order values('O4666' ,str_to_date('20/05/2015', '%d/%m/%Y') ,'C004' ,'S002' ,'P' ,'N' ,str_to_date('22/05/2015', '%d/%m/%Y') ,'Cancelled');
insert into Sales_order values('O1908' ,str_to_date('24/05/2015', '%d/%m/%Y') ,'C005' ,'S003' ,'F' ,'N' ,str_to_date('26/05/2015', '%d/%m/%Y') ,'InProcess');
select * from Sales_order;

create table sales_order_details(Order_no varchar(6), foreign key(Order_no) references sales_order(Order_no), Product_no varchar(6) , foreign key(Product_no) references product_master(Product_no) ,Qty_orderd numeric(8) ,Qty_disp numeric(8) ,Product_rate numeric(10,2));
desc sales_order_details;
insert into sales_order_details values('O1901','P001', 4, 4, 525);
insert into sales_order_details values('O1901','P002', 2, 1, 8400);
insert into sales_order_details values('O1901','P003', 2, 1, 5250);
insert into sales_order_details values('O1902','P001', 10, 0, 525);
insert into sales_order_details values('O4665','P002', 3, 3, 3150);
insert into sales_order_details values('O4665','P004', 3, 1, 5250);
insert into sales_order_details values('O4665','P005', 10, 10, 525);
insert into sales_order_details values('O4665','P003', 4, 4, 1050);
insert into sales_order_details values('O1903','P006', 2, 2, 1050);
insert into sales_order_details values('O1903','P004', 1, 1, 12000);
insert into sales_order_details values('O1908','P005', 1, 0, 8400);
insert into sales_order_details values('O1908','P007', 10, 0, 1050);
select * from sales_order_details;