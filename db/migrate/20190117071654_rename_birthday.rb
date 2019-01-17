class RenameBirthday < ActiveRecord::Migration[5.1]
  def change
    rename_column :reminders, :bithday, :child_birthday
  end
end
