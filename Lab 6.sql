-- 1. Display the name and city of customers who live in any city that
-- makes the most different products.  (There are two cities that make
-- the most different products.  Return the name and city of customers
-- from either of those.)
SELECT name, city
FROM customers
WHERE city IN (SELECT city
                FROM products
                GROUP BY city
                ORDER BY count(pid) DESC
                LIMIT 2);

-- 2. Display the names of products whose priceUSD is strictly above 
-- the average priceUSD, in reverse alphabetical order
SELECT name
FROM products
WHERE priceUSD > (SELECT avg(priceUSD)
                  FROM products)
ORDER BY name DESC;

-- 3. Display the customer name, pid ordered, and the total for all 
-- orders, sorted by total from high to low
SELECT c.name, o.pid, o.dollars AS total
FROM customers c, orders o
WHERE c.cid = o.cid
ORDER BY o.dollars DESC;

-- 4. Display all customer names (in alphabetic order) and their total 
-- ordered, and nothing more.  Use coalesce to avoid showing NULLs.
SELECT c.name, sum(COALESCE(o.qty, 0)) AS total
FROM orders o
INNER JOIN customers c ON c.cid = o.cid
GROUP BY o.cid, c.name
ORDER BY c.name ASC;

-- 5. Display the names of all customers who bought products from agents
-- based in Tokyo along with the names of the products they ordered, and
-- the names of the agents who sold it to them.
SELECT c.name, p.name, a.name
FROM orders o
INNER JOIN customers c ON c.cid = o.cid
INNER JOIN products p ON p.pid = o.pid
INNER JOIN agents a ON a.aid = o.aid
WHERE c.cid IN (SELECT cid
                FROM orders o
                INNER JOIN agents a ON a.aid = o.aid
                WHERE a.city = 'Tokyo');

-- 6. Write a query to check the accuracy of the dollars column in the 
-- Orders table.  This means calculating Orders.totalUSD from data in
-- other tables and comparing those values to the values in Orders.  
-- Display all rows in Orders where Orders.dollars is incorrect.
SELECT *
FROM (SELECT o.*, o.qty*p.priceusd*(1-(discount/100)) AS truedollars
      FROM orders o
      INNER JOIN products p ON o.pid = p.pid
      INNER JOIN customers c ON o.cid = c.cid) AS tmptable
WHERE dollars != truedollars

-- 7. What is the difference between a LEFT OUTER JOIN and a RIGHT OUTER 
-- JOIN?  Give example queries in SQL to demonstrate.  (Feel free to use 
-- the CAP2 database to make your points here.)

/*The difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN is which
entity is given precedence.  An outer join allows for every single row of 
an entity to be represented despite it's inclusion in the other entity being
joined.  So, right and left outer joins specify which entity to take all of 
rows from.  For example, the query

SELECT *
FROM orders o
LEFT OUTER JOIN products p ON p.pid = o.pid;

would return all of the rows from the orders table even if there is a row 
that doesn't correspond with the products table, whereas the query

SELECT *
FROM orders o
RIGHT OUTER JOIN products p ON p.pid = o.pid;

would return all of the rows from the products table even if there is a row 
that doesn't correspond with the orders table.*/