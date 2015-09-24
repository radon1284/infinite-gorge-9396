class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.integer :staff_id
      t.integer :client_id

      t.timestamps null: false
    end
    add_index :employments, :staff_id
    add_index :employments, :client_id
    add_index :employments, [:staff_id, :client_id], unique: true
  end
end
