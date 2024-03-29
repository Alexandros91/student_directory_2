# Students Model and Repository Classes Design recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_student_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: seeds/students.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_id) VALUES ('Ana Ivanovic', 1);
INSERT INTO students (name, cohort_id) VALUES ('Maria Sharapova', 2);
INSERT INTO students (name, cohort_id) VALUES ('Novak Djokovic', 2);
INSERT INTO students (name, cohort_id) VALUES ('Andy Murray', 1);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 student_directory_2_test < seeds/students.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Student
end

# Repository class
# (in lib/student_repository.rb)
class StudentRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Student

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class StudentRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_id FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_id FROM students WHERE id = $1;

    # Returns a single student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(id)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = studentRepository.new

students = repo.all
students.length # =>  4

students[0].id # =>  1
students[0].name # =>  'Ana Ivanovic'
students[0].cohort_id # =>  1

students[1].id # =>  2
students[1].name # =>  'Maria Sharapova'
students[1].cohort_id # =>  2

students[2].id # =>  3
students[2].name # =>  'Novak Djokovic'
students[2].cohort_id # =>  2

students[3].id # =>  4
students[3].name # =>  'Andy Murray'
students[3].cohort_id # =>  1




# 2
# Get a single student

repo = studentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'Ana Ivanovic'
student.cohort_id # =>  1


student = repo.find(2)

student.id # =>  2
student.name # =>  'Maria Sharapova'
student.cohort_id # =>  2

student = repo.find(3)

student.id # =>  3
student.name # =>  'Novak Djokovic'
student.cohort_id # =>  2

student = repo.find(4)

student.id # =>  4
student.name # =>  'Andy Murray'
student.cohort_id # =>  1

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('seeds/students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students_directory_2_test' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->