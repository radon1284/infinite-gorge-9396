class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.integer :staff_id
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
