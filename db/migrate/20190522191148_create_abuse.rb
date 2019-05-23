class CreateAbuse < ActiveRecord::Migration[5.1]
  def change
    create_table :abuses do |t|
      t.string :description
      t.string :address
      t.string :details
      t.string :contact
      t.string :photo

      t.timestamps
    end
  end
end
