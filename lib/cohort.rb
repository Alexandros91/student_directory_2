class Cohort

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :starting_date, :students

  def initialize
    @students = []
  end
end