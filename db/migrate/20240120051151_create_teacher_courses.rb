class CreateTeacherCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_courses do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :year

      t.timestamps
    end
  end
end
