TRUNCATE TABLE cohorts, students RESTART IDENTITY;

INSERT INTO cohorts (name, starting_date) VALUES ('April 23', '10/04/2023');
INSERT INTO cohorts (name, starting_date) VALUES ('June 23', '12/06/2023');

INSERT INTO students (name, cohort_id) VALUES ('Ana Ivanovic', 1);
INSERT INTO students (name, cohort_id) VALUES ('Maria Sharapova', 2);
INSERT INTO students (name, cohort_id) VALUES ('Novak Djokovic', 2);
INSERT INTO students (name, cohort_id) VALUES ('Andy Murray', 1);