SELECT ordno, dollars
FROM orders;

SELECT name, city
FROM agents
WHERE name = 'Smith';

SELECT pid, name, priceUSD
FROM products
WHERE quantity > 208000;

SELECT name, city
FROM customers
WHERE city = 'Dallas';

SELECT name, city
FROM agents
WHERE city != 'New York' AND city != 'Tokyo';

SELECT *
FROM products
WHERE city != 'Dallas' AND city != 'Duluth' AND priceUSD >= 1;

SELECT * 
FROM orders
WHERE mon = 'jan' OR mon = 'mar';

SELECT *
FROM orders
WHERE dollars < 500;

SELECT * 
FROM orders
WHERE cid = 'c005';