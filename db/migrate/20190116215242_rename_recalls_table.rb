class RenameRecallsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :recalls, :reminders
  end
end
