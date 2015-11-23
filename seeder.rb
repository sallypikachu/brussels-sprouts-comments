require 'pg'
require 'pry'

TITLES = ["Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"]

#WRITE CODE TO SEED YOUR DATABASE AND TABLES HERE
# CREATE TABLE recipes (name VARCHAR(200));
# CREATE TABLE comments (comments VARCHAR(500), name VARCHAR(200));

def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end

def insert_recipe(array)
  array.each do |item|
    db_connection do |conn|
      conn.exec("INSERT INTO recipes (name) VALUES ($1);", [item])
    end
  end
end

# insert_recipe(TITLES)
def total_number_of_recipes
  total_number_of_recipes = db_connection do |conn|
    conn.exec("SELECT COUNT(*) FROM recipes;")
  end
  total_number_of_recipes.each {|x| puts "Total number of recipes: #{x["count"]}"}
end

def total_number_of_comments
  total_number_of_comments = db_connection do |conn|
    conn.exec("SELECT COUNT(*) FROM comments;")
  end
  total_number_of_comments.each {|x| puts "Total number of comments: #{x["count"]}"}
end

def recipe_comments(recipe)
  comments = db_connection do |conn|
    conn.exec("SELECT * FROM comments WHERE name = '#{recipe}';")
  end
  puts "#{recipe} comments:"
  comments.each { |comment| puts comment["comments"]}
end

def insert_comment(array)
  array.each do |item|
    db_connection do |conn|
      binding.pry
      conn.exec("INSERT INTO comments (comments, name) VALUES ($1, $2);", [item[0], item[1]])
    end
  end
end

comments = [
  ["Delicioso", "Brussels Sprouts with Goat Cheese"],
  ["Yum Yums", "Brussels Sprouts with Goat Cheese"],
]
# insert_comment(comments)

total_number_of_recipes
total_number_of_comments
recipe_comments('Brussels Sprouts with Goat Cheese')
