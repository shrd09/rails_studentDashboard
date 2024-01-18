class ChangePhoneNoDataTypeInTeachers < ActiveRecord::Migration[6.0]
  def change
    change_column :teachers, :phone_no, :string
  end
end
