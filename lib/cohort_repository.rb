require_relative './cohort'
require_relative './student'

class CohortRepository

  def find_with_students(cohort_id)
    sql = 'SELECT cohorts.id AS "cohort_id",
		cohorts.name AS "cohort_name",
		starting_date,
		students.id AS "student_id",
		students.name AS "student_name"
		FROM cohorts
		JOIN students
		ON cohorts.id = students.cohort_id
		WHERE cohort_id = $1;'
    sql_params = [cohort_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    first_record = result_set[0]

    cohort = record_to_cohort_object(first_record)

    result_set.each do |record|
      cohort.students << record_to_student_object(record)
    end

    return cohort
  end

  private

  def record_to_cohort_object(record)
    cohort = Cohort.new
    cohort.id = record['cohort_id'].to_i
    cohort.name = record['cohort_name']
    cohort.starting_date = record['starting_date']
    
    return cohort
  end

  def record_to_student_object(record)
    student = Student.new
    student.id = record['student_id'].to_i
    student.name = record['student_name']
    
    return student
  end
end

c = CohortRepository.new
puts c.find_with_students(1)