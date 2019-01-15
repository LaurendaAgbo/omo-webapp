class CreateAdminsRecalls < ActiveRecord::Migration[5.1]
  def change
    create_table :admins_recalls do |t|
      t.references :admin, foreign_key: true
      t.references :recall, foreign_key: true
    end
  end
end
