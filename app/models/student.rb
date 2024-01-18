class Student < ApplicationRecord
  belongs_to :user
  has_many :enrollments, foreign_key: 'user_id'
  has_many :courses, through: :enrollments
end
