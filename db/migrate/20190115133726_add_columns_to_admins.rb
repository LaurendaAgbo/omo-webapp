class AddColumnsToAdmins < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :centre_ps, :string
    add_column :admins, :contact, :string
  end
end
