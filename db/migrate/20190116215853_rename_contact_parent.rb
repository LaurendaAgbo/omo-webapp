class RenameContactParent < ActiveRecord::Migration[5.1]
  def change
    rename_column :reminders, :contact_parent, :parent_phone
  end
end
