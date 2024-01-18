class User < ApplicationRecord
    before_save :downcase_email
    has_secure_password
    has_one :student, dependent: :destroy
    has_one :teacher, dependent: :destroy
    has_one :admin, dependent: :destroy
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :role, presence: true

    enum role: { student: 'student', teacher: 'teacher', admin: 'admin' }

    private

  def downcase_email
    self.email = email.downcase
  end
  
end
