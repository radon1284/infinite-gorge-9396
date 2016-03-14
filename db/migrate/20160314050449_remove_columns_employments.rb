class RemoveColumnsEmployments < ActiveRecord::Migration
  def change
  	remove_column :employments, :credits, :float
  end
end
