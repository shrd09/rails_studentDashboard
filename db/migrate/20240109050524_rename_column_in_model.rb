class RenameColumnInModel < ActiveRecord::Migration[6.0]
  def change
    rename_column :enrollments, :student_id, :user_id
  end
end
