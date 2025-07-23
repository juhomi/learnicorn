class AddDefaultRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :role, 0  # 0 corresponds to :student in the enum
  end
end
