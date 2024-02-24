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