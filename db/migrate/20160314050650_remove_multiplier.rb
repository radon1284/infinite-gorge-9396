class RemoveMultiplier < ActiveRecord::Migration
  def change
  	remove_column :employments, :multiplier, :float
  end
end
