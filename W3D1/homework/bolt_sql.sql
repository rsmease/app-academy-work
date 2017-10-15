-- INTRODUCTION
-- -- Structured Query Language (SQL) is a langugage designed for non-technical users who want to query, manipulate and transform data from a relational database.
--   -- Variations on SQL will supports the common SQL syntax, but offer different features unique to that variation; variations include SQLite, MySQL, PostgreSQL, Oracle and Microsoft SQL Server
--   Relational databases represent data in two-dimensional tables
--     Each tables has a fixed number of columns (variable types) and rows (variable data for a specific subject)

-- SELECT QUERIES
-- SELECT queries are used to pull data from a database; they are always paired with FROM to identify the table searched and they are sometimes paired with WHERE to filter the content of the query
  -- Use the * to retreive all columns; use comma_separated values to return multiple columns
  -- SELECT will return a copy of the selected table filtered for the queries columns

SELECT title FROM movies;
SELECT director FROM movies;
SELECT title, director FROM movies;
SELECT title, year FROM movies;
SELECT * FROM movies;

-- SELECT WITH CONSTRAINTS
  -- A WHERE clause will provided filtering constraints on your query
  -- More complex clauses can be cosntructed by joining AND / OR / IS NULL / IS NOT NULL operators, as well as others...
  --     _____________________
  --     =, !=, < <=, >, >=	Standard numerical operators	col_name != 4
  --     BETWEEN … AND …	Number is within range of two values (inclusive)	col_name BETWEEN 1.5 AND 10.5
  --     NOT BETWEEN … AND …	Number is not within range of two values (inclusive)	col_name NOT BETWEEN 1 AND 10
  --     IN (…)	Number exists in a list	col_name IN (2, 4, 6)
  --     NOT IN (…)	Number does not exist in a list	col_name NOT IN (1, 3, 5)
  --     _____________________

SELECT * FROM movies WHERE id == 6;
SELECT * FROM movies WHERE year BETWEEN 2000 and 2010;
SELECT * FROM movies WHERE year NOT BETWEEN 2000 and 2010;
SELECT * FROM movies WHERE id BETWEEN 1 AND 5;

-- SELECT WITH CONSTRAINTS P2
--   A WHERE clause can also support a variety of string parsing operators...
--   _____________________
--     =	Case sensitive exact string comparison (notice the single equals)	col_name = "abc"
--   != or <>	Case sensitive exact string inequality comparison	col_name != "abcd"
--   LIKE	Case insensitive exact string comparison	col_name LIKE "ABC"
--   NOT LIKE	Case insensitive exact string inequality comparison	col_name NOT LIKE "ABCD"
--   %	Used anywhere in a string to match a sequence of zero or more characters (only with LIKE or NOT LIKE)	col_name LIKE "%AT%"
--   (matches "AT", "ATTIC", "CAT" or even "BATS")
--   _	Used anywhere in a string to match a single character (only with LIKE or NOT LIKE)	col_name LIKE "AN_"
--   (matches "AND", but not "AN")
--   IN (…)	String exists in a list	col_name IN ("A", "B", "C")
--   NOT IN (…)	String does not exist in a list	col_name NOT IN ("D", "E", "F")
--   _____________________
--   Full text search is best left to specialized database libraries like Apache Lucene and Sphinx; they are more efficient than the default SQL tools

SELECT * FROM movies WHERE title LIKE "%toy story%";
SELECT * FROM movies WHERE director LIKE "john lasseter";
SELECT * FROM movies WHERE director NOT LIKE "john lasseter";
SELECT * FROM movies WHERE title LIKE "%WALL-%";

-- FILTERING AND SORING RESULTS
-- The DISTINCT keyword allows you to discard rows with a duplicate column value
--   This will act blindly; be careful—imaging having one string with multiple 'e' characters and just using 'delete(e)'
-- Most databases will not be ordered in a thoughtful way, so you need the ORDER BY filter on your query to return a table that is ordered according to your particular needs
--   ORDER BY will filter alphanumerically
-- The LIMIT keyword will limit the number of rows returned (generally based on the first LIMIT number of entries in the ORDER BY ordering schema)
--   OFFSET will push the starting selection forward (e.g. if you want results 5-10 instead of 1-5 in the ORDER BY ordering schema)

SELECT DISTINCT director FROM movies ORDER BY director;
SELECT * FROM movies ORDER BY year DESC LIMIT 4;
SELECT * FROM movies ORDER BY title LIMIT 5;
SELECT * FROM movies ORDER BY title LIMIT 5 OFFSET 5;

-- REVIEW: SIMPLE SELECT QUERIES

SELECT * FROM north_american_cities WHERE country LIKE "canada";
SELECT * FROM north_american_cities WHERE country LIKE "united states" ORDER BY latitude DESC;
SELECT city, longitude FROM north_american_cities
WHERE longitude < -87.629798
ORDER BY longitude ASC;
SELECT * FROM north_american_cities WHERE country LIKE "mexico" ORDER BY population DESC LIMIT 2;
SELECT * FROM north_american_cities WHERE country LIKE "united states" ORDER BY population DESC LIMIT 2 OFFSET 2;

-- MULTITABLE QUERIES WITH JOINS
--
-- Real world data is often broken down into pieces and stored across multiple orthogonal tables using a process known as normalization
-- Normalization is useful because it reduces duplicate data in each table
--   As a trade-off, queries get more complex
-- INNER JOIN will join two tables based on a sematically identical key (this may be specifically identified as a foreign key in one table, or it might be assigned the same status as a foreign key)
--   Think of foreign keys as links between tables
--   Any column can be turned into a foreign key via INNER JOIN
-- INNER JOIN will only join the table where the second table has a match in its ON column

SELECT * FROM movies INNER JOIN boxoffice ON movies.id == boxoffice.movie_id;
SELECT * FROM movies INNER JOIN boxoffice ON movies.id == boxoffice.movie_id WHERE international_sales > domestic_sales;
SELECT * FROM movies INNER JOIN boxoffice ON movies.id == boxoffice.movie_id ORDER BY rating DESC;
--
-- OUTER JOINS

-- If two tables have asymmetric data, which can easily happen when data are pulled from disparate databases, you should use LEFT JOIN, RIGHT JOIN or FULL JOIN to make sure that no data are left out
  -- You might also see them written as LEFT OUTER JOIN, RIGHT OUTER JOIN or FULL OUTER JOIN (the OUTER is no longer required)
-- You may want to write additional logic because all of the join will produce NULL responses where the data are asymmetric

SELECT DISTINCT building FROM employees;
SELECT * FROM buildings;
SELECT DISTINCT building_name, role
FROM buildings
  LEFT JOIN employees
    ON building_name = building;

-- NULL

-- It's always good practice to reduce the presence of NULL in a search query result
--   An alternative to NULL values in my database might be data-type appropriate default values, like 0 for Integer or "" for String
--   Sometimes, it's also not posssible to avoid NULL values with OUTER JOIN actions, so we can filter using WHERE column IS/IS NOT NULL

SELECT name, role FROM employees WHERE building IS NULL;
SELECT DISTINCT building_name
FROM buildings
  LEFT JOIN employees
    ON building_name = building
WHERE role IS NULL;

-- QUERIES WITH EXPRESSIONS
--
-- Each database has its own supported sset of mathematical, string and date functions that can be used in a query
--   Use of expressions saves time and extra post-processing on resulting data sets, but they can also make the query harder to read
-- Using expressions makes queries harder to read, but we can ofset this with useful alias names

SELECT title, (domestic_sales + international_sales) / 1000000 AS combined_sales FROM movies INNER JOIN boxoffice ON id == movie_id;
SELECT title, rating * 10 AS rating_percent
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;
SELECT * FROM movies WHERE year % 2 == 0;

-- AGGREGATE FUNCTIONS
--
-- SQL also supports the use of predefined aggregate functions (much like Excel's formulae) that allow you to quickly capture common data summaries...
--   _____________________
--   COUNT(column)	A common function used to counts the number of rows in the group if no column name is specified. Otherwise, count the number of rows in the group with non-NULL values in the specified column.
--   MIN(column)	Finds the smallest numerical value in the specified column for all rows in the group.
--   MAX(column)	Finds the largest numerical value in the specified column for all rows in the group.
--   AVG(column)	Finds the average numerical value in the specified column for all rows in the group.
--   SUM(column)	Finds the sum of all numerical values in the specified column for the rows in the group.
--   _____________________
-- You can apply aggregates to selected subsets of a table by pairing the aggregate function with the GROUP BY selector

SELECT MAX(years_employed) FROM employees;
SELECT role, AVG(years_employed) FROM employees GROUP BY role;
SELECT building, SUM(years_employed) FROM employees GROUP BY building;

-- AGGREGATE FUNCTIONS P2

-- In addition to GROUP BY, SQL will also employe a HAVING clause to mimic its higher order WHERE clause, which much always precede the GROUP BY clause due to SQL's fixed order of operations
--   The HAVING clause works precisely the same way as WHERE, but with the grouped ROWS, allowing you to maintain the grouped sort afforded by the aggregate function and GROUP BY
  -- Don't use HAVING unless you're using GROUP BY

SELECT COUNT(*) FROM employees WHERE role LIKE 'artist';
SELECT role, COUNT(*) FROM employees GROUP BY role;
SELECT role, SUM(years_employed) FROM employees WHERE role LIKE "engineer";

-- QUERY ORDER OF EXECUTION
--
-- 1. FROM and JOIN
--   select our table of choice and join it to another table (or multiple tables)
-- 2. WHERE
--   pair down the joined tables based on expressions
-- 3. GROUP BY
--   order aggregated data sets to be grouped by particular columns' unique values
-- 4. HAVING
--   WHERE function variant for data sorted by GROUP BY
-- 5. SELECT
--   The selected columns are finally computed based on the resulting rows of executed tasks 1-4
-- 6. DISTINCT
--   On the remaining rows, the duplicate values are discarded
-- 7. ORDER BY
--   The remaining rows are then sorted per the ORDER BY clause
-- 8. LIMIT / OFFSET
--   The ordered rows are now filtered to a limited number of result rows, based on the LIMIT and OFFSET (default 0) constraints

SELECT director, COUNT(id) as Num_movies_directed
FROM movies
GROUP BY director;

SELECT director, SUM(domestic_sales + international_sales) AS total_sales
FROM movies
INNER JOIN boxoffice ON id == movie_id
GROUP BY director
ORDER BY total_sales DESC;
