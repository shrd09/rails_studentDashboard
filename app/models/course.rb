class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  has_many :teacher_courses
  has_many :teachers, through: :teacher_courses
end
