class RemoveColumns < ActiveRecord::Migration
  def change
  	remove_column :clients, :initial_hrs, :float
  end
end
