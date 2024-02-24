# Students Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:

students, student_name, cohort_name, cohort_starting_date, cohorts
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| students              | name
| cohorts               | name, starting_date

1. Name of the first table (always plural): `students` 

    Column names: `name`

2. Name of the second table (always plural): `cohorts` 

    Column names: `name`, `starting_date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: students
id: SERIAL
title: text


Table: cohorts
id: SERIAL
name: text
starting_date DATE
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one STUDENT have many COHORTS? NO
2. Can one COHORT have many STUDENTS? YES

You'll then be able to say that:

1. **COHORT has many STUDENTS**
2. And on the other side, **STUDENTS belongs to COHORTS**
3. In that case, the foreign key is in the table STUDENTS

Replace the relevant bits in this example with your own:


## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: students.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date DATE
);

-- Then the table with the foreign key first.
-- The foreign key name is always {other_table_singular}_id
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 student_directory_2 < students.sql
```