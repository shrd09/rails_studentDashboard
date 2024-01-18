class Enrollment < ApplicationRecord
  belongs_to :student, foreign_key: 'user_id', primary_key: 'user_id'
  belongs_to :course

  validates :user_id, :course_id, presence: true
end
