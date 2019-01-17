class AddColumnToReminder < ActiveRecord::Migration[5.1]
  def change
    add_column :reminders, :admin_id, :integer
  end
end
