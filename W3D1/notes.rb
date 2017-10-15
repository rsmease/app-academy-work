#Programming Paradigms
  #Paradigms are how we classify programming languages according to their style
  #Imperative programming: original style of high-level languages; this just feeds step by step intructions to the computer
  #Strictly imperative programming looks like this:
      result = []
      i = 0
    start:
      numPeople = length(people)
      if i >= numPeople goto finished
      p = people[i]
      nameLength = length(p.name)
      if nameLength <= 5 goto nextOne
      upperName = toUpper(p.name)
      addToList(result, upperName)
    nextOne:
      i = i + 1
      goto start
    finished:
      return sort(result)
    #A light version, with nests and subroutines via gotos, is known as structured programming
    def imperative_odds(array)
      idx = 0
      odds = []
      while (idx < array.length)
        if array[idx].odd?
          odds << array[idx]
        end
        i += 1
      end
      odds
    end
  #Declarative programming: describes what you want to achieve, without going into too much detail about it
  def declarative_odds(array)
    odds = array.select { |el| el.odd? }
  end
  #Object-Oriented progrmaming is a programming style that defines classes/objects with internal logic; those objects can then be reproduced and communicate to one another via public APIs
  #Functional programming involves the use of functions with hidden details to accomplish routine tasks
  people |> map (to_upper o name) |> filter (λs. length s > 5) |> sort
  #At it's best, functional programming would be programming without the use of variable assignment
  #Most languages are able to handle a variety of diferent styles, but lean on a primary style or two
  #We are bringing this up here because SQL is a declarative language; it has fewer abstracted features that allow for declarative programming


#Intro to SQL
#To save (persist) data, you need to write the data to a form of permanent storage
  #cf. serialization in the runtime of a program
#Applications usually want rich relations for their data
  #Relational databases (RDBMS relational database management systems) were developed to persist data and their relationships, while providing a way to query that data
  #RDBs are organized into tables; each row is a single entity in the table
    #Each column in the row will house data for that entity pertaining to different classes or values
    #Every row in a database table will have a primary key column to serve as the unique ID for the entity whose characteristics are stored in that row
  #Specific RDB tables will hold specific kinds of features for your application that you want to search (users, blog posts, cat pictures)
#A database schema is its specific method of organizing data
  #Think about: what tables will you have, what columns will each table have, what type of data will be entered in those columns
  #Schemas are mutable after DB creation
  #SQL is statically typed: you have to decide the datatype of the entry in each column of the table
    #BOOLEAN, INT, FLOAT, VARCHAR(255) (short text), TEXT, DATE, DATETIME, TIME, BLOB (image)
#Relationships between databases are maintained by the use of foreign keys, which are a column of values that represent a link to the data for the same or for related objects in another data table
  #A foreign key in one table will always be a primary key of some other table
  #By convention, we call it something like '..._id'
#SQL is a declarative language broken down into clauses
    SELECT
      name, age, has_cats
    FROM
      tenants
    WHERE
      (has_cats = true AND age > 50)
#SELECT chooses columns from a particular table (identified by FROM), and WHERE filters the query by specific boolean qualifiers on the columns that were called
  #Booleans are etablished by comparison operators or the AND, OR and NOT commands
#SELECT syntax:
  #* for all columns
  #comma_separated, columns for mulitple columns
#INSERT INTO  syntax:
  #table name (column, names, separated)
    #values, corresponding, separated
    INSERT INTO
      users (name, age, height_in_inches)
    VALUES
      ('Santa Claus', 876, 34);
#UPDATE  / SET syntax:
  #table name
  #SET clause will reassign values in named columns
  #WHERE can filter
    UPDATE
      users
    SET
      name = 'Eddard Stark', house = 'Winterfell'
    WHERE
      name = 'Ned Stark';
#DELETE FROM syntax:
  #This will remove rows where conditions are met or specific rows are named
    DELETE FROM
      users
    WHERE
      (name = 'Eddard Stark' AND house = 'Winterfell');
#CREATE TABLE syntax:
    CREATE TABLE users (
      id INTEGER PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      birth_date DATE,
      house VARCHAR(255),
      favorite_food VARCHAR(20)
    );

#Just as with a good Ruby program, you should think about how you organize your SQL tables into useful objects that have a self-contained semantic; this leads to all the same benefits of OOP

#JOIN syntax:
    SELECT
      users.name, posts.title
    FROM
      posts
    JOIN
      users ON posts.user_id = users.id
#The on statement allows you to specify the key and foreign key against which to join the tables; this action returns a new table separate from the first two, combining each
  #We can also make filtered joins, and we can join a table to itself (think about a company where certain employees are also managers, but still reports to another manager)
  #We can also join tables at multiple locations
    SELECT
      users.name, posts.title
    FROM
      posts
    JOIN
      likes ON posts.id = likes.post_id
    JOIN
      users ON likes.user_id = users.

#Different Kinds of JOIN
  #INNER JOIN will return the rows of the table where two rows have a matching column (x)
  #FULL OUTER JOIN will return all of the rows in the table; rows that would have displayed content via INNER join are matched with their respective parthers; where no match is possible, the table with the missing variable (some might be missing some, the other missing others), the missing variable fields are filled with null
  #FULL OUTER JOIN can also be written to exclude everything _except_ the unique elements of each table (symmetric difference)
  #LEFT/RIGHT OUTER JOIN will return results similar to FULL OUTER JOIN, except that, where matches are missing, only the left or right table's unique variables will appear next to variable fields will with null; the other tables unique variables are excluded
  #CROSS JOIN will similar to the FULL OUTER JOIN, but will match everything to everything (not just one shared variable)
#Self Joins
  #Self-joins use IDs within a single table to fold the table over itself, highlighting hierarchical or symbiotic relationships within a large data set across different variables

    SELECT
      team_member.first_name, team_member.last_name,
       manager.first_name, manager.last_name
    FROM
      employee team_member
    JOIN
      employee manager ON manager.id = team_member.manager_id
#SQL Conventions
  #Always named tables snake_case
  #Always pluralized
  #Always have one column named id as the primary key for the table
  #Do not write SQL commands as single-line statements
    SELECT * FROM table_one LEFT OUTER table_two ON table_one.column_one = table_two.column_x WHERE (table_one.column_three > table_two.column_y
      #eew
#Subqueries
  #By using parenthetical statements, you can make subqueries that make the queries against your table richer and more precise
    SELECT *
    FROM sales_associates
    WHERE salary >
      (SELECT AVG(revenue_generated)
      FROM sales_associates);
    #Be sure to indent and format subqueries like this
  #A very powerful form of subquery is the correlated subquery, where the return of the subquery is dependent on the return of the parent query
    SELECT *
    FROM employees
    WHERE salary >
      (SELECT AVG(revenue_generated)
      FROM employees AS dept_employees
      WHERE dept_employees.department = employees.department);
  #Subqueries can be difficult to understand; where reasonable, consider just doing two iterative queries
  #Subqueries nested in WHERE can be paired with IN/NOT IN to produce existence tests—tests that return value exists
#NULL
  #In SQL, NULL sits alongside TRUE and FALSE, but it represents missing or unknown data
  #NULL == NULL will evaluate to FALSE because it implies certainty about the equality of two unknown data sets
  #When checking whether or not something returns NULL, use IS NULL or IS NOT NULL rather than == or != NULL
#CASE
  #PostgreSQL will allow you to use a CASE statement to run subqueries in lieu of the WHERE filter
    CASE expression
    WHEN value_1 THEN
      result_1
    WHEN value_2 THEN
      result_2
    [WHEN ...]
    ELSE
      result_n
    END;
#COALESCE
  #PostgreSQL COALESCE will look at an unlimited number of arguments until it finds and returns something that is not NULL; if all arguments are NULL, it will return NULL
  #This function is often used to provide defaults where a NULL value is possible
    SELECT
    COALESCE (excerpt, LEFT(CONTENT, 150))
    FROM
      posts;
