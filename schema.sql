-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:

DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS comments;

-- Define your schema here:

CREATE TABLE recipes (name VARCHAR(200));
CREATE TABLE comments (
  comments VARCHAR(500),
  name VARCHAR(200)
);
