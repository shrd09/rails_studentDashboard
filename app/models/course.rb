class Course < ApplicationRecord
  belongs_to :teacher, foreign_key: 'user_id', primary_key: 'user_id'
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
end
