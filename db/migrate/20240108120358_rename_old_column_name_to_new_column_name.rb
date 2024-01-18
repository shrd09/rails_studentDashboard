class RenameOldColumnNameToNewColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :courses, :teacher_id, :user_id
  end
end
