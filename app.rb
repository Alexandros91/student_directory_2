require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'
require_relative 'lib/cohort'
require_relative 'lib/student'

DatabaseConnection.connect('student_directory_2')

cohort_repository = CohortRepository.new

cohort = cohort_repository.find_with_students(1)
student_names = cohort.students.map(&:name).join(', ')

puts "#{cohort.id} - #{cohort.name} - #{cohort.starting_date} has the following students: #{student_names}"

