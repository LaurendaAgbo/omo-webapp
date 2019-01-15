class ChangeAdminColumnsName < ActiveRecord::Migration[5.1]
  def change
    rename_column :admins, :name, :first_name
    rename_column :admins, :nickname, :last_name
  end
end
