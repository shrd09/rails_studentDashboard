class RemoveForeignKeyFromCourses < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :courses, :teachers
  end
end
