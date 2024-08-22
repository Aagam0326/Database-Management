use bda_23162121020;

SELECT Product_no , Description FROM product_master WHERE Product_no NOT IN (SELECT Product_no FROM sales_order_details);
SELECT name , city , State , Pincode FROM client_master WHERE client_no = (SELECT client_no FROM sales_order WHERE order_no = 'o1901');
SELECT  client_no, name FROM client_master 
WHERE client_no IN (SELECT client_no FROM sales_order_details WHERE product_no = (SELECT product_no FROM product_master WHERE description = 'mouse'));

SELECT Description , SUM(Qty_on_hand) AS totl_qty_sold FROM product_master GROUP BY Description LIMIT 10;
SELECT Description , SUM(Qty_on_hand) AS totl_qty_sold , Sell_price FROM product_master GROUP BY Description , Sell_price LIMIT 10;
SELECT pm.Description , SUM(pm.Qty_on_hand) AS totl_qty_sold , pm.Sell_price , s.Order_date
FROM product_master AS pm JOIN sales_order_details AS sd ON pm.Product_no = sd.Product_no
 JOIN sales_order AS s ON sd.Order_no = s.Order_no
WHERE month(s.Order_date) = 1 GROUP BY pm.Description , pm.Sell_price , s.Order_date LIMIT 10;

SELECT p.product_no, p.description FROM product_master AS p
JOIN sales_order_details AS s ON p.product_no = s.product_no
JOIN sales_order AS o ON s.order_no = o.order_no
JOIN client_master AS c ON o.client_no = c.client_no
WHERE c.name = 'ivan';
SELECT Product_no , Description FROM product_master
WHERE Product_no IN(SELECT Product_no FROM sales_order_details GROUP BY Product_no HAVING COUNT(*)>=3);
SELECT c.name FROM client_master AS c JOIN sales_order AS so ON c.Client_no = so.Client_no 
JOIN sales_order_details AS o ON o.Order_no = so.Order_no 
JOIN product_master AS p ON o.Product_no = p.Product_no WHERE p.Description = 'Cd Drive' 
GROUP BY c.name ;
SELECT d.Product_no , d.Order_no FROM sales_order_details AS d 
JOIN product_master AS p ON d.Product_no = p.Product_no WHERE  p.description = 'mouse' AND d.qty_orderd < 4 ;

SELECT concat(p.Description, ' Worth Rs.', CAST(SUM(d.qty_orderd * d.product_rate)AS CHAR), ' Was Sold') FROM product_master AS p 
JOIN sales_order_details AS d ON d.Product_no = p.Product_no 
GROUP BY p.Description;

SELECT * FROM product_master;
SELECT * FROM sales_order_details;
SELECT * FROM client_master;
SELECT * FROM salesman_master;