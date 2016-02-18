--Lab 4

-- 1. Get the cities of agents booking an order for a customer whose cid is 'c002'
SELECT city
FROM agents
WHERE aid in (SELECT aid
		FROM orders
		WHERE cid = 'c002');

-- 2. Get the IDs of products ordered through any agent who takes at least one order from a customer in Dallas, 
-- sorted by pid from highest to lowest
SELECT pid
FROM orders
WHERE aid in (SELECT aid
		FROM orders
		WHERE cid in (SELECT cid
				FROM customers
				WHERE city = 'Dallas'))
ORDER BY pid DESC;

-- 3. Get the IDs and names of customers who did not place an order through agent 01
SELECT cid, name
FROM customers
WHERE cid in (SELECT cid
		FROM orders
		WHERE aid != 'a01');

-- 4. Get the IDs of customers who ordered both p01 and p07
SELECT DISTINCT cid
FROM orders
WHERE cid in (SELECT cid
		FROM orders
		WHERE pid = 'p01')
	AND
      cid in (SELECT cid
		FROM orders
		WHERE pid = 'p07');

-- 5. Get the IDs of products not ordered by any customers who placed any order 
-- through agent a07 in pid order from highest to lowest
SELECT pid
FROM orders
WHERE cid not in (SELECT cid
		  FROM orders 
		  WHERE aid = 'a07')
ORDER BY pid DESC;

-- 6. Get the name, discounts, and city for all customers who place orders through
-- agents in London or New York
SELECT name, discount, city
FROM customers
WHERE cid in (SELECT cid
		FROM orders
		WHERE aid in (SELECT aid
				FROM agents
				WHERE city = 'London' OR city = 'New York'));

-- 7. Get all customers who have the same discount as that of any customers in Dallas or London
SELECT *
FROM customers
WHERE discount in (SELECT discount
			FROM customers
			WHERE city = 'Dallas' or city = 'London');

-- 8. Check Constraints
/* A CHECK constraint limits the values you can enter in a column.  They allow for a range of 
values to be specified for a column so that nothing outside that range would be allowed.  This
way, if someone is trying to create a new row in a database and they don't know that only certain 
values would make sense in a certain column, the database won't let them put in the value that 
doesn't make sense.  For example, if you had a column for age, you could create a CHECK constraint
that would check to make sure the value is not less than 0 so that no one can say that they are an 
age that cannot happen.  However, it would be a bad idea to use it to limit on the other end and 
say that no one can enter an age over 100, because there are people who are older than 100 and 
this would exclude them.  */

