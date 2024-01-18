class Teacher < ApplicationRecord
  belongs_to :user 
  has_many :courses , foreign_key: 'user_id', dependent: :destroy
  # validates: phone_no, length: {minimum: 10}
end
