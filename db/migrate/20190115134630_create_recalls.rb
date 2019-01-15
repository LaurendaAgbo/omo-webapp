class CreateRecalls < ActiveRecord::Migration[5.1]
  def change
    create_table :recalls do |t|
      t.string :parent_name
      t.string :child_name
      t.string :bithday
      t.string :contact_parent
      t.boolean :vaccine1
      t.boolean :vaccine2
      t.boolean :vaccine3
      t.boolean :vaccine4
      t.boolean :vaccine5

      t.timestamps
    end
  end
end
