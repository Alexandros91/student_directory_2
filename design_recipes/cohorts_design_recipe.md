# Cohorts Model and Repository Classes Design recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_cohort_template.md).

*In this template, we'll use an example table `cohorts`*

```
# EXAMPLE

Table: cohorts

Columns:
id | name | starting_date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: seeds/cohorts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohorts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, starting_date) VALUES ('April 2023', '10/04/2023');
INSERT INTO cohorts (name, starting_date) VALUES ('June 2023', '12/06/2023');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 student_directory_2_test < seeds/cohorts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: cohorts

# Model class
# (in lib/cohort.rb)
class Cohort
end

# Repository class
# (in lib/cohort_repository.rb)
class CohortRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: cohorts

# Model class
# (in lib/cohort.rb)

class Cohort

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :starting_date
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# cohort = cohort.new
# cohort.name = 'Jo'
# cohort.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: cohorts

# Repository class
# (in lib/cohort_repository.rb)

class CohortRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, starting_date FROM cohorts;

    # Returns an array of cohort objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, starting_date FROM cohorts WHERE id = $1;

    # Returns a single cohort object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(cohort)
  # end

  # def update(cohort)
  # end

  # def delete(id)
  # end

  # def find_with_students(student_id)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all cohorts

repo = CohortRepository.new

cohorts = repo.all
cohorts.length # =>  3

cohorts[0].id # =>  1
cohorts[0].name # =>  'April 2023'
cohorts[0].starting_date # =>  '10/04/2023'

cohorts[1].id # =>  2
cohorts[1].name # =>  'June 2023'
cohorts[1].starting_date # =>  '12/06/2023'


# 2
# Get a single cohort

repo = CohortRepository.new

cohort = repo.find(1)

cohort.id # =>  1
cohort.name # =>  'April 2023'
cohort.starting_date # =>  '10/04/2023'

cohort = repo.find(2)

cohort.id # =>  2
cohort.name # =>  'June 2023'
cohort.starting_date # =>  '12/06/2023'

# 3
# Get a single cohort with all students

repo = CohortRepository.new

cohort = repo.find_with_albums(1)

cohort.id # => 1
cohort.name # => 'Ana Ivanovic'
cohort.starting_date # => '10/04/2023'
cohort.students.length # => 2


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/cohort_repository_spec.rb

describe CohortRepository do
def reset_cohorts_table
  seed_sql = File.read('seeds/cohorts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_cohorts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->