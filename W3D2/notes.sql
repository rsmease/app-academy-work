-- DESIGNING A RELATIONAL DATABASE
--
-- Think about the uniquely relevant, defining features of your data set, organized around an ID, that will build out the "relational model" of your data set
--   In relational databases, relational models are modelled in 2D as row-column matrices where each row identifies a unique instance of the class in the data set and each column identifies a unique feature of each class instance
-- SQLite3 is great for lightway database operations; it's great for serverless database management
--   It will never be used in a production webapp beause it doesn't scale well and requires local storage on the user's device
-- Data Definition Language (DDL) defines the structure of our langauge
--   CREATE table; DROP table
-- Data Modification Language (DML) add, edit or delete data in our table
--   SELECT; INSERT; UPDATE; DELETE
--
-- DATABASE DEMO

CREATE TABLE plays (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL, --this is a required field
  year INTEGER NOT NULL, --this is a required filed
  playwright_id INTEGER NOT NULL

  FOREIGN KEY (playwright_id) REFERENCES playwrights(id)
);

CREATE TABLE playwrights (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  birth_year INTEGER
);

INSERT INTO
  playwrights(name, birth_year)
VALUES
  ('Arthur Miller', 1915),
  ('Eugene O''Neill', 1888); --Two single quotes to escape the single quote

INSERT INTO
  plays(title, year, playwright_id)
VALUES
  ('All My Songs', 1947 (SELECT id FROM playwrights WHERE name = 'Arthur Miller'))
  ('Long Day''s Journey Into Night', 1956 (SELECT id FROM playwrights WHERE name = 'Eugene O''Neill'));

-- OBJECT RELATIONAL MAPPING

-- Receiving a nested array of arrays wasn't very helpful, because it wasn't clear which data were attached to what variable name (col_name)
-- We can map these data onto a class!
--   To do this, we have to use the ::all keyword in the Class name in order to port the data of the database output into class instances via an options hash

class PlayDBConnection < PostrgreSQL::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true --retain the same data type
    self.results_as_hash = true --store the data as a hash
  end
end

class Play
  attr_accessor :title, year, playwright_id
  def self.all
    data = PlayDBConneciton.instance.execute("SELECT * FROM plays")
    data.map { |datum| PLay.new(datum) }
  end

  def initialize
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConneciton.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?) --sanitize the API against SQL injection attacks
    SQL
    --SQL injection attacks
    --playwright_id == "3; DROP TABLE plays"
    @id = PlayDBConneciton.instance.last_insert_row_id

    --here doc
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConneciton.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

-- SQLite3
--
-- SQLite3 is a very simple, public-domain implementation of SQL
-- SQLite3 is server less
--   There is no separate server proess that waits to receive queries from your application
--   The SQLite3 library is loaded by your program, which then directly interacts with the underlying database data
-- Because there is no servr, SQLite3 does not handle multiple simultaneous query requests very well
--   SQLite3 is rarely used for full production web applications
--   SQLite3 also has a very underpowered query planner (tool for figuring out how to query results in the right way)
-- Because of how easy it is to set up, SQLite3 is commonly used during the drafting process of web applications, where it can serve as a free, lightweight development database
-- SQLite3 is used where small, local storage makes sense; it's the database management tool behind every iOS application
-- Some faults of SQLite3:
--   Older versions do not enforce foreign key constraints
--   Dropping columns is a pain; you have to rebuild the whole table
--   SQLite3 is overly permissive

-- HEREDOCS
--
-- Heredocs allow us to inject SQL code into Ruby code...
        db.execute(<<-SQL, post_id)
        SELECT
          *
        FROM
          posts
        JOIN
          comments ON comments.post_id = posts.id
        WHERE
          posts.id = ?
        SQL
-- The question mark interpolateor will insert post_id, specified above
--   The disadvantage is that they have to be ordered precisely in the opening () of the Heredoc, because they are positionally dependent
--   On the otherhand, _not_ using the interpolators will render your code vulnerable to SQL injection attempts by escaping potentially malicious code for me

-- CSS DISPLAY PROPERTY
--
-- Display properties allow us to style the boxes in the CSS box model
--   The most important display properties are: none, block and inline
-- None is useful for when you want to put something onto your page but you want to hide it from view
--   None will prevent your box from being rendered
-- Block will overwrite the default to the block rendering of the box, which will take the full width of the page but only the minimum height of the content of the block
--   Block elements do not have margin
-- Inline will take up the minimum amount of height and width for the content
--   Inline follows the text flow
--   Inline will automatically use margin between other inline blocks
--   Inline elements are treated as words within a paragraph
--   Technically, inline just retains its line height, so if it's interspersed with a paragraph that has different line height and you add a background, it could make things look awkward
  -- Inline blocks is another option, which remain inline, but force elements around them to respect both vertical and horizontal space 
  -- CSS3 introduces a new display called flex, which will automatically adjust its boundary properties according to the shape of the page, based on specific inputs for the property (flex-direction)
